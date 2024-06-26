USE [MillennialResort_DB]
GO
/****** Object:  StoredProcedure [dbo].[sp_activate_guest_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_activate_guest_by_id]
	(
		@GuestID		[nvarchar](17)
	)
AS
	BEGIN
		UPDATE 	[Guest]
		SET 	[Active] = 1
		WHERE	[GuestID] = @GuestID
		AND [Active] = 0

		RETURN @@ROWCOUNT
	END
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-05 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_activate_guest_by_id'

GO

/****** Object:  StoredProcedure [dbo].[sp_authenticate_user]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_authenticate_user]
	(
		@Email				[nvarchar](250),
		@PasswordHash		[nvarchar](100)
	)
AS
	BEGIN
		SELECT COUNT([EmployeeID])
		FROM [Employee]
		WHERE [Email] = @Email
			AND [PasswordHash] = @PasswordHash
			AND [Active] = 1
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_count_supplier_order]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_count_supplier_order]
AS
	BEGIN
		SELECT COUNT([SupplierOrderID])
		FROM [dbo].[SupplierOrder]
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_create_event_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_create_event_type]
    (
        @EventTypeID        [nvarchar](15),
        @Description        [nvarchar](1000) 
    )
AS
    BEGIN
        INSERT INTO [dbo].[EventType]
            ([EventTypeID], [Description])
        VALUES
            (@EventTypeID, @Description)

        RETURN @@ROWCOUNT
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_create_itemsupplier]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_create_itemsupplier]
	(
		@ItemID 			[int],
		@SupplierID			[int],
		@PrimarySupplier	[bit],
		@LeadTimeDays		[int],
		@UnitPrice			[money]
	)
AS
BEGIN
    UPDATE [dbo].[ItemSupplier]
    SET [PrimarySupplier] = 0
    WHERE [ItemID] = @ItemID
    
    INSERT INTO [dbo].[ItemSupplier]
    ([ItemID], [SupplierID], [PrimarySupplier], [LeadTimeDays], [UnitPrice])
    VALUES
    (@ItemID, @SupplierID, @PrimarySupplier, @LeadTimeDays, @UnitPrice)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_create_pet_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_create_pet_type]
    (
        @PetTypeID          [nvarchar](25),
        @Description        [nvarchar](1000)
    )
AS
    BEGIN
        INSERT INTO [dbo].[PetType]
            ([PetTypeID], [Description])
        VALUES
            (@PetTypeID, @Description)

        RETURN @@ROWCOUNT
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_create_reservation]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_create_reservation]
	(
		@MemberID 			[int],
		@NumberOfGuests		[int],
		@NumberOfPets		[int],
		@ArrivalDate 		[Date],
		@DepartureDate 		[Date],
		@Notes 				[nvarchar](1000)
	)
AS
	BEGIN
		INSERT INTO [Reservation]
		([MemberID],[NumberOfGuests],[NumberOfPets],[ArrivalDate],[DepartureDate],[Notes])
		VALUES
		(@MemberID, @NumberOfGuests, @NumberOfPets, @ArrivalDate, @DepartureDate, @Notes)
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_create_supplierOrder]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_create_supplierOrder]
	(
		@SupplierOrderID    [int],
		@EmployeeID    	    [int],
		@Description    	[nvarchar](50),
		@OrderComplete  	[bit],
		@DateOrdered 		[DateTime],
		@SupplierID			[int]

	)
AS
	BEGIN

		SET IDENTITY_INSERT [dbo].[SupplierOrder] ON

		INSERT INTO [dbo].[SupplierOrder]
			([SupplierOrderID], [EmployeeID],  [Description], [OrderComplete],
			 [DateOrdered], [SupplierID])
		VALUES
			(@SupplierOrderID, @EmployeeID, @Description, @OrderComplete,
			 @DateOrdered, @SupplierID)

		SET IDENTITY_INSERT [dbo].[SupplierOrder] OFF

		RETURN @@ROWCOUNT

	END

GO
/****** Object:  StoredProcedure [dbo].[sp_deactivate_employee]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_deactivate_employee]
	(
		@EmployeeID				[int]
	)
AS
	BEGIN
		UPDATE [Employee]
		SET [Active] = 0
		WHERE [EmployeeID] = @EmployeeID

		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_deactivate_guest_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_deactivate_guest_by_id]
	(
		@GuestID		[nvarchar](17)
	)
AS
	BEGIN
		UPDATE 	[Guest]
		SET 	[Active] = 0
		WHERE	[GuestID] = @GuestID

		RETURN @@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_deactivate_itemsupplier_by_itemid_and_supplierid]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_deactivate_itemsupplier_by_itemid_and_supplierid]
(
	@ItemID [int],
	@SupplierID [int]
)
AS
	BEGIN

		UPDATE		[ItemSupplier]
		SET [Active] = 0
		WHERE		[ItemID] = @ItemID AND [SupplierID] = @SupplierID
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_deactivate_member]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_deactivate_member]
(
@MemberID[int]
)
AS
BEGIN
UPDATE[Member]
Set[Active] = 0
WHERE[MemberID] = @MemberID
AND [Active] = 1

RETURN @@ROWCOUNT
END


GO
/****** Object:  StoredProcedure [dbo].[sp_deactivate_recipe]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_deactivate_recipe]
(
	@RecipeID [int]
)
AS
	BEGIN
		UPDATE [Recipe]
		SET
			[Active] = 0
		WHERE

			[RecipeID] = @RecipeID
			RETURN @@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_deactivate_reservation]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_deactivate_reservation]
	(
		@ReservationID 				[int]
	)
AS
	BEGIN
		UPDATE [Reservation]
			SET [Active] = 0
			WHERE
				[ReservationID] = @ReservationID
		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_deactivate_SupplierOrder]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_deactivate_SupplierOrder]
	(
		@SupplierOrderID		[int]
	)
AS
	BEGIN
		UPDATE  [SupplierOrder]
		SET 	[OrderComplete] = 0
		WHERE   [SupplierOrderID] = @SupplierOrderID

		RETURN @@ROWCOUNT
	END

GO
-- Eric Bostwick
-- Created: 3/7/2019
-- Deletes All SupplierOrderLines for a supplier order
CREATE Procedure [dbo].[sp_delete_supplier_order_lines]

	@SupplierOrderID [int]

As
    BEGIN
        DELETE FROM [SupplierOrderLine]
		WHERE [SupplierOrderID] = @SupplierOrderID
    END
GO

/****** Object:  StoredProcedure [dbo].[sp_delete_appointment_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_appointment_type]
	(
		@AppointmentTypeID	[nvarchar](15)	
	)
AS
	BEGIN
		DELETE  
		FROM 	[AppointmentType]
		WHERE 	[AppointmentTypeID] = @AppointmentTypeID
	  
		RETURN @@ROWCOUNT
	END

GO
-- Craig Barkley
-- Created: 2019-02-17
CREATE PROCEDURE [dbo].[sp_delete_appointment_type_by_id]
    (
        @AppointmentTypeID    [nvarchar](15)
    )
AS
    BEGIN
        DELETE
        FROM     [AppointmentType]
        WHERE     [AppointmentTypeID] = @AppointmentTypeID

        RETURN @@ROWCOUNT
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_department]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_department]
	(
		@DepartmentID			[nvarchar](50)	
	)
AS
	BEGIN
		DELETE  
		FROM 	[Department]
		WHERE 	[DepartmentID] = @DepartmentID
	  
		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_employee]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_employee]
	(
		@EmployeeID		[int]
	)

AS
	BEGIN
		DELETE
		FROM [Employee]
		WHERE [EmployeeID] = @EmployeeID
		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_employeeID_role]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_employeeID_role]
	(
		@EmployeeID		[int]
	)
AS
	BEGIN
		DELETE
		FROM [EmployeeRole]
		WHERE [EmployeeID] = @EmployeeID
		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_event]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_event]
(
	@EventID		[int]
)
AS
	BEGIN
		DELETE
		FROM	[Event]
		WHERE	[EventID] = @EventID
		AND		[Approved] = 0

		RETURN @@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_delete_event_type_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_event_type_by_id]
    (
        @EventTypeID        [nvarchar](15)
    )
AS
    BEGIN
        DELETE
        FROM    [EventType]
        WHERE    [EventTypeID] = @EventTypeID

        RETURN @@ROWCOUNT
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_guest_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_guest_by_id]
	(
		@GuestID		[int]
	)
AS
	BEGIN
		DELETE
		FROM	[Guest]
		WHERE	[GuestID] = @GuestID
		  AND	[Active] = 0

		RETURN @@ROWCOUNT
	END
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_delete_guest_by_id'

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_guest_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_guest_type]
	(
		@GuestTypeID			[nvarchar](25)	
	)
AS
	BEGIN
		DELETE  
		FROM 	[GuestType]
		WHERE 	[GuestTypeID] = @GuestTypeID
	  
		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_item_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_item_type]
	(
		@ItemTypeID			[nvarchar](15)	
	)
AS
	BEGIN
		DELETE  
		FROM 	[ItemType]
		WHERE 	[ItemTypeID] = @ItemTypeID
	  
		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_itemsupplier_by_itemid_and_supplierid]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_itemsupplier_by_itemid_and_supplierid]
(
	@ItemID [int],
	@SupplierID [int]
)
AS
	BEGIN
		DELETE
		FROM		[ItemSupplier]
		WHERE		[ItemID] = @ItemID AND [SupplierID] = @SupplierID

		RETURN @@ROWCOUNT
	END
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_delete_itemsupplier_by_itemid_and_supplierid'

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_maintenance_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_delete_maintenance_type]
	(
		@MaintenanceTypeID	[nvarchar](15)	
	)
AS
	BEGIN
		DELETE  
		FROM 	[MaintenanceType]
		WHERE 	[MaintenanceTypeID] = @MaintenanceTypeID
	  
		RETURN @@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_delete_member]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_member]
(
@MemberID [int]
)
AS
BEGIN
DELETE
FROM [MEMBER]
WHERE [MemberID] = @MemberID
AND [Active] = 0

RETURN @@ROWCOUNT
END


GO
/****** Object:  StoredProcedure [dbo].[sp_delete_offering_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_delete_offering_type]
	(
		@OfferingTypeID	[nvarchar](15)	
	)
AS
	BEGIN
		DELETE  
		FROM 	[OfferingType]
		WHERE 	[OfferingTypeID] = @OfferingTypeID
	  
		RETURN @@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_delete_performance]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_performance]
	(
		@PerformanceID	[int]
	)
AS
	BEGIN
		DELETE
		FROM [Performance]
		WHERE [PerformanceID] = @PerformanceID
		RETURN @@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_delete_pet]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_pet]
    (
        @PetID    [int]
    )
AS
    BEGIN
        DELETE
        FROM     [Pet]
        WHERE     [PetID] = @PetID

        RETURN @@ROWCOUNT
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_pet_type_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_pet_type_by_id]
    (
        @PetTypeID    [nvarchar](25)
    )
AS
    BEGIN
        DELETE
        FROM     [PetType]
        WHERE     [PetTypeID] = @PetTypeID

        RETURN @@ROWCOUNT
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_recipe]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_recipe]
(
	@RecipeID [int]
)
AS
	BEGIN
		DELETE FROM [Recipe]
		WHERE [RecipeID] = @RecipeID
		RETURN @@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_recipe_item_lines]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_recipe_item_lines]
(
	@RecipeID [int]
)
AS
	BEGIN
		DELETE FROM [RecipeItemLine]
		WHERE [RecipeID] = @RecipeID
		RETURN @@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_reservation]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_reservation]
	(
		@ReservationID 				[int]
	)
AS
	BEGIN
		DELETE
		FROM [Reservation]
		WHERE  [ReservationID] = @ReservationID
		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_roles]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_roles]
	(
		@RoleID				[nvarchar](50)	
	)
AS
	BEGIN
		DELETE  
		FROM 	[Role]
		WHERE 	[RoleID] = @RoleID
	  
		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_room_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_room_type]
	(
		@RoomTypeID			[nvarchar](15)	
	)
AS
	BEGIN
		DELETE  
		FROM 	[RoomType]
		WHERE 	[RoomTypeID] = @RoomTypeID
	  
		RETURN @@ROWCOUNT
	END


GO
-- Eric Bostwick
-- Created: 3/7/2019
-- Deletes A SupplierOrder
CREATE Procedure [dbo].[sp_delete_supplier_order]

	@SupplierOrderID [int]

As
    BEGIN
        DELETE FROM [SupplierOrder]
		WHERE [SupplierOrderID] = @SupplierOrderID
    END
GO

-- Created By: Wes Richardson
-- Created On: 2019-03-01
-- Insert new appointment
CREATE PROCEDURE [dbo].[sp_insert_appointment]
	(
	@AppointmentTypeID	[nvarchar](15),
	@GuestID			[int],
	@StartDate			[DateTime],
	@EndDate			[DateTime],
	@Description		[nvarchar](1000)
	)
AS
	BEGIN
		INSERT INTO [dbo].[Appointment]
			([AppointmentTypeID], [GuestID], [StartDate], [EndDate], [Description])
		VALUES
			(@AppointmentTypeID, @GuestID, @StartDate, @EndDate, @Description)
		SELECT SCOPE_IDENTITY()
	END
GO

/****** Object:  StoredProcedure [dbo].[sp_insert_appointment_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_insert_appointment_type]
	(
		@AppointmentTypeID	[nvarchar](15),
		@Description		[nvarchar](250)	
	)
AS
	BEGIN
		INSERT INTO [AppointmentType]
			([AppointmentTypeID], [Description])
		VALUES
			(@AppointmentTypeID, @Description)
			
		RETURN @@ROWCOUNT
		SELECT SCOPE_IDENTITY()
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_insert_building]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_insert_building]
	(
		@BuildingID			[nvarchar](50),
		@BuildingName		[nvarchar](150),
		@Address			[nvarchar](150),
		@Description		[nvarchar](1000),
		@BuildingStatusID	[nvarchar](25)
	)
AS
	BEGIN

		INSERT INTO [ResortProperty]
			([ResortPropertyTypeID])
		VALUES
			('Building')

		SELECT @@IDENTITY AS [@@IDENTITY]

		INSERT INTO [Building]
			([BuildingID],[BuildingName], [Address], [Description], [BuildingStatusID], [ResortPropertyID])
		VALUES
			(@BuildingID, @BuildingName, @Address, @Description, @BuildingStatusID, @@IDENTITY)

		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_department]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_department]
	(
		@DepartmentID		[nvarchar](50),
		@Description		[nvarchar](1000)	
	)
AS
	BEGIN
		INSERT INTO [Department]
			([DepartmentID], [Description])
		VALUES
			(@DepartmentID, @Description)
			
		RETURN @@ROWCOUNT
	END
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_insert_department'

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_employee]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_employee]
	(
		@FirstName		[nvarchar](50),
		@LastName		[nvarchar](100),
		@PhoneNumber 	[nvarchar](11),
		@Email			[nvarchar](250),
		@DepartmentID	[nvarchar](50)
	)
AS
	BEGIN
		INSERT INTO [Employee]
			([FirstName], [LastName], [PhoneNumber], [Email], [DepartmentID])
		VALUES
			(@FirstName, @LastName, @PhoneNumber, @Email, @DepartmentID)

		RETURN SCOPE_IDENTITY()
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_event]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- Updated Phillip Hansen 2019-03-22
-- Update Author: Phillip Hansen
-- Date Updated: 2019-04-09
CREATE PROCEDURE [dbo].[sp_insert_event]
(
		@EventTitle 	[nvarchar](50),
		@EmployeeID		[int],
		@EventTypeID 	[nvarchar](15),
		@Description 	[nvarchar](1000),
		@EventStartDate [date],
		@EventEndDate 	[date],
		@KidsAllowed 	[bit],
		@SeatsRemaining [int],
		@NumGuests 		[int],
		@Location 		[nvarchar](50),
		@PublicEvent 	[bit],
		@Sponsored		[bit],
		@Approved 		[bit],
		@Price			[money]
)
AS
	BEGIN
		INSERT INTO [dbo].[Offering]
		([OfferingTypeID],[EmployeeID],[Description],[Price])
		VALUES
		('Event', @EmployeeID, @Description, @Price)
		DECLARE @NewOfferingID [int] = (SELECT @@IDENTITY)
	
		INSERT INTO [dbo].[Event]
			([OfferingID]
			,[EventTitle]
			,[EmployeeID]
			,[EventTypeID]
			,[Description]
			,[EventStartDate]
			,[EventEndDate]
			,[KidsAllowed]
			,[SeatsRemaining]
			,[NumGuests]
			,[Location]
			,[PublicEvent]
			,[Sponsored]
			,[Approved])
			VALUES
			(@NewOfferingID
			,@EventTitle
			,@EmployeeID
			,@EventTypeID
			,@Description
			,@EventStartDate
			,@EventEndDate
			,@KidsAllowed
			,@SeatsRemaining
			,@NumGuests
			,@Location
			,@PublicEvent
			,@Sponsored
			,@Approved
			)

			RETURN SCOPE_IDENTITY()
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_event_request]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_event_request]
	(
		@EventTitle					[nvarchar](50),
		@EmployeeID			 		[int],
		@EventTypeID				[nvarchar](15),
		@Description				[nvarchar](1000),
		@EventStartDate				[date],
		@EventEndDate				[date],
		@KidsAllowed				[bit],
		@NumGuests					[int],
		@Location					[nvarchar](50),
		@Sponsored					[bit],
		@Approved					[bit]

	)
AS
	BEGIN
		INSERT INTO [dbo].[Event]
			([EventTitle],[EmployeeID],[EventTypeID],[Description],[EventStartDate],[EventEndDate],[KidsAllowed],[NumGuests], [Location], [Sponsored], [Approved])
			VALUES
			(@EventTitle, @EmployeeID, @EventTypeID, @Description, @EventStartDate, @EventEndDate, @KidsAllowed, @NumGuests, @Location, @Sponsored, @Approved )

			RETURN @@ROWCOUNT
	END


GO
CREATE PROCEDURE [dbo].[sp_insert_event_sponsor]
	(
		@EventID		[int],
		@SponsorID		[int]
	)
AS
	BEGIN	
		
		INSERT INTO 	[EventSponsor]
			([EventID], [SponsorID])
		VALUES
			(@EventID, @SponsorID)
		
		RETURN @@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_event_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_event_type]
	(
		@EventTypeID	    [nvarchar](15),
		@Description		[nvarchar](1000)


	)
AS
	BEGIN
		INSERT INTO [dbo].[EventType]
			([EventTypeID], [Description])
		VALUES
			(@EventTypeID, @Description)

		RETURN @@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_insert_guest]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_insert_guest]
	(
		@MemberID				[int],
		@GuestTypeID			[nvarchar](25),
		@FirstName				[nvarchar](50),
		@LastName				[nvarchar](100)	,
		@PhoneNumber			[nvarchar](11),
		@Email					[nvarchar](250),
		@Minor					[bit],
		@ReceiveTexts			[bit],
		@EmergencyFirstName		[nvarchar](50),
		@EmergencyLastName		[nvarchar](100),
		@EmergencyPhoneNumber	[nvarchar](11),
		@EmergencyRelation		[nvarchar](25)
	)
AS
	BEGIN
		INSERT INTO [dbo].[Guest]
			([MemberID], [GuestTypeID], [FirstName], 
			[LastName], [PhoneNumber], [Email], [Minor], 
			[ReceiveTexts], [EmergencyFirstName], [EmergencyLastName],
			[EmergencyPhoneNumber], [EmergencyRelation])
		VALUES
			(@MemberID, @GuestTypeID, @FirstName, @LastName,
			@PhoneNumber, @Email, @Minor, @ReceiveTexts, @EmergencyFirstName,
			@EmergencyLastName, @EmergencyPhoneNumber, @EmergencyRelation)
			
		RETURN @@ROWCOUNT
	END		

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_guest_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_guest_type]
	(
		@GuestTypeID		[nvarchar](25),
		@Description		[nvarchar](1000)
	)
AS
	BEGIN
		INSERT INTO [GuestType]
			([GuestTypeID], [Description])
		VALUES
			(@GuestTypeID, @Description)
			
		RETURN @@ROWCOUNT
	END
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_insert_guest_type'

GO
/*
 * Author: Richard Carroll
 * Created: 2019/3/1
 */
