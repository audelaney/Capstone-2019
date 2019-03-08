USE [MillennialResort_DB]
GO
/****** Object:  StoredProcedure [dbo].[sp_activate_guest_by_id]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_add_pet]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_add_pet]
	(
		@PetID		[int],
		@GuestID	[int],
		@PetTypeID	[nvarchar](15),
		@PetName	[nvarchar](50),
		@Active  	[bit]
	)
AS
	BEGIN
		INSERT INTO [dbo].[Table]
			([PetID],[GuestID], [PetTypeID], [PetName], [Active])
		VALUES
			(@PetID, @GuestID, @PetTypeID, @PetName, @Active)
		RETURN @@ROWCOUNT
	END
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-05 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_add_pet'

GO
/****** Object:  StoredProcedure [dbo].[sp_add_Pet_Type]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_add_Pet_Type]
	(
		@PetID		[int],
		@GuestID	[int],
		@PetTypeID	[nvarchar](15),
		@PetName	[nvarchar](50),
		@Active  	[bit]
	)
AS
	BEGIN
		INSERT INTO [dbo].[Table]
			([PetID],[GuestID], [PetTypeID], [PetName], [Active])
		VALUES
			(@PetID, @GuestID, @PetTypeID, @PetName, @Active)
		RETURN @@ROWCOUNT
	END
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-05 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_add_Pet_Type'

GO
/****** Object:  StoredProcedure [dbo].[sp_authenticate_user]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_count_supplier_order]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_create_drink]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_create_drink]
(
@RecipieID 		[int],
@OfferingID 	[int],
@Description	[nvarchar](1000),
@DateAdded		[Date]
)
AS
	BEGIN
		INSERT INTO [dbo].[Recipe]
		([RecipeID], [OfferingID], [Description], [DateAdded])

		VALUES
		(@RecipieID, @OfferingID, @Description, @DateAdded)

		RETURN @@ROWCOUNT
	END

EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-05 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_create_drink'

GO
/****** Object:  StoredProcedure [dbo].[sp_create_reservation]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_create_supplierOrder]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_deactivate_employee]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_deactivate_guest_by_id]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_deactivate_itemsupplier_by_itemid_and_supplierid]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_deactivate_member]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_deactivate_reservation]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_deactivate_SupplierOrder]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_appointment_type]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_department]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_employee]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_employeeID_role]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_event]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_guest_by_id]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_guest_type]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_item_type]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_itemsupplier_by_itemid_and_supplierid]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_maintenance_type]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_member]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_offering_type]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_performance]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_reservation]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_roles]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_room_type]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_appointment_type]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_building]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_department]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_employee]    Script Date: 3/8/2019 7:30:07 AM ******/
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

		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_event]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_event]
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
/****** Object:  StoredProcedure [dbo].[sp_insert_event_request]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_event_type]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_guest]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_guest_type]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_item]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_item_type]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_maintenance_type]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_member]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_offering]    Script Date: 3/8/2019 7:30:07 AM ******/
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
		RETURN @@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_insert_offering_type]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_performance]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_performance]
	(
		@PerformanceDate	[date],
		@Description		[nvarchar](1000),
		@PerformanceTitle	[nvarchar](100)
	)
AS
	BEGIN
		INSERT INTO [dbo].[Performance]
			([PerformanceDate], [Description], [PerformanceTitle])
		VALUES
			(@PerformanceDate, @Description, @PerformanceTitle)
	END
EXEC sys.sp_addextendedproperty
	@name=N'Update 2019-03-06 Author',
	@value=N'Austin Delaney',
	@level0type=N'SCHEMA',@level0name=N'dbo',
	@level1type=N'PROCEDURE',@level1name=N'sp_insert_offering_type'

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_product]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_recipe]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_recipe]
	(
		@Name 			[nvarchar](50),
		@Description 	[nvarchar](1000),
		@OfferingID		[int]
	)
AS
	BEGIN
		INSERT INTO [Recipe]
		([Name], [Description], [OfferingID])
		VALUES
		(@Name, @Description, @OfferingID)
		RETURN @@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_insert_recipe_item_line]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_roles]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_room]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_room]
	(
	@RoomNumber			[nvarchar](15),
	@BuildingID			[nvarchar](50),
	@RoomTypeID			[nvarchar](15),
	@Description		[nvarchar](1000),
	@Capacity			[int],
	@Available			[bit]
	)
AS
	BEGIN
		INSERT INTO [dbo].[Room]
			([RoomNumber], [BuildingID], [RoomTypeID], [Description], [Capacity], [Available])
		VALUES
			(@RoomNumber, @BuildingID, @RoomTypeID, @Description, @Capacity, @Available)
		SELECT SCOPE_IDENTITY()
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_insert_room_type]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_shop]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_supplier]    Script Date: 3/8/2019 7:30:07 AM ******/
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
		@ContactLastName	nvarchar(100)
	)
