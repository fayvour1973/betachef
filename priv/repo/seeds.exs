# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Betachef.Repo.insert!(%Betachef.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Betachef.Accounts
alias Betachef.Accounts.{User, Payment}
alias Betachef.Catering
alias Betachef.Catering.{Caterer, CateringService, Booking}
alias Betachef.Repo

User |> Repo.delete_all()

{:ok, user} =
  Accounts.create_user(%{
    date_of_birth: "2022_02_12",
    email: "fayvour@email.com",
    first_name: "favour",
    full_name: "maduka favour",
    home_town: "ugwuaji",
    last_name: "maduka",
    nationality: "nigeria",
    phone_number: "08177600",
    residential_address: "back of chem",
    state_of_origin: "enugu",
    password: "1234",
    password_confirmation: "1234"
  })

Accounts.create_user(%{
  date_of_birth: "2021-22-12",
  email: "beauty@email.com",
  first_name: "beauty",
  full_name: "amesi beauty",
  home_town: "emuoha",
  last_name: "amesi",
  nationality: "nigeria",
  phone_number: "08177",
  residential_address: "back of chem",
  state_of_origin: "rivers",
  password: "196",
  password_confirmation: "196"
})

Accounts.create_user(%{
  date_of_birth: "2022_04-21",
  email: "enitor@email.com",
  first_name: "enitor",
  full_name: "epsibari enitor",
  home_town: "bori",
  last_name: "epsibari",
  nationality: "nigeria",
  phone_number: "081600",
  residential_address: "back of chem",
  state_of_origin: "rivers",
  password: "456",
  password_confirmation: "456"
})

#Payment |> Repo.delete_all()

#Accounts.create_payment(%{
 # mode: "full payment",
  #user_id: user.id
#})

Caterer |> Repo.delete_all()

{:ok, caterer} =
  Catering.create_caterer(%{
    country: "nigeria,",
    email: "winny@email.com",
    first_name: "winny",
    full_name: "john winny",
    last_name: "john",
    phone_number: "08177"
  })

Catering.create_caterer(%{
  country: "nigeria,",
  email: "joy@email.com",
  first_name: "joy",
  full_name: "madu joy",
  last_name: "madu",
  phone_number: "07062"
})

Catering.create_caterer(%{
  country: "nigeria,",
  email: "fay@email.com",
  first_name: "fay",
  full_name: "emmanuel fay",
  last_name: "emmanuel",
  phone_number: "0815432"
})

CateringService |> Repo.delete_all()

{:ok, catering_service} =
  Catering.create_catering_service(%{
    available_days: "monday to saturday",
    business_email: "winnycaj@email.com",
    business_name: "winnycaj",
    business_phone_number: "081600",
    description: "hmmm... that's the feeling",
    image: "home made egwusi soup",
    price_per_number_of_guest: "#1million per 500 guest",
    price_per_day: 100_000,
    specialization: "All kinds of traditional food",
    working_hours: "8am - 9pm",
    caterer_id: caterer.id
  })

Catering.create_catering_service(%{
  available_days: "Monday to Sunday",
  working_hours: "6am-9pm",
  business_phone_number: "07062",
  business_name: "joyous super service",
  business_email: "joy@gmail.com",
  price_per_number_of_guest: "700k per 100 guest",
  price_per_day: 100_000,
  image: "9ja jellof",
  description: "Your satisfaction, our priority",
  specialization: "All kinds of cooked rice",
  caterer_id: caterer.id
})

Catering.create_catering_service(%{
  available_days: "Monday to Sunday",
  working_hours: "24 hours",
  business_phone_number: "09000000",
  business_name: "favvys kitchen",
  business_email: "fayK@gmail.com",
  price_per_number_of_guest: "400k per 50 guest",
  price_per_day: 100_000,
  image: "9ja jellof",
  description: "wow! this is real food",
  specialization: "All kinds of cooked rice",
  caterer_id: caterer.id
})

Catering.create_catering_service(%{
  available_days: "Monday to Friday",
  working_hours: "12 hours",
  business_phone_number: "09000000",
  business_name: "Enys kitchen",
  business_email: "Eny@gmail.com",
  price_per_number_of_guest: "400k per 50 guest",
  price_per_day: 100_000,
  image: "9ja jellof",
  description: "wow! this is real food",
  specialization: "All kinds of cooked food",
  caterer_id: caterer.id
})

Booking |> Repo.delete_all()

Catering.create_booking(%{
  booking_state: "active",
  start_date: ~D[2022-12-08],
  end_date: ~D[2022-12-10],
  user_id: user.id,
  catering_service_id: catering_service.id
})

Catering.create_booking(%{
  booking_state: "active",
  start_date: ~D[2022-05-08],
  end_date: ~D[2022-05-10],
  user_id: user.id,
  catering_service_id: catering_service.id
})

Catering.create_booking(%{
  booking_state: "inactive",
  start_date: ~D[2022-02-03],
  end_date: ~D[2022-02-10],
  user_id: user.id,
  catering_service_id: catering_service.id
})