Create Procedure [dbo].[sp_insert_guest_vehicle]
(
    @GuestID           [int],
    @Make              [nvarchar](30),
    @Model             [nvarchar](30),
    @PlateNumber       [nvarchar](10),
    @Color             [nvarchar](30),
    @ParkingLocation   [nvarchar](50)
)
AS 
    BEGIN
        Insert into [GuestVehicle]
        ([GuestID], [Make], [Model], [PlateNumber], [Color], [ParkingLocation])
        Values (@GuestID, @Make, @Model, @PlateNumber, @Color, @ParkingLocation)
        Return @@Rowcount
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_item]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_insert_item]

@ItemID int OUTPUT,
@ItemTypeID nvarchar(15),
@Description nvarchar(1000),
@OnHandQty int,
@Name nvarchar(50),
@ReorderQty int,
@DateActive DateTime

AS
BEGIN

INSERT INTO [Item]([ItemTypeID], [Description], [OnHandQty], [Name],[ReorderQty], [DateActive])
              VALUES(@ItemTypeID, @Description, @OnHandQty, @Name, @ReorderQty, @DateActive)

			  SET @ItemID = SCOPE_IDENTITY()

			  RETURN SCOPE_IDENTITY()
END



GO
/****** Object:  StoredProcedure [dbo].[sp_insert_item_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_item_type]
	(
		@ItemTypeID			[nvarchar](15),
		@Description		[nvarchar](1000)	
	)
AS
	BEGIN
		INSERT INTO [ItemType]
			([ItemTypeID], [Description])
		VALUES
			(@ItemTypeID, @Description)
			
		RETURN @@ROWCOUNT
	END
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_insert_item_type'

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_maintenance_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_maintenance_type]
	(
		@MaintenanceTypeID	[nvarchar](15),
		@Description		[nvarchar](1000)	
	)
AS
	BEGIN
		INSERT INTO [MaintenanceType]
			([MaintenanceTypeID], [Description])
		VALUES
			(@MaintenanceTypeID, @Description)
			
		RETURN @@ROWCOUNT
	END
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_insert_maintenance_type'

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_member]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_member]
(
@FirstName[nvarchar](50),
@LastName[nvarchar](100),
@PhoneNumber[nvarchar](11),
@Email[nvarchar](250),
@Password[nvarchar](100)
)
AS
BEGIN
INSERT INTO [dbo].[Member]
([FirstName],[LastName],[PhoneNumber],[Email],[PasswordHash])
VALUES
(@FirstName,@LastName, @PhoneNumber, @Email,@Password)

RETURN @@ROWCOUNT
END


GO
/****** Object:  StoredProcedure [dbo].[sp_insert_offering]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_offering]
	(
		@OfferingTypeID [nvarchar](15),
		@EmployeeID 	[int],
		@Description 	[nvarchar](1000),
		@Price			[Money]
	)
AS
	BEGIN
		INSERT INTO [Offering]
		([OfferingTypeID],[EmployeeID],[Description],[Price])
		VALUES
		(@OfferingTypeID, @EmployeeID, @Description, @Price)
		SELECT SCOPE_IDENTITY();
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_offering_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_offering_type]
	(
		@OfferingTypeID		[nvarchar](15),
		@Description		[nvarchar](1000)	
	)
AS
	BEGIN
		INSERT INTO [OfferingType]
			([OfferingTypeID], [Description])
		VALUES
			(@OfferingTypeID, @Description)
			
		RETURN @@ROWCOUNT
	END
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_insert_offering_type'

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_performance]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_performance]
	(
		@PerformanceName	[nvarchar](100),
		@PerformanceDate	[date],
		@Description		[nvarchar](1000)
	)
AS
	BEGIN
		INSERT INTO [dbo].[Performance]
			([PerformanceTitle], [PerformanceDate], [Description])
		VALUES
			(@PerformanceName, @PerformanceDate, @Description)
	END
GO
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Jacob Miller',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_insert_performance'
GO
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Desc',
	@value=N'Added PerformanceTitle support',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_insert_performance'
GO
-- Updated By: Matt Hill
-- Updated On: 2019-03-17
CREATE PROCEDURE sp_insert_pet
	(
		@PetName				    [nvarchar](50),
		@Gender      				[nvarchar](50),
		@Species     				[nvarchar](50),
		@PetTypeID				    [nvarchar](25),
		@GuestID				    [int]		
	)
AS
	BEGIN
		INSERT INTO [dbo].[Pet]
			([PetName],[Gender], [Species], [PetTypeID],[GuestID])
			VALUES
			(@PetName, @Gender, @Species, @PetTypeID, @GuestID)
			
			SELECT SCOPE_IDENTITY() 
	END
GO
EXEC sys.sp_addextendedproperty
	@name = N'Author'
	,@value = N'Craig Barkley'
	,@level0type = N'Schema', @level0name = 'dbo'
	,@level1type = N'Procedure', @level1name = 'sp_insert_pet'
GO
EXEC sys.sp_addextendedproperty
	@name = N'Created Date'
	,@value = N'2019-02-17'
	,@level0type = N'Schema', @level0name = 'dbo'
	,@level1type = N'Procedure', @level1name = 'sp_insert_pet'
GO
EXEC sys.sp_addextendedproperty
	@name = N'Update 2019-03-09 Author'
	,@value = N'Austin Delaney'
	,@level0type = N'Schema', @level0name = 'dbo'
	,@level1type = N'Procedure', @level1name = 'sp_insert_pet'
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_product]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_product]
(
	@ItemTypeID			[nvarchar](15),
	@Description		[nvarchar](1000),
	@OnHandQuantity		[int],
	@Name				[nvarchar](50),
	@ReOrderQuantity	[int],
	@DateActive			[date]
)
AS
	BEGIN
		INSERT INTO [Item]
			([ItemTypeID],[Description], [OnHandQty], [Name], [ReOrderQty], [DateActive])
		VALUES
			(@ItemTypeID, @Description, @OnHandQuantity, @Name, @ReOrderQuantity, @DateActive)
		RETURN @@ROWCOUNT
	END
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_insert_product'

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_recipe]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_recipe]
	(
		@Name 			[nvarchar](50),
		@Description 	[nvarchar](1000)
	)
AS
	BEGIN
		INSERT INTO [Recipe]
		([Name], [Description])
		VALUES
		(@Name, @Description)
		SELECT SCOPE_IDENTITY();
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_recipe_item_line]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_recipe_item_line]
	(
		@RecipeID 		[int],
		@ItemID 		[int],
		@Quantity		[nvarchar](10),
		@UnitOfMeasure 	[nvarchar](25)
	)
AS
	BEGIN
		INSERT INTO [RecipeItemLine]
		([RecipeID], [ItemID], [Quantity], [UnitOfMeasure])
		VALUES
		(@RecipeID, @ItemID, @Quantity, @UnitOfMeasure)
		RETURN @@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_insert_roles]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_roles]
(
@RoleID[nvarchar](50),
@Description[nvarchar](1000)
)
AS
BEGIN
INSERT INTO [Role]
([RoleID], [Description])
VALUES
(@RoleID, @Description)

RETURN @@ROWCOUNT
END
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_insert_roles'

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_room]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 	Created By:  Wes 
	Created: 
	Updated: Danielle Russo
			03/28/2019
			Added Price field
			Added ResortPropertyID 
*/ 
CREATE PROCEDURE [dbo].[sp_insert_room]
	(
	@RoomNumber			[nvarchar](15),
	@BuildingID			[nvarchar](50),
	@RoomTypeID			[nvarchar](15),
	@Description		[nvarchar](1000),
	@Capacity			[int],
	@RoomStatusID		[nvarchar](25),
	
	@OfferingTypeID		[nvarchar](15),
	@EmployeeID			[int],
	@Price				[Money]
	)
AS
	BEGIN
		INSERT INTO [ResortProperty]
			([ResortPropertyTypeID])
		VALUES
			('Room')
		DECLARE @NewResortProperyID [int] = (SELECT @@IDENTITY)

		INSERT INTO [Offering]	
		([OfferingTypeID],[EmployeeID],[Description],[Price])
		VALUES
		(@OfferingTypeID, @EmployeeID, @Description, @Price)	
		DECLARE @NewOfferingID [int] = (SELECT @@IDENTITY)
		
		
		INSERT INTO [dbo].[Room]
			([RoomNumber], [BuildingID], [RoomTypeID], [Description], [Capacity], [RoomStatusID],[OfferingID],[ResortPropertyID])
		VALUES
			(@RoomNumber, @BuildingID, @RoomTypeID, @Description, @Capacity, @RoomStatusID, @NewOfferingID, @NewResortProperyID)	
		RETURN @@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_room_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_room_type]
	(
		@RoomTypeID			[nvarchar](15),
		@Description		[nvarchar](1000)	
	)
AS
	BEGIN
		INSERT INTO [RoomType]
			([RoomTypeID], [Description])
		VALUES
			(@RoomTypeID, @Description)
			
		RETURN @@ROWCOUNT
	END
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_insert_room_type'

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_shop]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_insert_shop]
(
@ShopID [int] OUTPUT,
@RoomID[int],
@Name[nvarchar](50),
@Description[nvarchar](100)
)
AS
BEGIN
INSERT INTO [dbo].[Shop]
([RoomID], [Name], [Description])
VALUES
(@RoomID, @Name, @Description)

SET @ShopID = SCOPE_IDENTITY()

RETURN SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_supplier]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_insert_supplier]
	(
		@Name 				nvarchar(50),
		@Address 			nvarchar(150),
		@City				nvarchar(50),
		@State				nchar(2),
		@PostalCode				nvarchar(12),
		@Country			nvarchar(25),
		@PhoneNumber		nvarchar(11),
		@Email				nvarchar(50),
		@ContactFirstName	nvarchar(50),
		@ContactLastName	nvarchar(100),
		@Description		nvarchar(1000)
	)
AS
	BEGIN
		INSERT INTO [dbo].[Supplier]
		([Name], [Address], [City], [State], [PostalCode], [Country], [PhoneNumber], [Email], [ContactFirstName], [ContactLastName], [Description])
		VALUES
			(@Name, @Address, @City, @State, @PostalCode, @Country, @PhoneNumber, @Email, @ContactFirstName, @ContactLastName, @Description)
		RETURN SCOPE_IDENTITY();
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_insert_supplier_order]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_supplier_order]
(
@SupplierOrderID[int] OUTPUT,
@SupplierID[int],
@EmployeeID[int],
@Description[nvarchar](1000)
)
AS
BEGIN
INSERT INTO [dbo].[SupplierOrder] ([SupplierID], [EmployeeID], [Description])
 VALUES (@SupplierID,@EmployeeID, @Description)

SET @SupplierOrderID = SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_supplier_order_line]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_supplier_order_line]
(
@SupplierOrderID[int],
@ItemID[int],
@Description[nvarchar](1000),
@OrderQty[int],
@UnitPrice[money]
)
AS
BEGIN
INSERT INTO [dbo].[SupplierOrderLine] ([SupplierOrderID], [ItemID], [Description], [OrderQty], [UnitPrice])
 VALUES (@SupplierOrderID, @ItemID, @Description, @OrderQty, @UnitPrice)
END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_work_order]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_work_order]
(
@MaintenanceWorkOrderID[int],
@MaintenanceTypeID[nvarchar](15),
@DateRequested[Date],
@DateCompleted [Date],
@RequestingEmployeeID[int],
@WorkingEmployeeID[int],
@Description[nvarchar](1000),
@Comments [nvarchar](1000),
@MaintenanceStatus[nvarchar](50),
@ResortPropertyID[int],
@Complete[bit]
)
AS
BEGIN
INSERT INTO [MaintenanceWorkOrder]
([MaintenanceWorkOrderID], [MaintenanceTypeID], [DateRequested], [DateCompleted], [RequestingEmployeeID], 
[WorkingEmployeeID], [Description], [Comments], [MaintenanceStatus], [ResortPropertyID], [Complete])
VALUES
(@MaintenanceWorkOrderID, @MaintenanceTypeID, @DateRequested, @DateCompleted, @RequestingEmployeeID, 
@WorkingEmployeeID, @Description, @Comments, @MaintenanceStatus, @ResortPropertyID, @Complete )
  
RETURN @@ROWCOUNT
END