AS
	BEGIN
		INSERT INTO [dbo].[Supplier]
		([Name], [Address], [City], [State], [PostalCode], [Country], [PhoneNumber], [Email], [ContactFirstName], [ContactLastName])
		VALUES
			(@Name, @Address, @City, @State, @PostalCode, @Country, @PhoneNumber, @Email, @ContactFirstName, @ContactLastName)
		RETURN SCOPE_IDENTITY();
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_insert_supplier_order]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_supplier_order_line]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_work_order]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retireve_all_event_requests]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_event_types]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_events]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_all_events]
AS
	BEGIN
		SELECT
		[EventID],
		[EventTitle],
		[Event].[EmployeeID],
		[Employee].[FirstName],
		[EventTypeID] AS [EventType],
		[Description],[EventStartDate],
		[EventEndDate],
		[KidsAllowed],
		[NumGuests],
		[Location],
		[Sponsored],
		[Approved]
		FROM	[dbo].[Employee] INNER JOIN [dbo].[Event]
			ON		[Employee].[EmployeeID] = [Event].[EmployeeID]
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_guest_types]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_all_guest_types]
AS
	BEGIN
		SELECT 		[GuestTypeID]
		FROM		[GuestType]
		ORDER BY 	[GuestTypeID]
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_guests]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_all_guests]
AS
	BEGIN
		SELECT [GuestID], [MemberID], [GuestTypeID], [FirstName],
			   [LastName], [PhoneNumber], [Email],
			   [Minor], [Active]
		FROM   [Guest]
		ORDER BY [GuestID], [Active]
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_members]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_Pet]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_all_Pet]

AS
	BEGIN
		SELECT [GuestID], [PetTypeID], [PetName],[Active]
		FROM   [Pet]
		ORDER BY [petID], [Active]
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_Pet_Type]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_all_Pet_Type]

AS
	BEGIN
        SELECT 	[Description], [Species]
		FROM	[PetType]

	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_reservations]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_supplier_order]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_view_model_reservations]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_appointment_types]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_buildings]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_departments]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_departmentTypes]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_employee_by_email]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_employee_roles]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_event]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_event]
	(
		@EventID [int]
	)
AS
	BEGIN
		SELECT  [EventID],[EventTitle],[EmployeeID],[EventTypeID],[Description],
				[EventStartDate],[EventEndDate],[KidsAllowed],[NumGuests], [Location], [Sponsored], [Approved]
		FROM	[dbo].[Event]
		WHERE	[EventID] = @EventID
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_guest_types]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_guests_by_email]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_guests_by_id]    Script Date: 3/8/2019 7:30:07 AM ******/
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
			   [EmergencyLastName], [EmergencyPhoneNumber], [EmergencyRelation]
		FROM   [Guest]
		WHERE 	[GuestID] = @GuestID
		AND		[Active] = 1
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_guests_by_name]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_guestTypes]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_item_types]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_itemtypes]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_List_of_EmployeeID]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_maintenance_types]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_member_by_id]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_offering_types]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_roleID]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_roles]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_roles_by_term_in_description]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_room_types]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_roomTypes]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_suppliers]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retrieve_suppliers]

AS
	BEGIN
		SELECT 	    [Name], [ContactFirstName], [ContactLastName],	[PhoneNumber], [Email], [DateAdded], [Address], [City], [State], [Country], [PostalCode], [Description], [Active]
		FROM		[Suppliers]
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_user_names_by_email]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_all_active_items]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_all_active_items_extended]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_all_deactivated_items]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_all_employees]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_all_item_types]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_all_items]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_all_items]
	AS
		BEGIN
		SELECT [ItemID], [ItemTypeID], [Description], [OnHandQuantity], [Name], [ReOrderQuantity], [DateActive], [Active], [CustomerPurchasable], [RecipeID]
		FROM	[Product]
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_all_itemtypes]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_all_performance]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_all_performance]
AS
	BEGIN
		SELECT [PerformanceID], [PerformanceDate], [Description]
		FROM [Performance]
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_select_all_statusids]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_building_by_buildingstatusid]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_building_by_id]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_building_by_keyword_in_building_name]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_buildings]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_select_buildings]
AS
	BEGIN
		SELECT 		[BuildingID], [BuildingName], [Address], [Description], [BuildingStatusID]
		FROM		[Building]
		ORDER BY	[BuildingID]
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_department]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_employee_active]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_employee_by_id]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_employee_inactive]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_item]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_item_by_itemid]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_itemsuppliers_by_supplierid]    Script Date: 3/8/2019 7:30:07 AM ******/
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
[p].[ItemTypeID], [p].[Description], [p].[OnHandQuantity], [p].[Name], [p].[ReOrderQuantity],
[p].[DateActive], [p].[Active], [p].[CustomerPurchasable], [p].[RecipeID], [p].[OfferingID]
FROM   [dbo].[ItemSupplier] [isup] JOIN Product [p] on [p].[ItemID] = [isup].[ItemID]
WHERE  [isup].[SupplierID] = @SupplierID AND [isup].[Active] = 1

