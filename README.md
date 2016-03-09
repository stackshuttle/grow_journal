# GrowJournal

GrowJournal is a web application that allows you to keep track
of the growth of your plants (vegetables, fruits or flowers).

To start your GrowJournal app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Features

 * Keep a journal of the plants you grow
 * Get information on how to grow your plants
 * Keep a photo album of your growths
 * Print QR barcodes and stick them close to your plants, so you can scan
   the barcode with your phone and add events in no time

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Design

In this section, we give a bit of information on
the internal structure of GrowJournal. Let us know what you would like to see
in this section.

### Models
Models are listed in alphabetical order.

#### Disease
Fields:
 * name: string. Name of the disease.
 * plant:  reference to Plant. A disease belongs to a Plant

Diseases are associated with plants. Different plants can get different
diseases. This information is meant to be public, editable by admin users.

#### Event
Fields:
 * name: string
 * when: datetime
 * description: string
 * user_plant: reference to UserPlant. An event belongs to a UserPlant

An event is basically anything we do a plant. This could be watering,
transplanting, adding nutrients (in hydroponics cases), feed the fishes
(in aquaponics cases)...

#### Pest
Fields:
 * name: string
 * plant: reference to Plant. A pest belongs to a plant.

Pests are associated with plants. Different plants can get different pests.
This information is meant to be public, editable by admin users.

#### Picture
Fields:
* path: string
* description: string
* user_plant: reference to UserPlant. A picture belongs to a UserPlant.
Pictures are associated to plants users grow. The pictures represent the photo
album of the plant growth.

#### Plant
Fields:
 * name: string
 * picture: string
 * description: string
 * diseases: reference back to Disease. A plant has many (common) diseases
 * pests: reference back to Pest. A plant has many (common) pests
 * varieties: reference back to Variety. A plant has many varieties

Plants are all the plants. They are not to be mixed up with UserPlant which
represent the plants the user grow. Plants have common diseases and common
pests, and a list of varieties.

#### User
Fields:
 * username: string
 * email: string
 * password: virtual field
 * password_hash: string
 * user_plants: reference back to UserPlant. A user has many user plants
   (plants they grow).

Users are GrowJournal users, they can log in, logout,
add plants to their account (i.e they're growing them).
The password is a virtual field is not actually saved to the database.

#### UserPlant
Fields:
 * user: reference to User. A UserPlant belongs to a User.
 * plant: reference to Plant. A UserPlant belongs to a Plant.
 * events:reference back to Event. A UserPlant has many events.
 * qrcode_path: string
 * pictures: reference back to pictures. A UserPlant has many pictures.

A plant the user grow. Every user plant has a qr bar code that redirects
the user to the page of the user plant, allowing the user to add events
to his plants with a QR bar code application on their phone.

#### Variety
Fields:
 * name: string
 * plant: reference to Plant. A variety belongs to a plant.

Plants have different varieties.


### Controllers

#### admin

`admin` is a folder containing controllers only accessible to admin users (not implemented).
It is represented as a scope in the router.
In the current implementation, all users are admin, there is no flag to differentiate them.
It defines all actions that are available to administrators and is available
in the `/admin/` scope.

In this folder, we have a few controllers:

 * `disease_controller.ex`: `new`/`create`//`edit`/`update`/`delete` actions.
   `index` and `show` should be removed.
 * `pest_controller.ex`: `new`/`create`/`edit`/`update`/`delete` actions.
   `index` and `show` should be removed.
 * `plant_controller.ex`: all actions on plants. In `show`, we are also listing
   the plant's diseases/pests and varieties.
 * `user_controller.ex`: all actions on users.
 * `variety_controller.ex`: `new`/`edit`/`delete` actions.
   `index` and `show` should be removed.

#### user


`user` is a folder containing controllers only accessible to them
The current implementation doesn’t make a difference between users,
i.e userA could edit userB’s user plants. It is not shown on the interface, but by manipulating
URLs, it is possible. This will need to be fixed in the future.
It defines all actions that are available to users, and is available in the `/u/`
scope.

In this folder, we have a few controllers:

 * `event_controller.ex`: `new`/`create`/`edit`/`update`/`delete` actions.
   `index` and `show` should be removed.
 * `picture_controller.ex`: all actions on pictures.
 * `user_controller.ex`: `index`/`new`/`create`/`edit`/`update`/`show` actions.
 * `user_home_controller.ex`: `index`/`update_change_password`/`change_password` actions.
 * `user_plant_controller.ex`:  all actions to create UserPlants (plants the user grows)


`auth_controller.ex`: inspired by “Programming Phoenix” by Chris McCord, Bruce Tate and José Valim.

`disease_controller.ex`: this needs to be removed.

`media_files_controller.ex`: a controller for media files. Media files are files available to users,
such as uploaded images, qr barcodes and so on.
This should ensure a user is only downloads their own files.

`page_controller.ex`: front page controller. Created by phoenix.
`plant_controller.ex`: the plant controller is for the
public information related to plants.
Note: we don't need disease/pest/variety controllers because this is part of

`session_controller.ex`: inspired by “Programming Phoenix” by Chris McCord, Bruce Tate and José Valim.



## Things to do:

 * Implement the photo album (some of it is done, but nothing is checked in at the moment)
 * Secure personal area (i.e we need to make sure the ids passed in requests belong to the user)
 * Add a way to create admin users. We will need an extra flag on the User model as well.
 * Delete some pages (listing events is useless since it’s already visible on the user plant for example)
 * Improve workflow. After adding an event, make sure it redirects to th right page.
   We need to ensure consistency across the different pages
 * Improve style (switch to bourbon in the mean time)
 * Convert website to react
 * make mobile app?
 * Ideas? Contribute to this document!