GO
/****** Object:  StoredProcedure [dbo].[sp_reactivate_recipe]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_reactivate_recipe]
(
	@RecipeID [int]
)
AS
	BEGIN
		UPDATE [Recipe]
		SET
			[Active] = 1
		WHERE

			[RecipeID] = @RecipeID
			RETURN @@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_retireve_all_event_requests]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retireve_all_event_requests]
AS
	BEGIN
		SELECT [EventTitle], [EventTypeID],[Description],[EventStartDate],
				[EventEndDate],[KidsAllowed],[NumGuests], [Location], [Sponsored], [Approved]
		FROM	[dbo].[Event]
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_event_type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_all_event_type]
AS
    BEGIN
        SELECT [EventTypeID], [Description]
        FROM   [EventType]
        ORDER BY [EventTypeID]
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_event_types]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_all_event_types]
AS
	BEGIN
		SELECT [EventTypeID]
		FROM	[dbo].[EventType]
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_events]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- Updated Phillip Hansen 2019-03-22
CREATE PROCEDURE [dbo].[sp_retrieve_all_events]
AS
	BEGIN
		SELECT
		[EventID],
		[OfferingID],
		[EventTitle],
		[Event].[EmployeeID],
		[Employee].[FirstName],
		[EventTypeID] AS [EventType],
		[Description],
		[EventStartDate],
		[EventEndDate],
		[KidsAllowed],
		[NumGuests],
		[SeatsRemaining],
		[Location],
		[Sponsored],
		[Approved],
		[PublicEvent]
		FROM	[dbo].[Event] INNER JOIN [dbo].[Employee]
			ON		[Employee].[EmployeeID] = [Event].[EmployeeID]
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_members]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_retrieve_all_members]
AS
	BEGIN
		SELECT [MemberID],[FirstName],[LastName],[PhoneNumber],[Email],[Active]
		FROM Member
		WHERE [Active] = 1
	END


GO
CREATE PROCEDURE sp_retrieve_all_pets
AS
    BEGIN
        SELECT [PetID],[PetName], [Gender], [Species], [PetTypeID], [GuestID]
        FROM   [Pet]
        ORDER BY [PetID]
    END
GO
EXEC sys.sp_addextendedproperty
	@name = N'Author'
	,@value = N'Craig Barkley'
	,@level0type = N'Schema', @level0name = 'dbo'
	,@level1type = N'Procedure', @level1name = 'sp_retrieve_all_pets'
GO
EXEC sys.sp_addextendedproperty
	@name = N'Created Date'
	,@value = N'2019-02-17'
	,@level0type = N'Schema', @level0name = 'dbo'
	,@level1type = N'Procedure', @level1name = 'sp_retrieve_all_pets'
GO
EXEC sys.sp_addextendedproperty
	@name = N'Update 2019-03-09 Author'
	,@value = N'Austin Delaney'
	,@level0type = N'Schema', @level0name = 'dbo'
	,@level1type = N'Procedure', @level1name = 'sp_retrieve_all_pets'
GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_reservations]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_all_reservations]
AS
	BEGIN
		SELECT [ReservationID],[MemberID],[NumberOfGuests],[NumberOfPets],[ArrivalDate],[DepartureDate],[Notes],[Active]
		FROM Reservation
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_supplier_order]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_retrieve_all_supplier_order]
AS
	BEGIN

		SELECT [SupplierOrderID],[EmployeeID],[SupplierID],[Description],[OrderComplete],
			   [DateOrdered]
		FROM [dbo].[SupplierOrder]
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_view_model_reservations]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_all_view_model_reservations]
AS
	BEGIN
		SELECT [Reservation].[ReservationID],
		[Reservation].[MemberID],
		[Reservation].[NumberOfGuests],
		[Reservation].[NumberOfPets],
		[Reservation].[ArrivalDate],
		[Reservation].[DepartureDate],
		[Reservation].[Notes],
		[Reservation].[Active],
		[Member].[FirstName],
		[Member].[LastName],
		[Member].[PhoneNumber],
		[Member].[Email]
		FROM Reservation INNER JOIN Member ON Reservation.MemberID = Member.MemberID
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_appointment_types]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_appointment_types]
AS
	BEGIN
		SELECT [AppointmentTypeID], [Description]
		FROM AppointmentType
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_buildings]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_retrieve_buildings]
AS
	BEGIN
		SELECT [BuildingID], [Description]
		FROM Building
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_departments]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_retrieve_departments]
AS
	BEGIN
		SELECT [DepartmentID], [Description]
		FROM Department
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_departmentTypes]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_departmentTypes]
AS
	BEGIN
		SELECT [DepartmentID]
		FROM Department
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_employee_by_email]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_employee_by_email]
(
	@Email 		[nvarchar](250)
)
AS
	BEGIN
		SELECT [EmployeeID], [FirstName], [LastName], [Email], [PhoneNumber], [DepartmentID], [Active]
		FROM [Employee]
		WHERE [Email] = @Email
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_employee_roles]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_retrieve_employee_roles]
	(
		@Email					[nvarchar](250)

	)
AS
	BEGIN
		SELECT [RoleID]
		FROM [EmployeeRole]
		INNER JOIN [Employee]
			ON [EmployeeRole].[EmployeeID] = [Employee].[EmployeeID]
		WHERE [Email] = @Email
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_event]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- Updated Phillip Hansen 2019-03-22
-- Updated By: Phillip Hansen
-- Update Date: 2019-04-09
CREATE PROCEDURE [dbo].[sp_retrieve_event]
	(
		@EventID [int]
	)
AS
	BEGIN
		SELECT  [EventID],
				[Event].[OfferingID],
				[EventTitle],
				[Event].[EmployeeID],
				[Employee].[FirstName],
				[EventTypeID],
				[Event].[Description],
				[EventStartDate],
				[EventEndDate],
				[KidsAllowed],
				[NumGuests],
				[SeatsRemaining],
				[Location],
				[Sponsored],
				[Approved],
				[PublicEvent],
				[Price]
		FROM	[dbo].[Employee] INNER JOIN [dbo].[Event]
		ON		[Employee].[EmployeeID] = [Event].[EmployeeID]
		INNER JOIN [dbo].[Offering]
		ON		[Offering].[OfferingID] = [Event].[OfferingID]
		WHERE	[EventID] = @EventID
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_guest_types]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_retrieve_guest_types]
AS
	BEGIN
		SELECT [GuestTypeID], [Description]
		FROM GuestType
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_guests_by_email]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_retrieve_guests_by_email]
	(
		@Email				[nvarchar](250)
	)
AS
	BEGIN
		SELECT [GuestID], [MemberID], [GuestTypeID], [FirstName], 
			   [LastName], [PhoneNumber], [Email], 
			   [Minor], [Active], [ReceiveTexts], [EmergencyFirstName], 
			   [EmergencyLastName], [EmergencyPhoneNumber], [EmergencyRelation]
		FROM   [Guest]
		WHERE 	[Email] = @Email
		AND		[Active] = 1
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_guests_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_guests_by_id]
	(
		@GuestID				[int]
	)
AS
	BEGIN
		SELECT [GuestID], [MemberID], [GuestTypeID], [FirstName], 
			   [LastName], [PhoneNumber], [Email], 
			   [Minor], [Active],[ReceiveTexts], [EmergencyFirstName], 
			   [EmergencyLastName], [EmergencyPhoneNumber], [EmergencyRelation], [CheckedIn]
		FROM   [Guest]
		WHERE 	[GuestID] = @GuestID
		AND		[Active] = 1
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_guests_by_name]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_retrieve_guests_by_name]
	(
		@FirstName			[nvarchar](50),
		@LastName			[nvarchar](100)
	)
AS
	BEGIN
		SELECT [GuestID], [MemberID], [GuestTypeID], [FirstName], 
			   [LastName], [PhoneNumber], [Email], 
			   [Minor], [Active], [ReceiveTexts], [EmergencyFirstName], 
			   [EmergencyLastName], [EmergencyPhoneNumber], [EmergencyRelation]
		FROM   [Guest]
		WHERE	[FirstName] LIKE '%' + @FirstName + '%'
		  AND	[LastName] LIKE '%' + @LastName + '%'
		ORDER BY [GuestID], [Active]
	END

GO
/*
 * Author: Richard Carroll
 * Created: 2019/3/1
 */
Create Procedure [dbo].[sp_retrieve_guest_names_and_ids]
AS
    BEGIN
        Select [FirstName], [LastName], [GuestID]
        From Guest
        Where Active = 1
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_guestTypes]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_guestTypes]
AS
	BEGIN
		SELECT [GuestTypeID]
		FROM GuestType
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_item_types]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[sp_retrieve_item_types]
AS
	BEGIN
		SELECT [ItemTypeID], [Description]
		FROM ItemType
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_itemtypes]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_retrieve_itemtypes]
AS
	BEGIN
		SELECT [ItemTypeID]
		FROM [ItemType]
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_List_of_EmployeeID]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_List_of_EmployeeID]
AS
	BEGIN
		SELECT [EmployeeID]
		FROM [dbo].[EmployeeRole]
		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_maintenance_types]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_retrieve_maintenance_types]
AS
	BEGIN
		SELECT [MaintenanceTypeID], [Description]
		FROM MaintenanceType
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_member_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
 CREATE PROCEDURE [dbo].[sp_retrieve_member_by_id]
 (
@MemberID int
 )
 AS 
BEGIN
SELECT[MemberID], [FirstName], [LastName], [PhoneNumber], [Email],[Active]
FROM [MEMBER]
WHERE [MemberID] = @MemberID
END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_offering_types]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_retrieve_offering_types]
AS
	BEGIN
		SELECT [OfferingTypeID], [Description]
		FROM OfferingType
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_roleID]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_roleID]
AS
	BEGIN
		SELECT [RoleID]
		FROM Role
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_roles]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_retrieve_roles]
AS
	BEGIN
		SELECT [RoleID], [Description]
		FROM Role
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_roles_by_term_in_description]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_retrieve_roles_by_term_in_description]
(
@SearchTerm[nvarchar](250)
)
AS
BEGIN
SELECT [RoleID],  [Description]
FROM [Role]
WHERE [Description] LIKE '%' + @SearchTerm + '%'
END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_room_types]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_retrieve_room_types]
AS
	BEGIN
		SELECT [RoomTypeID], [Description]
		FROM RoomType
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_roomTypes]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_retrieve_roomTypes]
AS
	BEGIN
		SELECT [RoomTypeID]
		FROM RoomType
	END


GO
-- NAME:  Eduardo Colon
-- Date:   2019-03-05
CREATE PROCEDURE [dbo].[sp_retrieve_setuplist_by_id]
	(
		@SetupListID				[int]
	)
AS
	BEGIN
		SELECT [SetupListID], [SetupID],[Completed],[Description], [Comments]
		FROM [SetupList]
		WHERE [SetupListID] = @SetupListID
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_suppliers]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_suppliers]

AS
	BEGIN
		SELECT 	    [SupplierID], [Name], [ContactFirstName], [ContactLastName],	[PhoneNumber], [Email], [DateAdded], [Address], [City], [State], [Country], [PostalCode], [Description], [Active]
		FROM		[Supplier]
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_user_names_by_email]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_retrieve_user_names_by_email]
	(
		@Email				[nvarchar](250)
	)
AS
	BEGIN
		SELECT [EmployeeID], [FirstName], [LastName]
		FROM Employee
		WHERE [Email] = @Email
	END


GO

CREATE PROCEDURE [dbo].[sp_search_performances]
	(
		@SearchTerm		[nvarchar](100)
	)
AS
	BEGIN
		SELECT [PerformanceID], [PerformanceTitle], [PerformanceDate], [Description]
		FROM [Performance]
		WHERE [PerformanceTitle] LIKE '%' + @SearchTerm + '%'
		OR [Description] LIKE '%' + @SearchTerm + '%'
	END
GO
EXEC sys.sp_addextendedproperty
	@name=N'Author',
	@value=N'Jacob Miller',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_search_performances'
GO
EXEC sys.sp_addextendedproperty
	@name=N'Created Date',
	@value=N'2019-03-06',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_search_performances'
GO
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-09 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_search_performances'
GO
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-09 Desc',
	@value=N'Added searching description support',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_search_performances'
GO

/****** Object:  StoredProcedure [dbo].[sp_select_all_active_items]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_all_active_items]
AS
	BEGIN
		SELECT [ItemID], [ItemTypeID], [Description], [OnHandQty], [Name], [ReorderQty], [DateActive], [Active]
		FROM [Item]
		WHERE [Active] = 1
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_select_all_active_items_extended]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_all_active_items_extended]
	AS
		BEGIN
		SELECT [ItemID], [ItemTypeID], [Description], [OnHandQuantity], [Name], [ReOrderQuantity], [DateActive], [Active], [CustomerPurchasable], [RecipeID]
		FROM	[Product]
		WHERE [Active] =1
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_all_deactivated_items]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_all_deactivated_items]
	AS
		BEGIN
		SELECT [ItemID], [ItemTypeID], [Description], [OnHandQuantity], [Name], [ReOrderQuantity], [DateActive], [Active], [CustomerPurchasable], [RecipeID]
		FROM	[Product]
		WHERE [Active] =0
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_all_employees]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_all_employees]
AS
	BEGIN
		SELECT  [EmployeeID], [FirstName], [LastName], [PhoneNumber], [Email], [DepartmentID], [Active]
		FROM 	[Employee]
	END

GO

/*
 * Author: Richard Carroll
 * Created: 2019/3/8
 */
Create Procedure [dbo].[sp_select_all_guest_vehicles]
AS
    BEGIN
        Select [FirstName], [LastName], [Guest].[GuestID], [Make], [Model],
        [PlateNumber], [Color], [ParkingLocation]
        From GuestVehicle Inner Join Guest on 
        [Guest].[GuestID] = [GuestVehicle].[GuestID]
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_select_all_item_types]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_all_item_types]
AS
	BEGIN
		SELECT [ItemTypeID], [Description]
		FROM [ItemType]
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_select_all_items]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_all_items]
	AS
		BEGIN
		SELECT [ItemID], [ItemTypeID], [Description], [OnHandQty], [Name], [ReOrderQty], [DateActive], [Active], [CustomerPurchasable], [RecipeID]
		FROM	[Item]
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_all_itemtypes]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_all_itemtypes]

AS
	BEGIN
		SELECT 	[ItemTypeID]
		FROM	[ItemType]
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_select_all_performance]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_all_performance]
AS
	BEGIN
		SELECT [PerformanceID], [PerformanceTitle], [PerformanceDate], [Description]
		FROM [Performance]
	END
GO
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Jacob Miller',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_select_all_performance'
GO
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Desc',
	@value=N'Added PerformanceTitle support',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_select_all_performance'
GO

