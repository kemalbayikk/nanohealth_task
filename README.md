Flutter project for Nano Health Suite.

## Some Notes

* I did not use the getting single product functionality of the API, because after logging in I fetched all the products (If the number of products were more, I would prefer to bring in parts instead of bringing all the products.) to show in the all products page and when navigating to the detail page I selected this specific product from the list.

* I used Riverpod for the state management but I aslo have experience with other state management packages like Bloc, Provider, Mobx and Getx.

* I had to make some changes at the design because most of the product images provided from the API have white background. Images at the Figma design have dark colored background and white backgrounded buttons looked good on these images. But white buttons on white background or dark colored texts on dark colored backgrounds didn't look good so I made little changes.

* I used Getx for just the snackbars. I think showing snackbars without context is very useful.

* I used http package for API connection, flutter_rating_bar package for rating bar, google_fonts package for OpenSans font and expandable_bottom_sheet package for bottom sheet.