END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_member_by_id]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_performance_by_id]    Script Date: 3/8/2019 7:30:07 AM ******/
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
		SELECT 	[PerformanceID], [PerformanceDate], [Description]
		FROM [Performance]
		WHERE [PerformanceID] = @PerformanceID
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_select_reservation]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_shop_by_id]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_shops]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_suppliers]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_select_suppliers]
AS
	BEGIN
		SELECT 	    [Name], [ContactFirstName], [ContactLastName],	[PhoneNumber], [SupplierEmail], [DateAdded], [Address], [City], [StateCode], [Country], [ZipCode], [Description], [Active]
		FROM		[Suppliers]
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_suppliers_for_itemsupplier_mgmt_by_itemid]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_view_model_shops]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_building]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_employee_by_id]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_employee_email]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_event]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_update_event]
	(
		@EventID				[int],
		@EventTitle			[nvarchar](50),
		@EmployeeID			 		[int],
		@EventTypeID				[nvarchar](15),
		@Description				[nvarchar](1000),
		@EventStartDate		[date],
		@EventEndDate				[date],
		@KidsAllowed				[bit],
		@NumGuests					[int],
		@Location					[nvarchar](50),
		@Sponsored					[bit],
		@Approved					[bit],

		@OldEventTitle			[nvarchar](50),
		@OldEmployeeID			 		[int],
		@OldEventTypeID					[nvarchar](15),
		@OldDescription					[nvarchar](1000),
		@OldEventStartDate		[date],
		@OldEventEndDate				[date],
		@OldKidsAllowed					[bit],
		@OldNumGuests					[int],
		@OldLocation					[nvarchar](50),
		@OldSponsored					[bit],
		@OldApproved					[bit]

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
				[Approved] = @Approved
		FROM 	[dbo].[Event]
		WHERE	[EventID] = @EventID
		AND 	[EventTitle] = @OldEventTitle
		AND		[EmployeeID] = @OldEmployeeID
		AND		[EventTypeID] = @OldEventTypeID
		AND		[Description] = @OldDescription
		AND		[EventStartDate] = @OldEventStartDate
		AND		[EventEndDate] = @OldEventEndDate
		AND		[KidsAllowed] = @OldKidsAllowed
		AND		[NumGuests] = @OldNumGuests
		AND		[Location] = @OldLocation
		AND 	[Sponsored] = @OldSponsored
		AND		[Approved] = @OldApproved

			RETURN @@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_update_guest_by_id]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_itemsupplier]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_password_hash]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_performance]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_update_performance]
	(
		@PerformanceID		[int],
		@PerformanceDate	[date],
		@Description		[nvarchar](1000)
	)
AS
	BEGIN
		UPDATE [Performance]
			SET [PerformanceDate] = @PerformanceDate, [Description] = @Description
			WHERE [PerformanceID] = @PerformanceID
		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_Pet]    Script Date: 3/8/2019 7:30:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_update_Pet]
	(
		@PetID	 [int],

		@GuestID	[int],
		@PetTypeID	[nvarchar](15),
		@PetName	[nvarchar](50),
		@Active  	[bit],

		@OldGuestID	    [int],
		@OldPetTypeID	[nvarchar](15),
		@OldPetName		[nvarchar](50),
		@OldActive  	[bit]

	)
	AS
	BEGIN

		UPDATE	[Pet]
		SET 	[GuestID]	=	@GuestID,
				[PetTypeID]	=	@PetTypeID,
				[PetName]   =	@PetName,
				[Active]   	=	@Active
		FROM	[dbo].[Pet]
		WHERE	[PetID] 	=   @PetID
		  AND	[GuestID]	=	@OldGuestID
		  AND	[PetTypeID]	=	@OldPetTypeID
		  AND	[PetName]   =	@OldPetName
		  AND	[Active]   	=	@OldActive


		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_Pet_Type]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_reservation]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_role_by_id]    Script Date: 3/8/2019 7:30:07 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_SupplierOrder]    Script Date: 3/8/2019 7:30:07 AM ******/
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
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-05 Desc', @value=N'Added inactive search to where clause' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_activate_guest_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-05 Desc', @value=N'Removed identity insert to the Item table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_add_pet'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-05 Desc', @value=N'Removed identity insert to the Item table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_add_Pet_Type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Carlos Arzu' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_count_supplier_order'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'Unknown' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_count_supplier_order'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-05 Desc', @value=N'Adjusted to the Recipe table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_create_drink'
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
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_offering_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_offering_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-06 Desc', @value=N'Removed scope identity select. Updated description field to correct size' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_offering_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Update 2019-03-06 Desc', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_product'
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
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Kevin Broskow' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_item'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-01-28' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_item'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Matt Lamarche' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_member_by_id'
GO
EXEC sys.sp_addextendedproperty @name=N'Created Date', @value=N'2019-02-07' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_select_member_by_id'
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