/****** Object:  StoredProcedure [dbo].[sp_select_all_recipes]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_all_recipes]
AS
	BEGIN
		SELECT [RecipeID], [Name], [Description] , [DateAdded] , [Active]
		FROM [Recipe]
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_select_all_statusids]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_select_all_statusids]
AS
	BEGIN
		SELECT 		[BuildingStatusID]
		FROM		[BuildingStatus]
		ORDER BY	[BuildingStatusID]
	END

GO
-- Eric Bostwick
-- Created: 3/7/2019
-- Retrieves All SupplierOrders in the supplier order table
CREATE Procedure [dbo].[sp_select_all_supplier_orders]
As
    BEGIN
        SELECT [so].[SupplierOrderID], [so].[SupplierID], [s].[Name] AS SupplierName, [so].[EmployeeID], [e].[FirstName], [e].[LastName], [so].[Description],
        [so].[DateOrdered], [so].[OrderComplete]
        FROM [SupplierOrder] so INNER JOIN [Employee] e ON [so].[EmployeeID] = [e].[EmployeeID]
		INNER JOIN [Supplier] s ON [s].[SupplierID] = [so].[SupplierID]
    END
GO
-- Eric Bostwick
-- Created: 3/7/2019
-- Retrieves All SupplierOrderLines for a supplier order --
CREATE Procedure [dbo].[sp_select_all_supplier_order_lines]
	@SupplierOrderID [int]
As
    BEGIN
        SELECT [SupplierOrderID], [ItemID], [Description], [OrderQty], [UnitPrice], [QtyReceived]
        FROM [SupplierOrderLine]
		WHERE [SupplierOrderID] = @SupplierOrderID
    END
GO

--Created By: Wes Richardson
--Created On: 2019-03-01
--Select an appointment by appointment id

CREATE PROCEDURE [dbo].[sp_select_appointment_by_id]
	(
		@AppointmentID		[int]
	)
AS
	BEGIN
		SELECT	[AppointmentTypeID], [GuestID], [StartDate], [EndDate], [Description]
		FROM	[Appointment]
		WHERE 	[AppointmentID] = @AppointmentID
	END
GO

-- Created By: Wes Richardson
-- Created On: 2019-03-01
-- Select a list of guests for a appointment guest view model

CREATE PROCEDURE [dbo].[sp_select_appointment_guest_view_list]
AS
	BEGIN
		SELECT [GuestID], [FirstName], [LastName], [Email]
		FROM [Guest]
	END
GO

-- Created By: Wes Richardson
-- Created On: 2019-03-01
-- Select appointment type list

CREATE PROCEDURE [dbo].[sp_select_appointment_types]
AS
	BEGIN
		SELECT [AppointmentTypeID], [Description]
		FROM AppointmentType
	END
GO

/****** Object:  StoredProcedure [dbo].[sp_select_building_by_buildingstatusid]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_select_building_by_buildingstatusid]
	(
		@BuildingStatusID		[nvarchar](25)
	)
AS
	BEGIN
		SELECT		[BuildingID], [BuildingName], [Address], [Description], [BuildingStatusID]
		FROM		[Building]
		WHERE		[BuildingStatusID] = @BuildingStatusID
		ORDER BY	[BuildingID]
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_building_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_building_by_id]
	(
		@BuildingID		[nvarchar](50)
	)
AS
	BEGIN
		SELECT	[BuildingID], [BuildingName], [Address], [Description], [BuildingStatusID]
		FROM	[Building]
		WHERE	[BuildingID] = @BuildingID
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_building_by_keyword_in_building_name]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_select_building_by_keyword_in_building_name]
	(
		@Keyword		[nvarchar](150)
	)
AS
	BEGIN
		SELECT		[BuildingID], [BuildingName], [Address], [Description], [BuildingStatusID]
		FROM		[Building]
		WHERE		[BuildingName] LIKE '%' + @Keyword + '%'
		ORDER BY	[BuildingID]
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_buildings]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- Updated By: Dani Russo
-- Updated On: 3/28/2019
-- Added StatusID Parameter
-- Added ResortPropertyID Parameter
CREATE PROCEDURE [dbo].[sp_select_buildings]
AS
	BEGIN
		SELECT 		[BuildingID], [BuildingName], [Address], [Description], [BuildingStatusID], [ResortPropertyID]
		FROM		[Building]
		ORDER BY	[BuildingID]
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_department]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_department]

AS
	BEGIN
		SELECT 	    [DepartmentID]
		FROM		[Department]
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_employee_active]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_employee_active]
AS
	BEGIN
		SELECT [EmployeeID], [FirstName], [LastName], [PhoneNumber], [Email], [DepartmentID], [Active]
		FROM [Employee]
		WHERE [Active] = 1
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_employee_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_employee_by_id]
	(
		@EmployeeID				[int]
	)
AS
	BEGIN
		SELECT [EmployeeID], [FirstName], [LastName], [PhoneNumber], [Email], [DepartmentID], [Active]
		FROM [Employee]
		WHERE [EmployeeID] = @EmployeeID
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_employee_inactive]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_employee_inactive]
AS
	BEGIN
		SELECT [EmployeeID], [FirstName], [LastName], [PhoneNumber], [Email], [DepartmentID], [Active]
		FROM [Employee]
		WHERE [Active] = 0
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_event_type_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_event_type_by_id]
AS
    BEGIN        
		SELECT 		[EventTypeID]
		FROM		[EventType]
		ORDER BY 	[EventTypeID]
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_select_item]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_item]
(
	@ItemID 	[int]
)
AS
	BEGIN
		SELECT [ItemTypeID], [Description], [OnHandQuantity], [Name], [ReOrderQuantity], [DateActive], [Active], [CustomerPurchasable], [RecipeID]
		FROM	[Product]
		WHERE 	[ItemID] = @ItemID
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_item_by_itemid]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_item_by_itemid]
	@ItemID int
AS
BEGIN

	SELECT [ItemID], [ItemTypeID], [Description], [OnHandQty], [Name],
			[ReOrderQty], [DateActive], [Active]
		   FROM [ITEM] WHERE [ItemID] = @ItemID

END


GO
/****** Object:  StoredProcedure [dbo].[sp_select_item_by_recipeid]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_item_by_recipeid]
(
	@RecipeID [int]
)
AS
	BEGIN
		SELECT
		[ItemID],
		[ItemTypeID],
		[Description],
		[OnHandQty],
		[Name],
		[ReorderQty],
		[DateActive],
		[Active],
		[OfferingID],
		[CustomerPurchasable],
		[RecipeID]
		FROM [Item]
		WHERE [RecipeID] = @RecipeID
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_select_itemsupplier_by_itemid_and_supplierid]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_select_itemsupplier_by_itemid_and_supplierid]
(
	@ItemID [int],
	@SupplierID [int]
)
AS
	BEGIN
		SELECT
		[ItemSupplier].[ItemID],
		[ItemSupplier].[SupplierID],
		[ItemSupplier].PrimarySupplier,
		[ItemSupplier].[LeadTimeDays],
		[ItemSupplier].[UnitPrice],
		[ItemSupplier].[Active] as [ItemSupplierActive],
		[Supplier].[Name],
		[Supplier].[ContactFirstName],
		[Supplier].[ContactLastName],
		[Supplier].[PhoneNumber],
		[Supplier].[Email],
		[Supplier].[DateAdded],
		[Supplier].[Address],
		[Supplier].[City],
		[Supplier].[State],
		[Supplier].[Country],
		[Supplier].[PostalCode],
		[Supplier].[Description],
		[Supplier].[Active] AS SupplierActive,
		[Item].[ItemTypeID],
		[Item].[Description] AS [ItemDescripton],
		[Item].[OnHandQty],
		[Item].[Name],
		[Item].[DateActive],
		[Item].[Active] AS [ItemActive]
		FROM		[ItemSupplier]
					JOIN [Item] ON [Item].[ItemID] = [ItemSupplier].[ItemID]
					JOIN [Supplier] ON [Supplier].[SupplierID] = [ItemSupplier].[SupplierID]
		WHERE		[ItemSupplier].[ItemID] = @ItemID AND [ItemSupplier].[SupplierID] = @SupplierID
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_select_itemsuppliers_by_itemid]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_select_itemsuppliers_by_itemid]
(
	@ItemID [int]
)
AS
	BEGIN
		SELECT
		[ItemSupplier].[ItemID],
		[ItemSupplier].[SupplierID],
		[ItemSupplier].[PrimarySupplier],
		[ItemSupplier].[LeadTimeDays],
		[ItemSupplier].[UnitPrice],
		[ItemSupplier].[Active] as [ItemSupplierActive],
		[Supplier].[Name],
		[Supplier].[ContactFirstName],
		[Supplier].[ContactLastName],
		[Supplier].[PhoneNumber],
		[Supplier].[Email],
		[Supplier].[DateAdded],
		[Supplier].[Address],
		[Supplier].[City],
		[Supplier].[State],
		[Supplier].[Country],
		[Supplier].[PostalCode],
		[Supplier].[Description],
		[Supplier].[Active] AS [SupplierActive],
		[Item].[ItemTypeID],
		[Item].[Description] AS [ItemDescripton],
		[Item].[OnHandQty],
		[Item].[Name],
		[Item].[DateActive],
		[Item].[Active] AS [SupplierActive]
		FROM		[ItemSupplier]
					JOIN [Item] ON [Item].[ItemID] = [ItemSupplier].[ItemID]
					JOIN [Supplier] ON [Supplier].[SupplierID] = [ItemSupplier].[SupplierID]
		WHERE		[ItemSupplier].[itemID] = @ItemID
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_select_itemsuppliers_by_supplierid]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_itemsuppliers_by_supplierid]
(
@SupplierID[int]
)
AS
BEGIN
SELECT [isup].[ItemID], [isup].[SupplierID], [isup].[PrimarySupplier],
[isup].[LeadTimeDays], [isup].[UnitPrice],
[p].[ItemTypeID], [p].[Description], [p].[OnHandQty], [p].[Name], [p].[ReOrderQty],
[p].[DateActive], [p].[Active], [p].[CustomerPurchasable], [p].[RecipeID], [p].[OfferingID]
FROM   [dbo].[ItemSupplier] [isup] JOIN Item [p] on [p].[ItemID] = [isup].[ItemID]
WHERE  [isup].[SupplierID] = @SupplierID AND [isup].[Active] = 1

END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_line_items_by_recipeid]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_line_items_by_recipeid]
(
	@RecipeID [int]
)
AS
	BEGIN
		SELECT
		[Item].[ItemID],
		[Item].[ItemTypeID],
		[Item].[Description],
		[Item].[OnHandQty],
		[Item].[Name],
		[Item].[ReorderQty],
		[Item].[DateActive],
		[Item].[Active],
		[Item].[OfferingID],
		[Item].[CustomerPurchasable],
		[Item].[RecipeID]
		FROM [Item]
		INNER JOIN [RecipeItemLine] ON [RecipeItemLine].[ItemID] = [Item].[ItemID]
		WHERE [RecipeItemLine].[RecipeID] = @RecipeID
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_select_member_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_member_by_id]
(
	@MemberID 				[int]
)
AS
	BEGIN
		SELECT [MemberID],[FirstName],[LastName],[PhoneNumber],[Email],[Active]
		FROM Member
		WHERE [MemberID] = @MemberID
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_offering]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_offering]
(
	@OfferingID [int]
)
AS
	BEGIN
		SELECT [OfferingID], [OfferingTypeID], [EmployeeID], [Description], [Price], [Active]
		FROM [Offering]
		WHERE [OfferingID] = @OfferingID
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_select_performance_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_performance_by_id]
	(
		@PerformanceID	[int]
	)
AS
	BEGIN
		SELECT 	[PerformanceID], [PerformanceTitle], [PerformanceDate], [Description]
		FROM [Performance]
		WHERE [PerformanceID] = @PerformanceID
		RETURN @@ROWCOUNT
	END
GO
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Jacob Miller',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_select_performance_by_id'
GO
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Desc',
	@value=N'Added PerformanceTitle support',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_select_performance_by_id'
GO
/****** Object:  StoredProcedure [dbo].[sp_select_pet_type_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_pet_type_by_id]
AS
    BEGIN        
		SELECT 		[PetTypeID]
		FROM		[PetType]
		ORDER BY 	[PetTypeID]
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_select_recipe]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_recipe]
(
	@RecipeID [int]
)
AS
	BEGIN
		SELECT [RecipeID], [Name], [Description] , [DateAdded] , [Active]
		FROM [Recipe]
		WHERE [RecipeID] = @RecipeID
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_select_recipe_item_lines]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_recipe_item_lines]
(
	@RecipeID [int]
)
AS
	BEGIN
		SELECT [RecipeID], [ItemID], [Quantity], [UnitOfMeasure]
		FROM [RecipeItemLine]
		WHERE [RecipeID] = @RecipeID
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_select_reservation]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_reservation]
(
	@ReservationID 				[int]
)
AS
	BEGIN
		SELECT [ReservationID],[MemberID],[NumberOfGuests],[NumberOfPets],[ArrivalDate],[DepartureDate],[Notes],[Active]
		FROM Reservation
		WHERE [ReservationID] = @ReservationID

	END

GO
-- Name: Eduardo Colon
-- Date: 2019-03-05
CREATE PROCEDURE [dbo].[sp_retrieve_all_setuplists]
AS
	BEGIN
		SELECT 	    [SetupListID], [SetupID], [Completed], [Description], [Comments]
		FROM		[SetupList]
	END
GO

/****** Object:  StoredProcedure [dbo].[sp_select_shop_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_select_shop_by_id]
(
@ShopID [int]
)
AS
BEGIN
SELECT [RoomID], [Name], [Description], [Active]
FROM [Shop]
WHERE [ShopID] = @ShopID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_shops]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_select_shops]
AS
BEGIN
SELECT [ShopID], [RoomID], [Name], [Description], [Active]
FROM [Shop]
ORDER BY [ShopID], [RoomID]
END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_suppliers]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_suppliers]
AS
	BEGIN
		SELECT 	    [Name], [ContactFirstName], [ContactLastName],	[PhoneNumber], [Email], [DateAdded], [Address], [City], [State], [Country], [PostalCode], [Description], [Active]
		FROM		[Supplier]
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_suppliers_for_itemsupplier_mgmt_by_itemid]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_select_suppliers_for_itemsupplier_mgmt_by_itemid]
(
	@ItemID [int]
)
AS
	BEGIN
		SELECT		[Supplier].[SupplierID],
					[Supplier].[Name],
					[Supplier].[Address],
					[Supplier].[City],
					[Supplier].[State],
					[Supplier].[PostalCode],
					[Supplier].[Country],
					[Supplier].[PhoneNumber],
					[Supplier].[Email],
					[Supplier].[ContactFirstName],
					[Supplier].[ContactLastName],
					[Supplier].[DateAdded],
					[Supplier].[Description],
					[Supplier].[Active]

		FROM		[Supplier] LEFT OUTER JOIN [ItemSupplier] ON [ItemSupplier].[SupplierID] = [Supplier].[SupplierID]
		WHERE		[ItemSupplier].[Itemid] != @ItemID OR [ItemSupplier].[Itemid] is Null
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_view_model_shops]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_select_view_model_shops]
AS
BEGIN
SELECT  [Shop].[ShopID],
[Shop].[RoomID],
[Shop].[Name],
[Shop].[Description],
[Shop].[Active],
[Room].[RoomNumber],
[Room].[BuildingID]
FROM [Shop] INNER JOIN [Room] ON [Shop].[RoomID] = [Room].[RoomID]

END

GO

-- Created By: Wes Richardson
-- Created On: 2019-03-01
-- Update an appointment
CREATE PROCEDURE [dbo].[sp_update_appointment]
	(
	@AppointmentID		[int],
	@AppointmentTypeID	[nvarchar](15),
	@GuestID			[int],
	@StartDate			[DateTime],
	@EndDate			[DateTime],
	@Description		[nvarchar](1000)
	)
AS
	BEGIN
		UPDATE	[Appointment]
			SET	[AppointmentTypeID] = @AppointmentTypeID,
					[GuestID] = @GuestID,
					[StartDate] = @StartDate,
					[EndDate] = @EndDate,
					[Description] = @Description
			WHERE	[AppointmentID] = @AppointmentID
		RETURN @@ROWCOUNT
	END
GO

/****** Object:  StoredProcedure [dbo].[sp_update_building]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_update_building]
	(
		@BuildingID				[nvarchar](50),

		@NewBuildingName 		[nvarchar](150),
		@NewAddress				[nvarchar](150),
		@NewDescription			[nvarchar](1000),
		@NewBuildingStatusID	[nvarchar](25),

		@OldBuildingName		[nvarchar](150),
		@OldAddress				[nvarchar](150),
		@OldDescription			[nvarchar](250),
		@OldBuildingStatusID	[nvarchar](25)
	)
AS
	BEGIN
		UPDATE	[Building]
			SET	[BuildingName] 		= @NewBuildingName,
				[Address]			= @NewAddress,
				[Description]		= @NewDescription,
				[BuildingStatusID]	= @NewBuildingStatusID
		WHERE	[BuildingID] 		= @BuildingID
			AND [BuildingName] 		= @OldBuildingName
			AND [Address]			= @OldAddress
			AND	[Description]		= @OldDescription
			AND	[BuildingStatusID]	= @OldBuildingStatusID

		Return @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_employee_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_update_employee_by_id]
	(
		@EmployeeID			[int],

		@FirstName			[nvarchar](50),
		@LastName			[nvarchar](100),
		@PhoneNumber 		[nvarchar](11),
		@Email				[nvarchar](250),
		@DepartmentID		[nvarchar](50),
		@Active				[bit],

		@OldFirstName		[nvarchar](50),
		@OldLastName		[nvarchar](100),
		@OldPhoneNumber 	[nvarchar](11),
		@OldEmail			[nvarchar](250),
		@OldDepartmentID	[nvarchar](50),
		@OldActive			[bit]
	)
AS
	BEGIN
		UPDATE [Employee]
		SET		[FirstName] = @FirstName,
				[LastName] = @LastName,
				[PhoneNumber] = @PhoneNumber,
				[Email] = @Email,
				[DepartmentID] = @DepartmentID,
				[Active] = @Active
		WHERE	[EmployeeID] = @EmployeeID
		  AND	[FirstName] = @OldFirstName
		  AND	[LastName] = @OldLastName
		  AND	[PhoneNumber] = @OldPhoneNumber
		  AND	[Email] = @OldEmail
		  AND	[DepartmentID] = @OldDepartmentID
		  AND	[Active] = @OldActive

		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_employee_email]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_update_employee_email]
	(
		@EmployeeID			[int],
		@Email				[nvarchar](250),
		@OldEmail			[nvarchar](250),
		@PasswordHash		[nvarchar](100)
	)
AS
	BEGIN
		UPDATE [Employee]
			SET [Email] = @Email
			WHERE [EmployeeID] = @EmployeeID
				AND [Email] = @OldEmail
				AND [PasswordHash] = @PasswordHash

		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_event]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--Updated Phillip Hansen 2019-03-22
-- Updated By: Phillip Hansen
-- Updated Date: 2019-04-09

CREATE PROCEDURE [dbo].[sp_update_event]
	(
		@EventID				[int],
		@EventTitle				[nvarchar](50),
		@EmployeeID			 	[int],
		@EventTypeID			[nvarchar](15),
		@Description			[nvarchar](1000),
		@EventStartDate			[date],
		@EventEndDate			[date],
		@KidsAllowed			[bit],
		@NumGuests				[int],
		@SeatsRemaining			[int],
		@Location				[nvarchar](50),
		@Sponsored				[bit],
		@Approved				[bit],
		@PublicEvent			[bit],

		@OldEventTitle			[nvarchar](50),
		@OldOfferingID			[int],
		@OldEmployeeID			[int],
		@OldEventTypeID			[nvarchar](15),
		@OldDescription			[nvarchar](1000),
		@OldEventStartDate		[date],
		@OldEventEndDate		[date],
		@OldKidsAllowed			[bit],
		@OldNumGuests			[int],
		@OldSeatsRemaining		[int],
		@OldLocation			[nvarchar](50),
		@OldSponsored			[bit],
		@OldApproved			[bit],
		@OldPublicEvent			[bit]

	)
AS
	BEGIN
		UPDATE [Event]
		SET		[EventTitle] = @EventTitle,
				[EmployeeID] = @EmployeeID,
				[EventTypeID] = @EventTypeID,
				[Description] = @Description,
				[EventStartDate] = @EventStartDate,
				[EventEndDate] = @EventEndDate,
				[KidsAllowed] = @KidsAllowed,
				[NumGuests] = @NumGuests,
				[Location] = @Location,
				[Sponsored] = @Sponsored,
				[Approved] = @Approved,
				[SeatsRemaining] = @SeatsRemaining,
				[PublicEvent] = @PublicEvent
		FROM 	[dbo].[Event]
		WHERE	[EventID] = @EventID
		AND		[OfferingID] = @OldOfferingID
		AND 	[EventTitle] = @OldEventTitle
		AND		[EmployeeID] = @OldEmployeeID
		AND		[EventTypeID] = @OldEventTypeID
		AND		[Description] = @OldDescription
		AND		[EventStartDate] = @OldEventStartDate
		AND		[EventEndDate] = @OldEventEndDate
		AND		[KidsAllowed] = @OldKidsAllowed
		AND		[SeatsRemaining] = @OldSeatsRemaining
		AND		[NumGuests] = @OldNumGuests
		AND		[Location] = @OldLocation
		AND 	[Sponsored] = @OldSponsored
		AND		[Approved] = @OldApproved
		AND		[PublicEvent] = @OldPublicEvent

			RETURN @@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_guest_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_update_guest_by_id]
	(
		@GuestID					[int],
		
		@MemberID					[int],
		@GuestTypeID				[nvarchar](25),
		@FirstName					[nvarchar](50),
		@LastName					[nvarchar](100)	,
		@PhoneNumber				[nvarchar](11),
		@Email						[nvarchar](250),
		@Minor						[bit],
		@Active						[bit],
		@ReceiveTexts				[bit],
		@EmergencyFirstName			[nvarchar](50),
		@EmergencyLastName			[nvarchar](100),
		@EmergencyPhoneNumber		[nvarchar](11),
		@EmergencyRelation			[nvarchar](25),
		
		@OldMemberID				[int],
		@OldGuestTypeID				[nvarchar](25),
		@OldFirstName				[nvarchar](50),
		@OldLastName				[nvarchar](100)	,
		@OldPhoneNumber				[nvarchar](11),
		@OldEmail					[nvarchar](250),
		@OldMinor					[bit],
		@OldActive					[bit],
		@OldReceiveTexts			[bit],
		@OldEmergencyFirstName		[nvarchar](50),
		@OldEmergencyLastName		[nvarchar](100),
		@OldEmergencyPhoneNumber	[nvarchar](11),
		@OldEmergencyRelation		[nvarchar](25)		
	)
AS
	BEGIN
		UPDATE	[Guest]
		SET 	[MemberID] = @MemberID,
				[GuestTypeID] = @GuestTypeID,
				[FirstName] = @FirstName,
				[LastName] = @LastName,
				[PhoneNumber] = @PhoneNumber,
				[Email] = @Email,
				[Minor] = @Minor,
				[Active] = @Active,
				[ReceiveTexts] = @ReceiveTexts,
				[EmergencyFirstName] = @EmergencyFirstName,
				[EmergencyLastName] = @EmergencyLastName,
				[EmergencyPhoneNumber] = @EmergencyPhoneNumber,
				[EmergencyRelation] = @EmergencyRelation
		FROM	[dbo].[Guest]
		WHERE	[GuestID] = @GuestID
		  AND	[MemberID] = @OldMemberID
		  AND	[GuestTypeID] = @OldGuestTypeID
		  AND	[FirstName] = @OldFirstName
		  AND	[LastName] = @OldLastName
		  AND	[PhoneNumber] = @OldPhoneNumber
		  AND	[Email] = @OldEmail
		  AND	[Minor] = @OldMinor
		  AND	[Active] = @OldActive
		  AND	[ReceiveTexts] = @OldReceiveTexts
		  AND	[EmergencyFirstName] = @OldEmergencyFirstName
		  AND	[EmergencyLastName] = @OldEmergencyLastName
		  AND	[EmergencyPhoneNumber] = @OldEmergencyPhoneNumber
		  AND	[EmergencyRelation] = @OldEmergencyRelation
		  
		RETURN @@ROWCOUNT
	END

GO
/*
 * Author: Richard Carroll
 * Created: 2019/3/8
 */
