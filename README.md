# flutter_mobile_shop —— Canada Wardrobe – Flutter Mobile Shop

**Author**: Zhijie Shen  
**Student ID**: 1263245  

## 1. Introduction

A simple Canadian-themed shopping app built using **Flutter**.  
Users can browse T-shirts, hoodies, and caps, view details, select sizes, and manage a shopping cart.

---

## 2. Project Structure

<table>
  <tr>
    <td>

<pre>
flutter_mobile_shop_ZhijieShen/
├── android/ 
├── ios/ 
├── assets/ Image assets and logo  
│   ├── logo1.png 
│   ├── TshirtCanada1.jpg  
│   ├── TshirtCanada2.jpg  
│   ├── TshirtCanada3.jpg  
│   ├── HoodieCanada1.jpg  
│   ├── HoodieCanada2.jpg  
│   ├── HoodieCanada3.jpg  
│   ├── CapCanada1.jpg  
│   ├── CapCanada2.jpg  
│   ├── CapCanada3.jpg  
├── lib/                    # Dart source files  
│   └── main.dart           # App entry point and UI logic  
├── pubspec.yaml            # Flutter configuration (assets, dependencies)  
└── README.md
</pre>

</td>
    <td>
      <img src="https://github.com/user-attachments/assets/c6ad797f-1d7e-4002-af19-9f6c763b1dea" width="300"/>
    </td>
  </tr>
</table>


## 3. Prerequisites

- 	Flutter SDK installed and on your PATH
- 	A code editor or IDE (Android Studio, IntelliJ)
- 	Chrome/Edge browser and emulator for testing

## 4. Setup and Run

1.	Fetch packages
2.	Run on edge/chrome
3.	Run on emulator

## 5. Assets Configuration
In pubspec.yaml, under the flutter: section, confirm that all image files are listed with correct names and indentation:

```dart
flutter:
  uses-material-design: true

  assets:
    - assets/logo1.png
    - assets/TshirtCanada1.jpg
    - assets/TshirtCanada2.jpg
    - assets/TshirtCanada3.jpg
    - assets/HoodieCanada1.jpg
    - assets/HoodieCanada2.jpg
    - assets/HoodieCanada3.jpg
    - assets/CapCanada1.jpg
    - assets/CapCanada2.jpg
    - assets/CapCanada3.jpg

```

## 6. App Overview & Screenshots
1.	Products Page
- Top: Logo + “Canada Day Sale On Now”
-	Category chips: All | Shirts | Hoodies | Caps
-	Grid of items, each with image, category, name, price, “Add” button

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/19fe4999-c543-45c9-b0bd-bfc43e05776e" width="400"/></td>
    <td><img src="https://github.com/user-attachments/assets/9e533d59-18b1-4382-85ae-c115122ea762" width="400"/></td>
  </tr>
</table>

<table>
  <tr>
	<td><img src="https://github.com/user-attachments/assets/d4c1b85a-bd7b-49a3-bb04-0eee40551345e" width="400"/></td>
	<td><img src="https://github.com/user-attachments/assets/8e7dcbd3-1d68-4f6b-b335-d7c45c5a31ce" width="400"/></td>
  </tr>
</table>

2.	Detail Page
-	Large product image
-	Name & price
-	Size selector (XS | S | M | L | XL)
-	“Add to Cart” button

<table>
  <tr>
	<td><img src="https://github.com/user-attachments/assets/b0c15ab0-af17-4a7b-aad1-5ef52d4a0f5e" width="400"/></td>
	<td><img src="https://github.com/user-attachments/assets/4ca247dd-0a66-42ad-a422-65874e174f12" width="400"/></td>
  </tr>
</table>


3.	Cart Page
-	Subtotal at top
-	List of items showing image, name, selected size, price
-	Delete icon to remove each item

<table>
  <tr>
	<td><img src="https://github.com/user-attachments/assets/e5dd6c6a-23f9-4124-be26-aa1adabe387c" width="400"/></td>
	<td><img src="https://github.com/user-attachments/assets/b6883cde-0e90-4373-a876-1b20a9087b4a" width="400"/></td>
  </tr>
</table>

## 7. Screen Shots On Edge

<table>
  <tr>
	<td><img src="https://github.com/user-attachments/assets/53e5acdc-74ed-469c-9d88-62908235b25b" width="600"/></td>
	<td><img src="https://github.com/user-attachments/assets/fb7ee0e9-a58a-41a5-98c2-095eab20a9ee" width="600"/></td>
  </tr>
</table>

![image](https://github.com/user-attachments/assets/f416114e-48c3-4e1c-87bd-89700462f56f)


## 8. Notes

- Tapping “Add” on the products page adds the item in size M by default.
- Tapping a product opens its detail page, where you choose a size before adding.


