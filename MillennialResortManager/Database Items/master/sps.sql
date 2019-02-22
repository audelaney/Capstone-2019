USE [MillennialResort_DB]
GO
/****** Object:  StoredProcedure [dbo].[sp_activate_guest_by_id]    Script Date: 2/22/2019 12:17:50 PM ******/
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

		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_add_pet]    Script Date: 2/22/2019 12:17:50 PM ******/
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

		SET IDENTITY_INSERT [dbo].[Item] ON

		INSERT INTO [dbo].[Table]
			([PetID],[GuestID], [PetTypeID], [PetName], [Active])
		VALUES
			(@PetID, @GuestID, @PetTypeID, @PetName, @Active)

		SET IDENTITY_INSERT [dbo].[Item] OFF

		RETURN @@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_add_Pet_Type]    Script Date: 2/22/2019 12:17:50 PM ******/
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

		SET IDENTITY_INSERT [dbo].[Item] ON

		INSERT INTO [dbo].[Table]
			([PetID],[GuestID], [PetTypeID], [PetName], [Active])
		VALUES
			(@PetID, @GuestID, @PetTypeID, @PetName, @Active)

		SET IDENTITY_INSERT [dbo].[Item] OFF

		RETURN @@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_authenticate_user]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_create_drink]    Script Date: 2/22/2019 12:17:50 PM ******/
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
		INSERT INTO [dbo].[Recipie]
		([RecipieID], [OfferingID], [Description], [DateAdded])

		VALUES
		(@RecipieID, @OfferingID, @Description, @DateAdded)

		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_create_reservation]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_deactivate_guest_by_id]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_deactivate_member]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_appointment_type]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_department]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_event]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_guest_by_id]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_delete_guest_by_id]
	(
		@GuestID		[nvarchar](17)
	)
AS
	BEGIN
		DELETE
		FROM	[Guest]
		WHERE	[GuestID] = @GuestID
		  AND	[Active] = 0

		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_guest_type]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_item_type]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_maintenance_type]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_member]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_offering_type]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_performance]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_roles]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_room_type]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_appointment_type]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_building]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_building]
	(
		@BuildingID		[nvarchar](15),
		@Description	[nvarchar](1000)
	)
AS
	BEGIN
		INSERT INTO [Building]
			([BuildingID],[Description])
		VALUES
			(@BuildingID, @Description)

		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_department]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[sp_insert_department]
	(
		@DepartmentID		[nvarchar](50),
		@Description		[nvarchar](250)	
	)
AS
	BEGIN
		INSERT INTO [Department]
			([DepartmentID], [Description])
		VALUES
			(@DepartmentID, @Description)
			
		RETURN @@ROWCOUNT
		SELECT SCOPE_IDENTITY()
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_event]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_event_request]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_event_type]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_eventType]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_eventType]
	(
		@EventTypeID 	[nvarchar](15),
		@Description 	[nvarchar](1000)
	)
AS
	BEGIN
		INSERT INTO [dbo].[EventType]
			([EventTypeID],[Description])
		VALUES
			(@EventTypeID, @Description)

		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_guest]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_guest]
	(
		@MemberID		[int],
		@GuestTypeID	[nvarchar](25),
		@FirstName		[nvarchar](50),
		@LastName		[nvarchar](100)	,
		@PhoneNumber	[nvarchar](11),
		@Email			[nvarchar](250),
		@Minor			[bit]
	)
AS
	BEGIN
		INSERT INTO [dbo].[Guest]
			([MemberID], [GuestTypeID], [FirstName],
			[LastName], [PhoneNumber], [Email], [Minor])
		VALUES
			(@MemberID, @GuestTypeID, @FirstName, @LastName,
			@PhoneNumber, @Email, @Minor)

		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_guest_type]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO








CREATE PROCEDURE [dbo].[sp_insert_guest_type]
	(
		@GuestTypeID		[nvarchar](25),
		@Description		[nvarchar](50)	
	)
AS
	BEGIN
		INSERT INTO [GuestType]
			([GuestTypeID], [Description])
		VALUES
			(@GuestTypeID, @Description)
			
		RETURN @@ROWCOUNT
		SELECT SCOPE_IDENTITY()
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_item]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_item_type]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[sp_insert_item_type]
	(
		@ItemTypeID			[nvarchar](15),
		@Description		[nvarchar](250)	
	)
AS
	BEGIN
		INSERT INTO [ItemType]
			([ItemTypeID], [Description])
		VALUES
			(@ItemTypeID, @Description)
			
		RETURN @@ROWCOUNT
		SELECT SCOPE_IDENTITY()
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_maintenance_type]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_insert_maintenance_type]
	(
		@MaintenanceTypeID	[nvarchar](15),
		@Description		[nvarchar](250)	
	)
AS
	BEGIN
		INSERT INTO [MaintenanceType]
			([MaintenanceTypeID], [Description])
		VALUES
			(@MaintenanceTypeID, @Description)
			
		RETURN @@ROWCOUNT
		SELECT SCOPE_IDENTITY()
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_member]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_offering]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_offering_type]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_insert_offering_type]
	(
		@OfferingTypeID	[nvarchar](15),
		@Description		[nvarchar](250)	
	)
AS
	BEGIN
		INSERT INTO [OfferingType]
			([OfferingTypeID], [Description])
		VALUES
			(@OfferingTypeID, @Description)
			
		RETURN @@ROWCOUNT
		SELECT SCOPE_IDENTITY()
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_performance]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_performance]
	(
		@PerformanceDate	[date],
		@Description		[nvarchar](1000)
	)