Create Procedure [dbo].[sp_update_guest_vehicle]
(
    @OldGuestID           [int],
    @OldMake              [nvarchar](30),
    @OldModel             [nvarchar](30),
    @OldPlateNumber       [nvarchar](10),
    @OldColor             [nvarchar](30),
    @OldParkingLocation   [nvarchar](50),
    @GuestID              [int],
    @Make                 [nvarchar](30),
    @Model                [nvarchar](30),
    @PlateNumber          [nvarchar](10),
    @Color                [nvarchar](30),
    @ParkingLocation      [nvarchar](50)
)
AS 
    BEGIN
        Update GuestVehicle
        Set [GuestID] = @GuestID,
        [Make] = @Make,
        [Model] = @Model,
        [PlateNumber] = @PlateNumber,
        [Color] = @Color,
        [ParkingLocation] = @ParkingLocation
        Where [GuestID] = @OldGuestID AND
        [Make] = @OldMake AND
        [Model] = @OldModel AND
        [PlateNumber] = @OldPlateNumber AND
        [Color] = @OldColor AND
        [ParkingLocation] = @OldParkingLocation
        Return @@Rowcount
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_itemsupplier]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_update_itemsupplier]
	(
		@ItemID 			[int],
		@SupplierID			[int],
		@PrimarySupplier	[bit],
		@LeadTimeDays		[int],
		@UnitPrice			[money],
		@Active				[bit],

		@OldItemID 			[int],
		@OldSupplierID		[int],
		@OldPrimarySupplier	[bit],
		@OldLeadTimeDays	[int],
		@OldUnitPrice		[money],
		@OldActive			[bit]
	)
AS
BEGIN
		IF(@PrimarySupplier = 1)
			BEGIN
				UPDATE [dbo].[ItemSupplier]
				SET [PrimarySupplier]= 0
				WHERE [ItemID] = @ItemID
			END

		UPDATE [dbo].[ItemSupplier]
		SET [ItemID] = @ItemID,
			[SupplierID] = @SupplierID,
			[PrimarySupplier] = @PrimarySupplier,
			[LeadTimeDays] = @LeadTimeDays,
			[UnitPrice] = @UnitPrice,
			[Active] = @Active
		WHERE
			[ItemID] = @OldItemID AND
			[SupplierID] = @OldSupplierID AND
			[PrimarySupplier] = @OldPrimarySupplier AND
			[LeadTimeDays] = @OldLeadTimeDays AND
			[UnitPrice] = @OldUnitPrice AND
			[Active] = @OldActive
END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_offering]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_update_offering]
(
	@OfferingID [int],

	@OldOfferingTypeID [nvarchar](15),
	@OldEmployeeID [int],
	@OldDescription [nvarchar](1000),
	@OldPrice [Money],
	@OldActive [bit],

	@NewOfferingTypeID [nvarchar](15),
	@NewEmployeeID [int],
	@NewDescription [nvarchar](1000),
	@NewPrice [Money],
	@NewActive [bit]
)
AS
	BEGIN
		UPDATE [Offering]
		SET
			[OfferingTypeID] = @NewOfferingTypeID,
			[EmployeeID] = @NewEmployeeID,
			[Description] = @NewDescription,
			[Price]	= @NewPrice,
			[Active] = @NewActive
		WHERE
			[OfferingTypeID] = @OldOfferingTypeID AND
			[EmployeeID] = @OldEmployeeID AND
			[Description] = @OldDescription AND
			[Price]	= @OldPrice AND
			[Active] = @OldActive
			
		RETURN @@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_password_hash]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_update_password_hash]
	(
		@Email				[nvarchar](250),
		@NewPasswordHash	[nvarchar](100),
		@OldPasswordHash	[nvarchar](100)

	)
AS
	BEGIN
		IF @NewPasswordHash != @OldPasswordHash
		BEGIN
			UPDATE [Employee]
				SET [PasswordHash] = @NewPasswordHash
				WHERE [Email] = @Email
					AND [PasswordHash] = @OldPasswordHash
			RETURN @@ROWCOUNT
		END
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_update_performance]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_update_performance]
	(
		@PerformanceID		[int],
		@PerformanceName	[nvarchar](100),
		@PerformanceDate	[date],
		@Description		[nvarchar](1000)
	)
AS
	BEGIN
		UPDATE [Performance]
			SET [PerformanceTitle] = @PerformanceName, [PerformanceDate] = @PerformanceDate, [Description] = @Description
			WHERE [PerformanceID] = @PerformanceID
		RETURN @@ROWCOUNT
	END
GO
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Jacob Miller',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_update_performance'
GO
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Desc',
	@value=N'Added PerformanceTitle support',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_update_performance'
GO


CREATE PROCEDURE [dbo].[sp_update_pet]
	(
		@PetID			 		    [int],

		@oldPetName				    [nvarchar](50),
		@oldGender					[nvarchar](50),
		@oldSpecies      			[nvarchar](50),
		@oldPetTypeID				[nvarchar](25),
		@oldGuestID				    [int],

		@newPetName				    [nvarchar](50),
		@newGender					[nvarchar](50),
		@newSpecies      			[nvarchar](50),
		@newPetTypeID				[nvarchar](25),
		@newGuestID				    [int]
	)
AS
	BEGIN
		UPDATE [Pet]
			SET [PetName] = @newPetName,
				[Gender] = @newGender,
				[Species] = @newSpecies,
				[PetTypeID] = @newPetTypeID,
				[GuestID] = @newGuestID
			WHERE
				[PetID] = @PetID
			AND [PetName] = @oldPetName
			AND [Gender] = @oldGender
			AND [Species] = @oldSpecies
			AND	[PetTypeID] = @oldPetTypeID
			AND	[GuestID] = @oldGuestID
		RETURN @@ROWCOUNT
	END
GO
EXEC sys.sp_addextendedproperty
	@name = N'Author'
	,@value = N'Craig Barkley'
	,@level0type = N'Schema', @level0name = 'dbo'
	,@level1type = N'Procedure', @level1name = 'sp_update_pet'
GO
EXEC sys.sp_addextendedproperty
	@name = N'Created Date'
	,@value = N'2019-02-17'
	,@level0type = N'Schema', @level0name = 'dbo'
	,@level1type = N'Procedure', @level1name = 'sp_update_pet'
GO
EXEC sys.sp_addextendedproperty
	@name = N'Updated 2019-03-09 Author'
	,@value = N'Austin Delaney'
	,@level0type = N'Schema', @level0name = 'dbo'
	,@level1type = N'Procedure', @level1name = 'sp_update_pet'
GO

/****** Object:  StoredProcedure [dbo].[sp_update_Pet_Type]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_update_Pet_Type]
	(
		@PetTypeID	 [int],


		@Description	[nvarchar](1000),
		@Species   	    [nvarchar](50),


		@OldDescription		[nvarchar](1000),
		@OldSpecies   	    [nvarchar](50)

	)
	AS
	BEGIN

		UPDATE	[Pet_Type]
		SET 	[Description]	=	@Description,
				[Species]   	=	@Species
		FROM	[dbo].[Pet]
		WHERE	[PetTypeID] 	=   @PetTypeID
		  AND	[Description]	=	@OldDescription
		  AND	[Species]   	=	@OldSpecies


		RETURN @@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_update_recipe]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_update_recipe]
(
	@RecipeID [int],

	@OldName [nvarchar](50)	,
	@OldDescription [nvarchar](1000),
	@OldDateAdded [DateTime],
	@OldActive [bit],

	@NewName [nvarchar](50)	,
	@NewDescription [nvarchar](1000),
	@NewDateAdded [DateTime],
	@NewActive [bit]
)
AS
	BEGIN
		UPDATE [Recipe]
		SET
			[Name] = @NewName,
			[Description] = @NewDescription,
			[DateAdded] = @NewDateAdded,
			[Active] = @NewActive
		WHERE

			[RecipeID] = @RecipeID AND
			[Name] = @OldName AND
			[Description] = @OldDescription AND
			[DateAdded] = @OldDateAdded AND
			[Active] = @OldActive
			RETURN @@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_reservation]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_update_reservation]
	(
		@ReservationID 				[int],
		@oldMemberID				[int],
		@oldNumberOfGuests 			[int],
		@oldNumberOfPets 			[int],
		@oldArrivalDate 			[Date],
		@oldDepartureDate 			[Date],
		@oldNotes 					[nvarchar](250),
		@oldActive 					[bit],
		@newMemberID				[int],
		@newNumberOfGuests 			[int],
		@newNumberOfPets 			[int],
		@newArrivalDate 			[Date],
		@newDepartureDate 			[Date],
		@newNotes 					[nvarchar](250),
		@newActive					[bit]
	)
AS
	BEGIN
		UPDATE [Reservation]
			SET [MemberID] = @newMemberID,
				[NumberOfGuests] = @newNumberOfGuests,
				[NumberOfPets] = @newNumberOfPets,
				[ArrivalDate] = @newArrivalDate,
				[DepartureDate] = @newDepartureDate,
				[Notes] = @newNotes,
				[Active] = @newActive
			WHERE
				[ReservationID] = @ReservationID
			AND [MemberID] = @oldMemberID
			AND	[NumberOfGuests] = @oldNumberOfGuests
			AND	[NumberOfPets] = @oldNumberOfPets
			AND	[ArrivalDate] = @oldArrivalDate
			AND	[DepartureDate] = @oldDepartureDate
			AND	[Notes] = @oldNotes
			AND	[Active] = @oldActive
		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_role_by_id]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_update_role_by_id]
(
@RoleID  [nvarchar](50), 
@OldDescription   [nvarchar](1000),
@NewDescription  [nvarchar](1000)
)
AS
BEGIN

BEGIN
UPDATE [Role]
SET [Description] = @NewDescription

WHERE [RoleID] = @RoleID
AND  [Description] = @OldDescription

RETURN @@ROWCOUNT
END
END

GO
/*
 * Author: Kevin Broskow
 * Created 3-5-2019
 * 
 * Update a shop in the database
 */
CREATE PROCEDURE [dbo].[sp_update_shop]
(
	@ShopID 		[int],
	@oldRoomID		[int],
	@oldName		[nvarchar](50),
	@oldDescription		[nvarchar](1000),
	
	@newRoomID		[int],
	@newName		[nvarchar](50),
	@newDescription		[nvarchar](1000)
)
AS
BEGIN
	UPDATE [dbo].[Shop]
	SET [RoomID] = @newRoomID,
		[Name] = @newName,
		[Description] = @newDescription
	WHERE [ShopID] = @ShopID
	AND		[RoomID] = @oldRoomID
	AND 	[Name] = @oldName
	AND 	[Description] = @oldDescription
END
GO

