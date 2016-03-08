# GrowJournal

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Design

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
album of the plant growth. (Functionality not present yet).

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