AS
	BEGIN
		INSERT INTO [dbo].[Performance]
			([PerformanceDate], [Description])
		VALUES
			(@PerformanceDate, @Description)
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_product]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_insert_product]
(
	@ItemTypeID		[nvarchar](15),
	@Description	[nvarchar](1000),
	@OnHandQuantity		[int],
	@Name				[nvarchar](50),
	@ReOrderQuantity	[int],
	@DateActive			[date]
)
AS
	BEGIN
		INSERT INTO [Product]
			([ItemTypeID],[Description], [OnHandQuantity], [Name], [ReOrderQuantity], [DateActive])
		VALUES
			(@ItemTypeID, @Description, @OnHandQuantity, @Name, @ReOrderQuantity, @DateActive)
		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_recipe]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_recipe_item_line]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_roles]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO











CREATE PROCEDURE [dbo].[sp_insert_roles]
	(
		@RoleID				[nvarchar](50),
		@Description		[nvarchar](250)	
	)
AS
	BEGIN
		INSERT INTO [Role]
			([RoleID], [Description])
		VALUES
			(@RoleID, @Description)
			
		RETURN @@ROWCOUNT
		SELECT SCOPE_IDENTITY()
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_room]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_insert_room]
	(
	@RoomNumber			[nvarchar](15),
	@BuildingID			[nvarchar](15),
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
/****** Object:  StoredProcedure [dbo].[sp_insert_room_type]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE PROCEDURE [dbo].[sp_insert_room_type]
	(
		@RoomTypeID			[nvarchar](15),
		@Description		[nvarchar](250)	
	)
AS
	BEGIN
		INSERT INTO [RoomType]
			([RoomTypeID], [Description])
		VALUES
			(@RoomTypeID, @Description)
			
		RETURN @@ROWCOUNT
		SELECT SCOPE_IDENTITY()
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_supplier]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_work_order]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retireve_all_event_requests]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_retireve_all_event_requests]
AS
	BEGIN
		SELECT [EventTitle], [EventTypeID],[Description],[EventStartDate],
				[EventEndDate],[KidsAllowed],[NumGuests], [Location], [Sponsored], [SponsorID], [Approved]
		FROM	[dbo].[Event]
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_event_types]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_guest_types]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_guests]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_members]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_Pet]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_all_Pet_Type]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_appointment_types]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_buildings]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_departments]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_departmentTypes]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_employee_roles]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_event]    Script Date: 2/22/2019 12:17:50 PM ******/
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
				[EventStartDate],[EventEndDate],[KidsAllowed],[NumGuests], [Location], [Sponsored], [SponsorID], [Approved]
		FROM	[dbo].[Event]
		WHERE	[EventID] = @EventID
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_guest_types]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_guests_by_email]    Script Date: 2/22/2019 12:17:50 PM ******/
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
			   [Minor], [Active]
		FROM   [Guest]
		WHERE 	[Email] = @Email
		AND		[Active] = 1
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_guests_by_id]    Script Date: 2/22/2019 12:17:50 PM ******/
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
			   [Minor], [Active]
		FROM   [Guest]
		WHERE 	[GuestID] = @GuestID
		AND		[Active] = 1
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_retrieve_guestTypes]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_item_types]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_itemtypes]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_maintenance_types]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_member_by_id]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_offering_types]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_roleID]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_roles]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_room_types]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_roomTypes]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_suppliers]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_retrieve_user_names_by_email]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_all_active_items]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_all_item_types]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_all_itemtypes]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_all_performance]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_item_by_itemid]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_select_performance_by_id]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_employee_email]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_event]    Script Date: 2/22/2019 12:17:50 PM ******/
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
		@SponsorID				[int],
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
		@OldSponsorID					[int],
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
				[SponsorID] = @SponsorID,
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
		AND 	[SponsorID] = @OldSponsorID
		AND		[Approved] = @OldApproved

			RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_guest_by_id]    Script Date: 2/22/2019 12:17:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_update_guest_by_id]
	(
		@GuestID			[int],

		@MemberID			[int],
		@GuestTypeID		[nvarchar](25),
		@FirstName			[nvarchar](50),
		@LastName			[nvarchar](100)	,
		@PhoneNumber		[nvarchar](11),
		@Email				[nvarchar](250),
		@Minor				[bit],
		@Active				[bit],

		@OldMemberID		[int],
		@OldGuestTypeID		[nvarchar](25),
		@OldFirstName		[nvarchar](50),
		@OldLastName		[nvarchar](100)	,
		@OldPhoneNumber		[nvarchar](11),
		@OldEmail			[nvarchar](250),
		@OldMinor			[bit],
		@OldActive			[bit]
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
				[Active] = @Active
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

		RETURN @@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_password_hash]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_performance]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_Pet]    Script Date: 2/22/2019 12:17:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_Pet_Type]    Script Date: 2/22/2019 12:17:50 PM ******/
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
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Ramesh Adhikari' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_deactivate_member'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-21' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_deactivate_member'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_appointment_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_appointment_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_department'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_department'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_guest_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_guest_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_item_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_delete_item_type'
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
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_department'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_department'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_guest_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_guest_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_item_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_item_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_maintenance_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_maintenance_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Ramesh Adhikari' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_member'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-21' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_member'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_offering_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_offering_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_roles'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_roles'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_room_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_room_type'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Dalton Cleveland' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_work_order'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-13' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_insert_work_order'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_appointment_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_appointment_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_departmentTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_departmentTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guest_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guest_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guestTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_guestTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Austin Berquam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_item_types'
GO
EXEC sys.sp_addextendedproperty @name=N'Date Created', @value=N'2019-02-18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_retrieve_item_types'
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