/****** Object:  StoredProcedure [dbo].[sp_update_SupplierOrder]    Script Date: 3/10/2019 6:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_update_SupplierOrder]
	(
		@SupplierOrderID    	[int],

		@EmployeeID  			[int],
		@Description      		[nvarchar](50),
		@OrderComplete          [bit],
		@DateOrdered 	        [DateTime],
		@SupplierID				[int],

		@OldEmployeeID  		[int],
		@OldDescription     	[nvarchar](50),
		@OldOrderComplete       [bit],
		@OldDateOrdered 	    [DateTime],
		@OldSupplierID			[int]
	)
AS
	BEGIN
		UPDATE		[SupplierOrder]
			SET		[EmployeeID]  		=	@EmployeeID,
					[Description]      	=	@Description,
					[OrderComplete]     =	@OrderComplete,
					[DateOrdered] 		=	@DateOrdered,
					[SupplierID]        =	@SupplierID
			FROM	[dbo].[SupplierOrder]
			WHERE	[SupplierOrderID]   =   @SupplierOrderID
			  AND   [EmployeeID]  	    =	@OldEmployeeID
			  AND   [Description]      	=	@OldDescription
			  AND	[OrderComplete]     =	@OldOrderComplete
			  AND	[DateOrdered] 	    =	@OldDateOrdered
			  AND	[SupplierID]        =	@OldSupplierID

			RETURN @@ROWCOUNT
    END

GO

CREATE PROCEDURE [dbo].[sp_retrieve_employee_roles_by_employeeid]
(
	@EmployeeID [int]
)
AS
	SELECT [Role].[RoleID], [Role].[Description]
	FROM [Role]
	INNER JOIN [EmployeeRole] ON [Role].[RoleID] = [EmployeeRole].[RoleID]
	WHERE @EmployeeID = [EmployeeRole].[EmployeeID]
	GO
-- Created By: Phillip Hansen
-- Created On: 2019-04-09
	CREATE PROCEDURE [dbo].[sp_retrieve_all_event_sponsors]
AS
	BEGIN	
		SELECT 	[EventSponsor].[EventID], [Event].[EventTitle],
					[Sponsor].[Name], [EventSponsor].[SponsorID]
		FROM	[Event] INNER JOIN [EventSponsor]
				ON	[Event].[EventID] = [EventSponsor].[EventID]
		INNER JOIN [Sponsor] ON [EventSponsor].[SponsorID] = [Sponsor].[SponsorID]
		WHERE [Event].[EventID] = [EventSponsor].[EventID]
		AND 	[Sponsor].[SponsorID] = [EventSponsor].[SponsorID]
		AND		[Event].[Sponsored] = 1
	END
GO
-- Created By: Phillip Hansen
-- Created On: 2019-04-09
CREATE PROCEDURE [dbo].[sp_delete_event_sponsor_by_id]
	(
		@EventID		[int],
		@SponsorID		[int]
	)
AS
	BEGIN
		DELETE
		FROM	[EventSponsor]
		WHERE 	[EventID] = @EventID
		AND		[SponsorID] = @SponsorID
	END
GO

-- Created By: Phillip Hansen
-- Created On: 2019-04-09
CREATE PROCEDURE [dbo].[sp_retrieve_all_events_uncancelled]
AS
	BEGIN
		SELECT
		[EventID],
		[Event].[OfferingID],
		[EventTitle],
		[Event].[EmployeeID],
		[Employee].[FirstName],
		[EventTypeID] AS [EventType],
		[Event].[Description],
		[EventStartDate],
		[EventEndDate],
		[KidsAllowed],
		[NumGuests],
		[SeatsRemaining],
		[Location],
		[Sponsored],
		[Approved],
		[Cancelled],
		[PublicEvent],
		[Offering].[Price]
		
		FROM	[dbo].[Event] INNER JOIN [dbo].[Employee]
			ON		[Employee].[EmployeeID] = [Event].[EmployeeID]
			INNER JOIN [dbo].[Offering] 
			ON [Offering].[OfferingID] = [Event].[OfferingID]
		WHERE [Cancelled] = 0
	END
GO

-- Created By: Phillip Hansen
-- Created On: 2019-04-09
CREATE PROCEDURE [dbo].[sp_retrieve_all_events_cancelled]
AS
	BEGIN
		SELECT
		[EventID],
		[Event].[OfferingID],
		[EventTitle],
		[Event].[EmployeeID],
		[Employee].[FirstName],
		[EventTypeID] AS [EventType],
		[Event].[Description],
		[EventStartDate],
		[EventEndDate],
		[KidsAllowed],
		[NumGuests],
		[SeatsRemaining],
		[Location],
		[Sponsored],
		[Approved],
		[Cancelled],
		[PublicEvent],
		[Offering].[Price]
		
		FROM	[dbo].[Event] INNER JOIN [dbo].[Employee]
			ON		[Employee].[EmployeeID] = [Event].[EmployeeID]
			INNER JOIN [dbo].[Offering] 
			ON [Offering].[OfferingID] = [Event].[OfferingID]
		WHERE [Cancelled] = 1
	END
GO

-- Created By: Phillip Hansen
-- Created On: 2019-04-09
CREATE PROCEDURE [dbo].[sp_update_event_to_uncancelled]
	(
		@EventID		[int]
	)
AS
	BEGIN
		UPDATE 	[Event]
		SET		[Cancelled] = 0
		WHERE	[EventID] = @EventID
		AND		[Cancelled] = 1
	END
GO
-- Created By: Phillip Hansen
-- Created On: 2019-04-09
CREATE PROCEDURE [dbo].[sp_update_event_to_cancelled]
	(
		@EventID		[int]
	)
AS
	BEGIN
		UPDATE 	[Event]
		SET		[Cancelled] = 1
		WHERE	[EventID] = @EventID
		AND		[Cancelled] = 0
	END
GO
-- Created By: Phillip Hansen
-- Created On: 2019-04-09
CREATE PROCEDURE [dbo].[sp_select_all_sponsors]
AS
	BEGIN
		SELECT 	[SponsorID],[Name],[Address],[City],[State],[PhoneNumber],
					[Email],[ContactFirstName],[ContactLastName],[DateAdded],[Active]
		FROM	[dbo].[Sponsor]
	END
GO

-- Created By: Alisa Roehr
-- Created On: 2019-03-29
CREATE PROCEDURE sp_insert_employee_role
	(
		@EmployeeID 	[int],
		@RoleID			[nvarchar](50)
	)
AS
	BEGIN
		INSERT INTO [dbo].[EmployeeRole]
			([EmployeeID], [RoleID])
		VALUES
			(@EmployeeID, @RoleID)
			
		RETURN @@ROWCOUNT
	END		
GO

-- Created By: Alisa Roehr
-- Created On: 2019-03-29
CREATE PROCEDURE sp_delete_employee_role
	(
		@EmployeeID 	[int],
		@RoleID			[nvarchar](50)
	)
AS
	BEGIN
		DELETE 	
		FROM	[EmployeeRole]
		WHERE	[EmployeeID] = @EmployeeID
		  AND	[RoleID] = @RoleID
		  
		RETURN @@ROWCOUNT
	END
GO



-- Created By: Wes Richardson
-- Created On: 2019-03-28
-- Select Appointments by GuestID
CREATE PROCEDURE [dbo].[sp_select_appointment_by_guest_id]
	(
		@GuestID		[int]
	)
AS
	BEGIN
		SELECT	[AppointmentID], [AppointmentTypeID], [StartDate], [EndDate], [Description]
		FROM	[Appointment]
		WHERE 	[GuestID] = @GuestID
	END
GO
-- Created By: Wes Richardson
-- Created On: 2019-03-28
-- Delete Appointment
CREATE PROCEDURE [dbo].[sp_delete_appointment_by_id]
	(
		@AppointmentID		[int]
	)

AS
	BEGIN
		DELETE
		FROM [Appointment]
		WHERE [AppointmentID] = @AppointmentID
		RETURN @@ROWCOUNT
	END
GO

-- Created By: Kevin Broskow
-- Created On: 2019-03-29
CREATE PROCEDURE [dbo].[sp_insert_receiving]
(
	@SupplierOrderID		[int],
	@Description			[nvarchar](1000),
	@DateDelivered			[DateTime]
)
AS
	BEGIN
		INSERT INTO [dbo].[Receiving]([SupplierOrderID], [Description], [DateDelivered]) 
		VALUES(@SupplierOrderID, @Description, @DateDelivered)
	END
GO
-- Created By: Kevin Broskow
-- Created On: 2019-03-29
CREATE PROCEDURE [dbo].[sp_select_all_receiving]
AS
	BEGIN
		SELECT [ReceivingID],[SupplierOrderID],[Description],[DateDelivered],[Active]
		FROM [Receiving]
	END
GO

-- Created By: Kevin Broskow
-- Created On: 2019-03-29
CREATE PROCEDURE [dbo].[sp_select_receiving]
(
			@ReceivingID 	[int]
		)
AS
	BEGIN
		SELECT [ReceivingID],[SupplierOrderID],[Description],[DateDelivered],[Active]
		FROM [Receiving]
		WHERE [ReceivingID] = @ReceivingID
	END
GO

-- Created By: Kevin Broskow
-- Created On: 2019-03-29
CREATE PROCEDURE [dbo].[sp_update_receiving]
(
	@ReceivingID 		[int],
	@Description		[nvarchar](1000)
)
AS
	BEGIN
	UPDATE [Receiving]
	SET [Description] = @Description
	WHERE [ReceivingID] = @ReceivingID
END
GO

-- Created By: Kevin Broskow
-- Created On: 2019-03-29
CREATE PROCEDURE [dbo].[sp_deactivate_receiving]
(
	@ReceivingID		[int]
)
AS
	BEGIN
	UPDATE [Receiving]
	SET	[Active] = 0
	WHERE [ReceivingID] = @ReceivingID
END
GO
-- Created By: Kevin Broskow
-- Created On: 2019-03-29
CREATE PROCEDURE [dbo].[sp_select_supplier_order_by_id]
(
		@SupplierOrderID		[int]
)
AS
	BEGIN
	SELECT [EmployeeID], [Description], [OrderComplete], [DateOrdered], [SupplierID]
	FROM [SupplierOrder]
	WHERE [SupplierOrderID] = @SupplierOrderID
END 
GO

-- Created By: Kevin Broskow
-- Created On: 2019-03-29
CREATE PROCEDURE [dbo].[sp_complete_order_by_id]
(
		@SupplierOrderID		[int]
)
AS
	BEGIN
	UPDATE [SupplierOrder]
	SET [OrderComplete] = 1
	WHERE [SupplierOrderID] = @SupplierOrderID
END 
GO

-- Created By: Kevin Broskow
-- Created On: 2019-03-29
CREATE PROCEDURE [dbo].[sp_update_supplier_order_line]
(
@SupplierOrderID	[int],
@ItemID		[int],
@QtyReceived		[int]
)
AS
BEGIN
UPDATE [SupplierOrderLine]
SET [QtyReceived] = @QtyReceived
WHERE [SupplierOrderID] = @SupplierOrderID
AND		[ItemID] = @ItemID
END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_create_vehicle]
	(
		@Make				   [nvarchar](30),			
		@Model				   [nvarchar](30),
		@Year	               [int],					
		@License			   [nvarchar](10),			
		@Mileage			   [int],							
		@Capacity			   [int],					
		@Color				   [nvarchar](30),			
		@PurchaseDate		   [Date],					
		@Description		   [nvarchar](1000),		
		@Active				   [bit],					
		@DeactivationDate	   [Date],
		@Available			   [bit],
		@ResortVehicleStatusId [nvarchar] (25),
		@ResortPropertyId	   [int]
	)
AS
	BEGIN
		INSERT INTO [dbo].[ResortVehicle] 
			(
				 [Make] 
				, [Model]
				, [Year]
				, [License]
				, [Mileage]
				, [Capacity]
				, [Color]
				, [PurchaseDate]
				, [Description]
				, [Active]
				, [DeactivationDate]
				, [Available]
				, [ResortVehicleStatusId]
				, [ResortPropertyId]
			) 
		VALUES
			(
				  @Make
				, @Model
				, @Year
				, @License
				, @Mileage
				, @Capacity
				, @Color
				, @PurchaseDate
				, @Description
				, @Active
				, @DeactivationDate
				, @Available
				, @ResortVehicleStatusId
				, @ResortPropertyId
			)
		SELECT SCOPE_IDENTITY() 
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_select_vehicles]
AS
	BEGIN
		SELECT   [VehicleID]
		       , [Make]
			   , [Model]
			   , [Year]
			   , [License]
			   , [Mileage]
			   , [Capacity]
			   , [Color]
			   , [PurchaseDate]
			   , [Description]
			   , [Active]
			   , [DeactivationDate]
			   , [Available]
			   , [ResortVehicleStatusId]
			   , [ResortPropertyId]
		FROM [ResortVehicle]
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_select_vehicle_by_id]
	(
		@VehicleId [int]	
	)
AS
	BEGIN
		SELECT [VehicleID]
				, [Make]
				, [Model]
				, [Year]
				, [License]
				, [Mileage]
				, [Capacity]
				, [Color]
				, [PurchaseDate]
				, [Description]
				, [Active]
				, [DeactivationDate]
				, [Available]
				, [ResortVehicleStatusId]
				, [ResortPropertyId]
		FROM [ResortVehicle]
		WHERE [VehicleID] = @VehicleId
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_update_vehicle]
	(
		@VehicleId				  [int],
		@OldMake				  [nvarchar](30),			
		@OldModel				  [nvarchar](30),			
		@OldYear	              [int],					
		@OldLicense				  [nvarchar](10),			
		@OldMileage				  [int],		
		@OldCapacity			  [int],					
		@OldColor				  [nvarchar](30),			
		@OldPurchaseDate		  [Date],					
		@OldDescription			  [nvarchar](1000),		
		@OldActive				  [bit],					
		@DeactivationDate		  [Date],
		@OldAvailable			  [bit],
		@OldResortVehicleStatusId [nvarchar](25),
		@OldResortPropertyId	  [int],
		
		@NewMake				  [nvarchar](30),			
		@NewModel				  [nvarchar](30),			
		@NewYear	              [int],					
		@NewLicense				  [nvarchar](10),			
		@NewMileage				  [int],							
		@NewCapacity			  [int],					
		@NewColor				  [nvarchar](30),			
		@NewPurchaseDate		  [Date],					
		@NewDescription			  [nvarchar](1000),		
		@NewActive				  [bit],
		@NewAvailable			  [bit],
		@NewResortVehicleStatusId [nvarchar](25),
		@NewResortPropertyId	  [int]
	)
AS
	BEGIN
		UPDATE [ResortVehicle]
			SET [Make]				    = @NewMake,
				[Model]				    = @NewModel,					
				[Year]	                = @NewYear,				
				[License]			    = @NewLicense,					
				[Mileage]			    = @NewMileage,									
				[Capacity]			    = @NewCapacity,
				[Color]				    = @NewColor,				
				[PurchaseDate]		    = @NewPurchaseDate,
				[Description]		    = @NewDescription,				
				[Active]			    = @NewActive,			
				[DeactivationDate]      = @DeactivationDate,
				[Available]             = @NewAvailable,
				[ResortVehicleStatusId] = @NewResortVehicleStatusId,
				[ResortPropertyId]		= @NewResortPropertyId
			WHERE 	    [VehicleId]             = @VehicleId
					AND	[Make]				    = @OldMake
					AND [Model]				    = @OldModel
					AND [Year]	                = @OldYear
					AND [License]			    = @OldLicense
					AND [Mileage]			    = @OldMileage
					AND [Capacity]			    = @OldCapacity
					AND [Color]				    = @OldColor
					AND [PurchaseDate]		    = @OldPurchaseDate
					AND [Description]		    = @OldDescription
					AND [Active]			    = @OldActive
					AND [Available]			    = @OldAvailable
					AND [ResortVehicleStatusId] = @OldResortVehicleStatusId
					AND [ResortPropertyId]	 	= @OldResortPropertyId
		RETURN @@ROWCOUNT
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_delete_vehicle_by_id]
	(
		@VehicleId		[int]
	)
AS
	BEGIN
		DELETE
		FROM	[ResortVehicle]
		WHERE	[VehicleId] = @VehicleId
		  AND	[Active] = 0

		RETURN @@ROWCOUNT
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_deactivate_vehicle_by_id]
	(
		@VehicleId		[int]
	)
AS
	BEGIN
		UPDATE 	[ResortVehicle]
		SET 	[Active] = 0
		WHERE	[VehicleId] = @VehicleId

		RETURN @@ROWCOUNT
	END
GO




-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_create_resort_vehicle_status]
	(
		@ResortVehicleStatusId	[nvarchar](20),
		@Description			[nvarchar](1000)
	)
AS
	BEGIN
		INSERT INTO [dbo].[ResortVehicleStatus] ([ResortVehicleStatusId],[Description]) 
		VALUES(@ResortVehicleStatusId, @Description)
		SELECT SCOPE_IDENTITY() 
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_select_resort_vehicle_statuses]
AS
	BEGIN
		SELECT [ResortVehicleStatusId],[Description]
		FROM [ResortVehicleStatus]
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_select_resort_vehicle_status_by_id]
	(
		@ResortVehicleStatusId [int]	
	)
AS
	BEGIN
		SELECT [ResortVehicleStatusId], [Description]
		FROM [ResortVehicleStatus]
		WHERE [ResortVehicleStatusId] = @ResortVehicleStatusId
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_update_resort_vehicle_status]
	(
		@ResortVehicleStatusId	[nvarchar](25),
		
		@OldDescription	[nvarchar](1000),
		
		@NewDescription	[nvarchar](1000)
	)
AS
	BEGIN
		UPDATE [ResortVehicleStatus]
			SET [Description]			 = @NewDescription
			WHERE       [ResortVehicleStatusId] = @ResortVehicleStatusId
					AND [Description] = @OldDescription
		RETURN @@ROWCOUNT
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_delete_resort_vehicle_status_by_id]
	(
		@ResortVehicleStatusId		[nvarchar](25)
	)
AS
	BEGIN
		DELETE
		FROM	[ResortVehicleStatus]
		WHERE	[ResortVehicleStatusId] = @ResortVehicleStatusId

		RETURN @@ROWCOUNT
	END
GO



-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_create_vehicle_checkout]
	(
		@VehicleCheckoutId	[int],
		@EmployeeId			[int],
		@DateCheckedOut		[Date],
		@DateReturned		[Date],
		@DateExpectedBack	[Date],
		@Returned			[bit],
		@ResortVehicleId	[int]
	)
AS
	BEGIN
		INSERT INTO [dbo].[VehicleCheckout] 
			(	  [VehicleCheckoutId]
				, [EmployeeId]
				, [DateCheckedOut]
				, [DateReturned]
				, [DateExpectedBack]
				, [Returned]
				, [ResortVehicleId]
			) 
		VALUES
			(
				  @VehicleCheckoutId
				, @EmployeeId			
				, @DateCheckedOut		
				, @DateReturned		
				, @DateExpectedBack 
				, @Returned			
				, @ResortVehicleId	
			)
		SELECT SCOPE_IDENTITY() 
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_select_vehicle_checkouts]
AS
	BEGIN
		SELECT [VehicleCheckoutId]
		       , [EmployeeId]
			   , [DateCheckedOut]
			   , [DateReturned]
			   , [DateExpectedBack]
			   , [Returned]
			   , [ResortVehicleId]
		FROM [VehicleCheckout]
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_select_vehicle_checkout_by_id]
	(
		@VehicleCheckoutId [int]	
	)
AS
	BEGIN
		SELECT   [VehicleCheckoutId]
		       , [EmployeeId]
			   , [DateCheckedOut]
			   , [DateReturned]
			   , [DateExpectedBack]
			   , [Returned]
			   , [ResortVehicleId]
		FROM [VehicleCheckout]
		WHERE [VehicleCheckoutId] = @VehicleCheckoutId
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_update_vehicle_checkout]
	(
		@VehicleCheckoutId	[int],
		
		@OldEmployeeId			[int],
		@OldDateCheckedOut		[Date],
		@OldDateReturned		[Date],
		@OldDateExpectedBack	[Date],
		@OldReturned			[bit],
		@OldResortVehicleId		[int],
		
		@NewEmployeeId			[int],
		@NewDateCheckedOut		[Date],
		@NewDateReturned		[Date],
		@NewDateExpectedBack	[Date],
		@NewReturned			[bit],
		@NewResortVehicleId		[int]
	)
AS
	BEGIN
		UPDATE [VehicleCheckout]
			SET [EmployeeId]		 = @NewEmployeeId		
				, [DateCheckedOut]	 = @NewDateCheckedOut	
				, [DateReturned]	 = @NewDateReturned	
				, [DateExpectedBack] = @NewDateExpectedBack
				, [Returned]		 = @NewReturned		
				, [ResortVehicleId]	 = @NewResortVehicleId
			WHERE       [VehicleCheckoutId] = @VehicleCheckoutId
					AND [EmployeeId]	    = @OldEmployeeId		
					AND [DateCheckedOut]    = @OldDateCheckedOut		
					AND [DateExpectedBack]  = @OldDateExpectedBack
					AND [Returned]		    = @OldReturned		
					AND [ResortVehicleId]   = @OldResortVehicleId
		RETURN @@ROWCOUNT
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_delete_vehicle_checkout_by_id]
	(
		@VehicleCheckoutId		[int]
	)
AS
	BEGIN
		DELETE
		FROM	[VehicleCheckout]
		WHERE	[VehicleCheckoutId] = @VehicleCheckoutId

		RETURN @@ROWCOUNT
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_create_resort_property]
	(
		@ResortPropertyTypeId	[nvarchar](20)
	)
AS
	BEGIN
		INSERT INTO [dbo].[ResortProperty] ([ResortPropertyTypeId]) 
		VALUES(@ResortPropertyTypeId)
		SELECT SCOPE_IDENTITY() 
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_select_resort_properties]
AS
	BEGIN
		SELECT [ResortPropertyID], [ResortPropertyTypeId]
		FROM [ResortProperty]
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_select_resort_property_by_id]
	(
		@ResortPropertyId [int]	
	)
AS
	BEGIN
		SELECT [ResortPropertyID], [ResortPropertyTypeId]
		FROM [ResortProperty]
		WHERE [ResortPropertyID] = @ResortPropertyId
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_update_resort_property]
	(
		@ResortPropertyId			[int],
		@OldResortPropertyTypeId	[nvarchar](20),
		
		@NewResortPropertyTypeId	[nvarchar](20)
	)
AS
	BEGIN
		UPDATE [ResortProperty]
			SET [ResortPropertyTypeId]	= 	@NewResortPropertyTypeId
			WHERE 	    [ResortPropertyId]  = @ResortPropertyId
					AND	[ResortPropertyTypeId] = @OldResortPropertyTypeId
		RETURN @@ROWCOUNT
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_delete_resort_property_by_id]
	(
		@ResortPropertyId		[int]
	)
AS
	BEGIN
		DELETE
		FROM	[ResortProperty]
		WHERE	[ResortPropertyId] = @ResortPropertyId

		RETURN @@ROWCOUNT
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_create_resort_property_type]
	(
		@ResortPropertyTypeId	[nvarchar](20)
	)
AS
	BEGIN
		INSERT INTO [dbo].[ResortPropertyType] ([ResortPropertyTypeId]) 
		VALUES(@ResortPropertyTypeId)
		SELECT SCOPE_IDENTITY() 
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_select_resort_property_types]
AS
	BEGIN
		SELECT [ResortPropertyTypeId]
		FROM [ResortPropertyType]
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_select_resort_property_type_by_id]
	(
		@ResortPropertyTypeId [int]	
	)
AS
	BEGIN
		SELECT [ResortPropertyTypeId]
		FROM [ResortPropertyType]
		WHERE [ResortPropertyTypeId] = @ResortPropertyTypeId
	END
GO

-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_update_resort_property_type]
	(
		@OldResortPropertyTypeId	[nvarchar](20),
		
		@NewResortPropertyTypeId	[nvarchar](20)
	)
AS
	BEGIN
		UPDATE [ResortPropertyType]
			SET [ResortPropertyTypeId]	 = @NewResortPropertyTypeId
			WHERE [ResortPropertyTypeId] = @OldResortPropertyTypeId
		RETURN @@ROWCOUNT
	END
GO
-- Created By: Francis Mingomba
-- Created On : 2019-04-03
CREATE PROCEDURE [dbo].[sp_delete_resort_property_type_by_id]
	(
		@ResortPropertyTypeId		[int]
	)
AS
	BEGIN
		DELETE
		FROM	[ResortPropertyType]
		WHERE	[ResortPropertyTypeId] = @ResortPropertyTypeId

		RETURN @@ROWCOUNT
	END
GO



--Created By: Jacob Miller
--Created On: 3/2/19
--Updated:

CREATE PROCEDURE [dbo].[sp_select_all_luggage_status]
AS
	BEGIN
		SELECT [LuggageStatusID]
		FROM [LuggageStatus]
	END
GO
--Created By: Jacob Miller
--Created On: 3/28/19
--Updated:
CREATE PROCEDURE [dbo].[sp_insert_luggage]
	(
		@GuestID			[int],
		@LuggageStatusID	[nvarchar](50)
	)
AS
	BEGIN
		INSERT INTO [Luggage]
			(
				[GuestID], [LuggageStatusID]
			)
		VALUES
			(
				@GuestID, @LuggageStatusID
			)
	END
GO

--Created By: Jacob Miller
--Created On: 3/28/19
--Updated:
CREATE PROCEDURE [dbo].[sp_select_luggage_by_id]
	(
		@LuggageID	[int]
	)
AS
	BEGIN
		SELECT	[LuggageID], [GuestID], [LuggageStatusID]
		FROM	[Luggage]
		WHERE	[LuggageID] = @LuggageID
	END
GO

--Created By: Jacob Miller
--Created On: 3/28/19
--Updated:

CREATE PROCEDURE [dbo].[sp_select_all_luggage]
AS
	BEGIN
		SELECT	[LuggageID], [GuestID], [LuggageStatusID]
		FROM	[Luggage]
	END
GO

--Created By: Jacob Miller
--Created On: 3/28/19
--Updated:

CREATE PROCEDURE [dbo].[sp_update_luggage_status]
	(
		@LuggageID			[int],
		@GuestID			[int],
		@OldLuggageStatus	[nvarchar](50),
		@NewLuggageStatus	[nvarchar](50)
	)
AS
	BEGIN
		UPDATE	[Luggage]
			SET	[LuggageStatusID] = @NewLuggageStatus
		WHERE	[GuestID] = @GuestID
			AND	[LuggageID] = @LuggageID
			AND	[LuggageStatusID] = @OldLuggageStatus
		RETURN @@ROWCOUNT
	END
GO

--Created By: Jacob Miller
--Created On: 3/28/19
--Updated:

CREATE PROCEDURE [dbo].[sp_update_luggage]
	(
		@LuggageID			[int],
		@OldGuestID			[int],
		@NewGuestID			[int],
		@OldLuggageStatusID	[nvarchar](50),
		@NewLuggageStatusID	[nvarchar](50)
	)
AS
	BEGIN
		UPDATE	[Luggage]
			SET	[LuggageStatusID] = @NewLuggageStatusID,
				[GuestID] = @NewGuestID
		WHERE	[LuggageID] = @LuggageID
			AND		[GuestID] = @OldGuestID
			AND		[LuggageStatusID] = @OldLuggageStatusID
		RETURN @@ROWCOUNT
	END
GO

--Created By: Jacob Miller
--Created On: 3/28/19
--Updated:

CREATE PROCEDURE [dbo].[sp_delete_luggage]
	(
		@LuggageID	[int]
	)
AS
	BEGIN
		DELETE FROM [Luggage]
		WHERE [LuggageID] = @LuggageID
		RETURN @@ROWCOUNT
	END
GO

--Created By: Jacob Miller
--Created On: 4/4/19
--Updated:
CREATE PROCEDURE [dbo].[sp_retrieve_all_guests]
AS
	BEGIN
		SELECT [GuestID], [MemberID], [GuestTypeID], [FirstName], 
			   [LastName], [PhoneNumber], [Email], 
			   [Minor], [Active],[ReceiveTexts], [EmergencyFirstName], 
			   [EmergencyLastName], [EmergencyPhoneNumber], [EmergencyRelation], [CheckedIn]
		FROM   [Guest]
	END

GO

/* 
Created By: Dalton Cleveland
Date: 03-27-2019
*/
CREATE PROCEDURE sp_create_house_keeping_request
	(
	@BuildingNumber					[int],
	@RoomNumber						[int],
	@Description					[nvarchar](1000),
	@Active							[bit]
	)
AS
	BEGIN
		INSERT INTO [HouseKeepingRequest]
			([BuildingNumber], [RoomNumber], [Description],[Active])
		VALUES
			(@BuildingNumber, @RoomNumber, @Description, @Active )  
		RETURN @@ROWCOUNT
	END
GO

/* 
Created By: Dalton Cleveland
Date: 03-27-2019
*/

CREATE PROCEDURE [dbo].[sp_select_all_house_keeping_requests] 
AS
	BEGIN
		SELECT 
			[HouseKeepingRequestID], 
			[BuildingNumber], 
			[RoomNumber],
			[Description],
			[WorkingEmployeeID],
			[Active]
		FROM HouseKeepingRequest
	END
GO

/* 
Created By: Dalton Cleveland
Date: 03-27-2019
*/

CREATE PROCEDURE [dbo].[sp_select_house_keeping_request_by_id] 
(
	@HouseKeepingRequestID		[int]
)
AS
	BEGIN
		SELECT 
			[HouseKeepingRequestID], 
			[BuildingNumber], 
			[RoomNumber],
			[Description],
			[WorkingEmployeeID],
			[Active]
		FROM HouseKeepingRequest
		WHERE [HouseKeepingRequestID] = @HouseKeepingRequestID
	END
GO


/* 
Created By: Dalton Cleveland
Date: 03-27-2019
*/
CREATE PROCEDURE [dbo].[sp_update_house_keeping_request]
	(
	@HouseKeepingRequestID				[int],
	
	@oldBuildingNumber					[int],
	@oldRoomNumber						[int],
	@oldDescription						[nvarchar](1000),
	@oldActive							[bit],
	
	@newBuildingNumber					[int],
	@newRoomNumber						[int],
	@newDescription						[nvarchar](1000),
	@newWorkingEmployeeID				[int],
	@newActive							[bit]	
	)
AS
	BEGIN
		UPDATE [HouseKeepingRequest]
			SET [BuildingNumber] = @newBuildingNumber,
				[RoomNumber] = @newRoomNumber,
				[Description] = @newDescription,
				[Active] = @newActive,
				[WorkingEmployeeID] = @newWorkingEmployeeID
			WHERE [BuildingNumber] = @oldBuildingNumber
				AND [RoomNumber] = @oldRoomNumber
				AND [Description] = @oldDescription
				AND [Active] = @oldActive
		RETURN @@ROWCOUNT
	END
GO


/* 
Created By: Dalton Cleveland
Date: 03-27-2019
*/

CREATE PROCEDURE [dbo].[sp_deactivate_house_keeping_request]
	(
		@HouseKeepingRequestID			[int]
	)
AS
	BEGIN
		UPDATE [HouseKeepingRequest]
			SET [Active] = 0
			WHERE 	
				[HouseKeepingRequestID] = @HouseKeepingRequestID
		RETURN @@ROWCOUNT
	END
GO


/* 
Created By: Dalton Cleveland
Date: 03-27-2019
*/
CREATE PROCEDURE [dbo].[sp_delete_house_keeping_request]
	(
		@HouseKeepingRequestID 				[int]
	)
AS
	BEGIN
		DELETE 
		FROM [HouseKeepingRequest]
		WHERE  [HouseKeepingRequestID] = @HouseKeepingRequestID
		RETURN @@ROWCOUNT
	END
GO


/* 	Created By:  Danielle Russo 
	Created: 02/27/2019
	Updated: 
*/ 
CREATE PROCEDURE [dbo].[sp_insert_inspection]
	(
		@ResortPropertyID				[int],
		@Name							[nvarchar](50),
		@DateInspected					[date],
		@Rating							[nvarchar](50),
		@ResortInspectionAffiliation	[nvarchar](25),
		@InspectionProblemNotes			[nvarchar](1000),
		@InspectionFixNotes				[nvarchar](1000)	
	)
AS
	BEGIN
		
		INSERT INTO [Inspection]
			(	
				[ResortPropertyID], 
				[Name], 
				[DateInspected], 
				[Rating], 
				[ResortInspectionAffiliation], 
				[InspectionProblemNotes], 
				[InspectionFixNotes]
			)
		VALUES
			(
				@ResortPropertyID,
				@Name,
				@DateInspected,
				@Rating,
				@ResortInspectionAffiliation,
				@InspectionProblemNotes,
				@InspectionFixNotes
			)
			
		SELECT [InspectionID] = @@IDENTITY
	END
GO

/* 	Created By:  Danielle Russo 
	Created: 02/27/2019
	Updated: 
*/ 
CREATE PROCEDURE [dbo].[sp_select_inspection_by_resortpropertyid]
	(
		@ResortPropertyID	[int]
	)
AS
	BEGIN
		SELECT	[InspectionID],[Name],[DateInspected],[Rating],
				[ResortInspectionAffiliation],[InspectionProblemNotes],
				[InspectionFixNotes]
		FROM 	[Inspection]
		WHERE	[ResortPropertyID] = @ResortPropertyID
	END
GO

/* 	Created By:  Danielle Russo 
	Created: 02/27/2019
	Updated: 
*/ 
CREATE PROCEDURE [dbo].[sp_select_all_inspections]
AS
	BEGIN
		SELECT	[InspectionID],[ResortPropertyID],[Name],[DateInspected],
				[Rating],[ResortInspectionAffiliation],[InspectionProblemNotes],
				[InspectionFixNotes]
		FROM 	[Inspection]
	END
GO

/* 	Created By:  Dani Russo 
	Created: 03/29/2019
	
*/ 
CREATE PROCEDURE [dbo].[sp_select_room_list]
AS
	BEGIN
		SELECT 	[Room].[RoomID],
				[Room].[RoomNumber], 
				[Room].[BuildingID], 
				[Room].[RoomTypeID], 
				[Room].[Description], 
				[Room].[Capacity], 
				[Offering].[Price],
				[Room].[ResortPropertyID], 
				[Room].[OfferingID], 
				[Room].[RoomStatusID]
		FROM 	[Room], [Offering]
	END
GO

/* 	Created By:  Dani Russo 
	Created: 03/29/2019
	
*/ 
CREATE PROCEDURE [dbo].[sp_select_room_by_id]
(
		@RoomID	[int]
)
AS
	BEGIN
		SELECT 	[Room].[RoomNumber], 
				[Room].[BuildingID], 
				[Room].[RoomTypeID], 
				[Room].[Description], 
				[Room].[Capacity], 
				[Offering].[Price],
				[Room].[ResortPropertyID], 
				[Room].[OfferingID], 
				[Room].[RoomStatusID]
		FROM 	[Room], [Offering]
		WHERE 	[RoomID] = @RoomID
	END
GO

/* 	Created By:  Dani Russo 
	Created: 03/29/2019
	
*/ 
CREATE PROCEDURE [dbo].[sp_select_room_types]

AS
	BEGIN
		SELECT 	[RoomTypeID]
		FROM 	[RoomType]
	END
GO

/* 	Created By:  Dani Russo 
	Created: 03/29/2019
	
*/ 
CREATE PROCEDURE [dbo].[sp_select_all_room_status]

AS
	BEGIN
		SELECT 	[RoomStatusID]
		FROM 	[RoomStatus]
	END
GO

-- *** Stored Procedures - Matthew Hill *** --
-- Author: <<Matthew Hill>>,Created:<<3/10/19>>

CREATE PROCEDURE [dbo].[sp_insert_pet_image_filename]
	(
		@Filename	[nvarchar](255),
		@PetID		[int]
	)
AS
	BEGIN
		INSERT INTO [PetImageFileName]
				([Filename], [PetID])
			VALUES
				(@Filename, @PetID)
		RETURN @@ROWCOUNT
	END
GO
-- *** Stored Procedures - Matthew Hill *** --
-- Author: <<Matthew Hill>>,Created:<<3/10/19>>

CREATE PROCEDURE [dbo].[sp_select_pet_image_filename_by_pet_id]
	(
		@PetID	[int]			
	)
AS
	BEGIN
		SELECT [Filename]
		FROM [PetImageFileName]
		WHERE [PetID] = @PetID
	END
GO
-- *** Stored Procedures - Matthew Hill *** --
-- Author: <<Matthew Hill>>,Created:<<3/10/19>>

CREATE PROCEDURE [dbo].[sp_update_pet_image_filename]
	(
		@PetID			[int],
		@OldFilename	[nvarchar](255),
		@NewFilename	[nvarchar](255)
	)
AS
	BEGIN
		UPDATE [dbo].[PetImageFileName]
		SET [Filename] = @NewFilename
		WHERE [PetID] = @PetID
			AND	[Filename] = @OldFilename
			
		RETURN @@ROWCOUNT
	END
GO

-- Created By: Alisa Roehr / Caitlin Abelson
-- Created On: 2019-04-09

CREATE PROCEDURE sp_retrieve_all_guests_ordered
AS
	BEGIN
		SELECT [GuestID], [MemberID], [GuestTypeID], [FirstName], 
			   [LastName], [PhoneNumber], [Email], 
			   [Minor], [Active], [CheckedIn]
		FROM   [Guest]
		ORDER BY [GuestID], [Active]
	END
GO

-- Created By: Alisa Roehr / Caitlin Abelson
-- Created On: 2019-04-09
CREATE PROCEDURE sp_check_out_guest_by_id
	(
		@GuestID		[nvarchar](17)
	)
AS
	BEGIN
		UPDATE 	[Guest]
		SET 	[CheckedIn] = 0
		WHERE	[GuestID] = @GuestID
		  
		RETURN @@ROWCOUNT		
	END
GO

-- Created By: Alisa Roehr / Caitlin Abelson
-- Created On: 2019-04-09
CREATE PROCEDURE sp_check_in_guest_by_id
	(
		@GuestID		[nvarchar](17)
	)
AS
	BEGIN
		UPDATE 	[Guest]
		SET 	[CheckedIn] = 1
		WHERE	[GuestID] = @GuestID
		  
		RETURN @@ROWCOUNT		
	END
GO

-- Created By: Alisa Roehr / Caitlin Abelson
-- Created On: 2019-04-09
CREATE PROCEDURE sp_retrieve_all_guest_types
AS
	BEGIN
		SELECT 		[GuestTypeID]
		FROM		[GuestType]
		ORDER BY 	[GuestTypeID]
	END
GO

/*  Created By: Eduardo Colon
    Date: 2019-03-25 
*/

CREATE PROCEDURE [dbo].[sp_retrieve_all_shuttle_reservations]

AS
	BEGIN
		SELECT 	  [ShuttleReservationID],[GuestID],[EmployeeID],[PickupLocation], [DropoffDestination],[PickupDateTime], [DropoffDateTime], [Active]
		FROM	  [ShuttleReservation]
	END
GO

/*  Created By: Eduardo Colon
  Date:   2019-03-25
*/
CREATE PROCEDURE [dbo].[sp_retrieve_shuttle_reservation_by_id]
	(
		@ShuttleReservationID			[int]
	)
AS
	BEGIN
		SELECT [ShuttleReservationID],[GuestID],[EmployeeID],[PickupLocation], [DropoffDestination],[PickupDateTime], [DropoffDateTime]
		FROM [ShuttleReservation]
		WHERE ShuttleReservationID = @ShuttleReservationID
	END
GO
/*  Created By: Eduardo Colon
 Date:   2019-03-25
*/
CREATE PROCEDURE sp_insert_shuttle_reservation
	(
	@GuestID							[int],
	@EmployeeID							[int],
	@PickupLocation						[nvarchar](150),
	@DropoffDestination					[nvarchar](150),
	@PickupDateTime						[datetime],				
	@DropoffDateTime					[datetime]
	
	)
AS
	BEGIN
		INSERT INTO [ShuttleReservation]
			([GuestID],[EmployeeID],[PickupLocation], [DropoffDestination],[PickupDateTime], [DropoffDateTime])
		VALUES
			(@GuestID, 	@EmployeeID,@PickupLocation, @DropoffDestination, @PickupDateTime,@DropoffDateTime)
	  
		RETURN @@ROWCOUNT
	END
GO



/*  Created By: Eduardo Colon
  Date:   2019-03-25
  */

CREATE PROCEDURE [dbo].[sp_update_shuttle_reservation_by_id]
	(
		
	@ShuttleReservationID			 		[int],
	@OldGuestID							    [int],
	@NewGuestID							    [int],
	@OldEmployeeID 							[int],
	@NewEmployeeID 							[int],
	@OldPickupLocation						[nvarchar](150),
	@NewPickupLocation						[nvarchar](150),
	@OldDropoffDestination					[nvarchar](150),
	@NewDropoffDestination					[nvarchar](150),
	@OldPickupDateTime						[datetime],	
	@NewPickupDateTime						[datetime]
	)
AS
	BEGIN
	
		BEGIN
			UPDATE [ShuttleReservation]
				SET   [GuestID]				 = 	@NewGuestID,
					  [EmployeeID]			 = 	@NewEmployeeID,
					  [PickupLocation]	 	 = 	@NewPickupLocation,
					  [DropoffDestination] 	 = 	@NewDropoffDestination,
					  [PickupDateTime]	 	 =  @NewPickupDateTime
				WHERE [ShuttleReservationID] =  @ShuttleReservationID
				AND	  [GuestID] 			 = 	@OldGuestID
				AND	  [EmployeeID] 			 = 	@OldEmployeeID
				AND   [PickupLocation]       = 	@OldPickupLocation
				AND	  [DropoffDestination]   = 	@OldDropoffDestination
				AND	  [PickupDateTime]       =  @OldPickupDateTime
			RETURN @@ROWCOUNT
		END
	END
GO

/*  Created By: Eduardo Colon
  Date:   2019-03-25
  */
CREATE PROCEDURE [dbo].[sp_shuttle_dropoff_time_now]
	(
	@ShuttleReservationID			 		[int],
	@OldGuestID							    [int],
	@OldEmployeeID 							[int],
	@OldPickupLocation						[nvarchar](150),
	@OldDropoffDestination					[nvarchar](150),
	@OldPickupDateTime						[datetime]
	)
AS
	BEGIN
	
		BEGIN
			UPDATE [ShuttleReservation]
				SET   [DropoffDateTime] = getutcdate()
				WHERE [ShuttleReservationID] =  @ShuttleReservationID
				AND	  [GuestID] 			 = 	@OldGuestID
				AND	  [EmployeeID] 			 = 	@OldEmployeeID
				AND   [PickupLocation]       = 	@OldPickupLocation
				AND	  [DropoffDestination]   = 	@OldDropoffDestination
				AND	  [PickupDateTime]       =  @OldPickupDateTime
			RETURN @@ROWCOUNT
		END
	END
GO


/*  Created By: Eduardo Colon
  Date:   2019-03-25
*/
CREATE PROCEDURE [dbo].[sp_delete_ShuttleReservationID ]
	(
		@ShuttleReservationID		[int]
	)
	
AS
	BEGIN
		DELETE
		FROM [ShuttleReservation]
		WHERE [ShuttleReservationID] = @ShuttleReservationID	
		RETURN @@ROWCOUNT
	END
GO

		
/*  Created By: Eduardo Colon
  Date:   2019-03-25
*/
CREATE PROCEDURE sp_deactivate_shuttle_reservation_by_id 
	(
		@ShuttleReservationID		[int]
	)
AS
	BEGIN
		UPDATE [ShuttleReservation]
		SET 	[Active] = 0
		WHERE 	[ShuttleReservationID] = @ShuttleReservationID
	  
		RETURN @@ROWCOUNT
	END
GO



/*  Created By: Eduardo Colon
  Date:   2019-03-25
*/
CREATE PROCEDURE sp_retrieve_shuttle_reservation_by_term_in_pickup_location
(
		@SearchTerm		[nvarchar](250)
	)
AS
	BEGIN
		SELECT   [ShuttleReservationID],[GuestID],[EmployeeID],[PickupLocation], [DropoffDestination],[PickupDateTime], [DropoffDateTime]
		FROM 	[ShuttleReservation]
		WHERE 	[PickupLocation] LIKE '%' + @SearchTerm + '%'
		
	END
GO


/*  Created By: Eduardo Colon
  Date:   2019-03-25
*/
CREATE PROCEDURE sp_retrieve_guest_by_term_in_last_name
(
		@SearchTerm		[nvarchar](250)
	)
AS
	BEGIN
		SELECT   [GuestID],[FirstName],[LastName],[PhoneNumber]
		FROM 	[Guest]
		WHERE 	[LastName] LIKE '%' + @SearchTerm + '%'
		
	END
GO


/*  Created By: Eduardo Colon
  Date:   2019-03-25
*/
CREATE PROCEDURE [dbo].[sp_retrieve_employee_info_by_id]
(
	@EmployeeID [int]
)
AS
	BEGIN
		SELECT [EmployeeID],[FirstName],[LastName]
		FROM [Employee]
		WHERE [EmployeeID] = @EmployeeID
	END
GO

/*  Created By: Eduardo Colon
  Date:   2019-03-25
*/
CREATE PROCEDURE [dbo].[sp_retrieve_employee_info]

AS
	BEGIN
		SELECT [EmployeeID],[FirstName],[LastName]
		FROM [Employee]
	END
GO

/*  Created By: Eduardo Colon
  Date:   2019-03-25
*/
CREATE PROCEDURE [dbo].[sp_retrieve_guest_info_by_id]
(
	@GuestID [int]
)
AS
	BEGIN
		SELECT [GuestID],[FirstName],[LastName],[PhoneNumber]
		FROM [Guest]
		WHERE [GuestID] = @GuestID
	END
GO

/*  Created By: Eduardo Colon
  Date:   2019-03-25
*/
CREATE PROCEDURE [dbo].[sp_retrieve_guest_info]

AS
	BEGIN
		SELECT [GuestID],[FirstName],[LastName],[PhoneNumber]
		FROM [Guest]
	END
GO

/*  Created By: Eduardo Colon
  Date:   2019-03-25
*/
CREATE PROCEDURE [dbo].[sp_retrieve_active_shuttle_reservation]
AS
	BEGIN
		SELECT [ShuttleReservationID],[GuestID],[EmployeeID],[PickupLocation], [DropoffDestination],[PickupDateTime], [DropoffDateTime], [Active]
		FROM [ShuttleReservation]
		WHERE [Active] = 1
	END
GO

/*  Created By: Eduardo Colon
  Date:   2019-03-25
*/
CREATE PROCEDURE [dbo].[sp_retrieve_inactive_shuttle_reservation]
AS
	BEGIN
		SELECT [ShuttleReservationID],[GuestID],[EmployeeID],[PickupLocation], [DropoffDestination],[PickupDateTime], [DropoffDateTime], [Active]
		FROM [ShuttleReservation]
		WHERE [Active] = 0
	END
GO

EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-05 Desc', @value=N'Added inactive search to where clause' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_activate_guest_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Carlos Arzu' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_count_supplier_order'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'Unknown' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_count_supplier_order'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Craig Barkley' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_create_event_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_create_event_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Eric Bostwick' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_create_itemsupplier'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-04' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_create_itemsupplier'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-09 Author', @value=N'Austin Delaney' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_create_itemsupplier'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-09 Desc', @value=N'Removed transaction and re-wrote SP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_create_itemsupplier'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Craig Barkley' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_create_pet_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_create_pet_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Carlos Arzu' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_create_supplierOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'Unknown' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_create_supplierOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Caitlin Abelson' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_deactivate_employee'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-02' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_deactivate_employee'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Eric Bostwick' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_deactivate_itemsupplier_by_itemid_and_supplierid'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-07' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_deactivate_itemsupplier_by_itemid_and_supplierid'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Ramesh Adhikari' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_deactivate_member'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-21' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_deactivate_member'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_deactivate_recipe'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-14' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_deactivate_recipe'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Matt Lamarche' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_deactivate_reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-26' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_deactivate_reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Carlos Arzu' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_deactivate_SupplierOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'Unknown' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_deactivate_SupplierOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_appointment_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_appointment_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_department'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_department'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Caitlin Abelson' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_employee'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-02' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_employee'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Caitlin Abelson' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_employeeID_role'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_employeeID_role'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Craig Barkley' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_event_type_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_event_type_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-06 Desc', @value=N'Corrected param from an nvarchar to an int' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_guest_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_guest_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_guest_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_item_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_item_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Eric Bostwick' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_itemsupplier_by_itemid_and_supplierid'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-07' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_itemsupplier_by_itemid_and_supplierid'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-06 Desc', @value=N'Added rowcount return' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_itemsupplier_by_itemid_and_supplierid'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_maintenance_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_maintenance_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Ramesh Adhikari' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_member'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-21' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_member'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_offering_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_offering_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Craig Barkley' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_pet'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_pet'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Craig Barkley' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_pet_type_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_pet_type_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_recipe'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-14' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_recipe'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_recipe_item_lines'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-29' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_recipe_item_lines'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Matt Lamarche' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-26' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_roles'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_roles'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_room_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_room_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_appointment_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_appointment_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_building'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-22' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_building'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-18 Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_building'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-18 Desc', @value=N'Changed length for Description, added BuildingStatusID parameter and field' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_building'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-20 Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_building'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-20 Desc', @value=N'Added ResortPropertyID parameter and field' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_building'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-22 Author', @value=N'Jared Greenfield and Jim Glasgow' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_building'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-22 Desc', @value=N'Syntax update for the ResortProperty field and removed param' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_building'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_department'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_department'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-06 Desc', @value=N'Removed scope identity select. Updated description field to correct size' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_department'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Caitlin Abelson' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_employee'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-27' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_employee'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-23 Author', @value=N'Alisa Roehr' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_guest'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-23 Desc', @value=N'Added fields for Emergency contact info and Receive Texts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_guest'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_guest_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_guest_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-06 Desc', @value=N'Removed scope identity select. Updated description field to correct size' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_guest_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_item_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_item_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-06 Desc', @value=N'Removed scope identity select. Updated description field to correct size' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_item_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_maintenance_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_maintenance_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-06 Desc', @value=N'Removed scope identity select. Updated description field to correct size' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_maintenance_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Ramesh Adhikari' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_member'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-21' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_member'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_offering'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-22' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_offering'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-10 Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_offering'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-10 Desc', @value=N'Replaced row count return with scope identity return' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_offering'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_offering_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_offering_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-06 Desc', @value=N'Removed scope identity select. Updated description field to correct size' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_offering_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-06 Desc', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_product'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_recipe'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-22' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_recipe'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-10 Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_recipe'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-10 Desc', @value=N'Removed OfferingID insert, added scope identity return' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_recipe'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_roles'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_roles'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-28 Author', @value=N'Austin Delaney' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_roles'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-28 Desc', @value=N'Removed scope identity return' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_roles'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-06 Desc', @value=N'Updated description length' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_roles'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_room_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_room_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-06 Desc', @value=N'Removed scope identity select. Updated description field to correct size' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_room_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'James Heim' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_shop'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-27' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_shop'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Eric Bostwick' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_supplier_order'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-26' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_supplier_order'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Creates Supplier Order Returns the Supplier Order ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_supplier_order'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Eric Bostwick' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_supplier_order_line'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-26' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_supplier_order_line'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Dalton Cleveland' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_work_order'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-13' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_work_order'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_reactivate_recipe'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-14' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_reactivate_recipe'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Craig Barkley' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_all_event_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_all_event_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Phillip Hansen' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_all_events'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_all_events'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Matt Lamarche' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_all_reservations'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-26' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_all_reservations'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Carlos Arzu' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_all_supplier_order'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'Unknown' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_all_supplier_order'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Matt Lamarche' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_all_view_model_reservations'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-26' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_all_view_model_reservations'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_appointment_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_appointment_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_departmentTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_departmentTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Matt Lamarche' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_employee_by_email'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-27' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_employee_by_email'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guest_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guest_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-23 Author', @value=N'Alisa Roehr' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guests_by_email'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-23 Desc', @value=N'Added fields for Emergency contact info and Receive Texts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guests_by_email'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-23 Author', @value=N'Alisa Roehr' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guests_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-23 Desc', @value=N'Added fields for Emergency contact info and Receive Texts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guests_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Alisa Roehr' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guests_by_name'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-23' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guests_by_name'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-23 Author', @value=N'Austin Delaney' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guests_by_name'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-23 Desc', @value=N'Updated where cause to use a LIKE operator instead of an =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guests_by_name'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guestTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guestTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_item_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_item_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Carlos Arzu' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_List_of_EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'Unknown' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_List_of_EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_maintenance_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_maintenance_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Ramesh Adhikari' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_member_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-21' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_member_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_offering_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_offering_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_roleID'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_roleID'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_roles'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_roles'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Eduardo Colon' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_roles_by_term_in_description'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-23' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_roles_by_term_in_description'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-28 Author', @value=N'Austin Delaney' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_roles_by_term_in_description'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-28 Desc', @value=N'Removed active search' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_roles_by_term_in_description'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_roomTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_roomTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Kevin Broskow' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_all_active_items_extended'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-28' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_all_active_items_extended'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Kevin Broskow' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_all_deactivated_items'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-28' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_all_deactivated_items'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Caitlin Abelson' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_all_employees'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-06' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_all_employees'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Kevin Broskow' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_all_items'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-28' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_all_items'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_all_recipes'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-07' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_all_recipes'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_all_statusids'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-20' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_all_statusids'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_buildingstatusid'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-19' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_buildingstatusid'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-20 Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_buildingstatusid'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-20 Desc', @value=N'Removed Active field, removed "Order by Active"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_buildingstatusid'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-30' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-18 Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-18 Desc', @value=N'Added BuildingStatusID field' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-20 Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-20 Desc', @value=N'Removed Active field' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_keyword_in_building_name'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-02' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_keyword_in_building_name'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-18 Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_keyword_in_building_name'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-18 Desc', @value=N'Added BuildingSatusID field' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_keyword_in_building_name'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-20 Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_keyword_in_building_name'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-20 Desc', @value=N'Removed Active field, removed "Order by Active"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_building_by_keyword_in_building_name'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_buildings'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-30' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_buildings'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-18 Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_buildings'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-18 Desc', @value=N'Removed Active field, removed "Order by Active"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_buildings'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Caitlin Abelson' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_department'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-29' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_department'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Caitlin Abelson' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_employee_active'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-14' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_employee_active'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Caitlin Abelson' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_employee_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-27' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_employee_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Caitlin Abelson' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_employee_inactive'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-14' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_employee_inactive'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Craig Barkley' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_event_type_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_event_type_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Kevin Broskow' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_item'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-28' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_item'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_item_by_recipeid'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-07' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_item_by_recipeid'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Eric Bostwick' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_itemsupplier_by_itemid_and_supplierid'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-04' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_itemsupplier_by_itemid_and_supplierid'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Eric Bostwick' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_itemsuppliers_by_itemid'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-04' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_itemsuppliers_by_itemid'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_line_items_by_recipeid'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-27' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_line_items_by_recipeid'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Matt Lamarche' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_member_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-07' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_member_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_offering'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-22' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_offering'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Craig Barkley' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_pet_type_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_pet_type_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_recipe'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-27' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_recipe'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_recipe_item_lines'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-28' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_recipe_item_lines'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Matt Lamarche' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-26' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'James Heim' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_shop_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-03-01' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_shop_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'James Heim' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_shops'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-27' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_shops'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Caitlin Abelson' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_suppliers'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-23' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_suppliers'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Eric Bostwick' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_suppliers_for_itemsupplier_mgmt_by_itemid'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-07' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_suppliers_for_itemsupplier_mgmt_by_itemid'
GO
EXEC sys.sp_addextendedproperty @name=N'Returns all the suppliers not setup in the itemsupplier table for that item. This is so user doesn''t get the option to add a sup', @value=N'2019-02-07' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_suppliers_for_itemsupplier_mgmt_by_itemid'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'James Heim' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_view_model_shops'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-28' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_view_model_shops'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_building'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-30' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_building'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-18 Author', @value=N'Danielle Russo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_building'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-18 Desc', @value=N'Changed length of Description parameters, added BuildingStatusID field and parameters' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_building'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Caitlin Abelson' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_employee_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-01' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_employee_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-23 Author', @value=N'Alisa Roehr' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_guest_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-02-23 Desc', @value=N'Added fields for Emergency contact info and Receive Texts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_guest_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Eric Bostwick' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_itemsupplier'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-04' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_itemsupplier'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_offering'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-22' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_offering'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Jared Greenfield' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_recipe'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-07' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_recipe'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Matt Lamarche' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-26' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Eduardo Colon' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_role_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-23' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_role_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Carlos Arzu' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_SupplierOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'Unknown' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_update_SupplierOrder'
GO
