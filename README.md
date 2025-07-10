# Periodic-Table-Database
This is a Bash and PostgreSQL-based project completed as part of the [freeCodeCamp Relational Database Certification](https://www.freecodecamp.org/learn). 
# 🧪 Periodic Table Database Project

 The project involved fixing and normalizing a pre-existing `periodic_table` database, adding missing elements, and creating a Bash script `element.sh` that retrieves detailed information about an element using its atomic number, symbol, or name.

--

## 📂 Project Overview

The project was divided into three major parts:

1. **Fix and normalize the existing PostgreSQL database**
2. **Create a Git version-controlled repository**
3. **Build a Bash script (`element.sh`) to query and output element details**

---

## 📌 Features Implemented

### 🔧 Database Schema Enhancements

- ✅ Renamed columns for clarity:
  - `weight` → `atomic_mass`
  - `melting_point` → `melting_point_celsius`
  - `boiling_point` → `boiling_point_celsius`
- ✅ Enforced constraints:
  - `NOT NULL` added to: `name`, `symbol`, `melting_point_celsius`, `boiling_point_celsius`
  - `UNIQUE` added to: `name`, `symbol`
- ✅ Normalization:
  - Created new `types` table with:
    - `type_id` as `PRIMARY KEY`
    - `type` column (`VARCHAR`, `NOT NULL`)
  - Added 3 types: `metal`, `nonmetal`, `metalloid`
  - Linked `properties.type_id` → `types.type_id`
  - Removed the `type` column from `properties` table
  - Set `properties.atomic_number` as a `FOREIGN KEY` referencing `elements.atomic_number`
- ✅ Data cleanup:
  - Capitalized first letter of all element symbols (e.g., `he` → `He`)
  - Trimmed trailing zeroes from `atomic_mass` using `DECIMAL`
- ✅ Removed:
  - Non-existent element with `atomic_number = 1000`
- ✅ Added new elements:
  - Fluorine → `atomic_number = 9`, `symbol = F`
  - Neon → `atomic_number = 10`, `symbol = Ne`

---
## 🗃️ Database Schema

### `elements` Table
| Column           | Data Type | Constraints          |
|------------------|-----------|----------------------|
| atomic_number    | INT       | PRIMARY KEY          |
| symbol           | VARCHAR   | NOT NULL, UNIQUE     |
| name             | VARCHAR   | NOT NULL, UNIQUE     |

### `properties` Table
| Column              | Data Type | Constraints                       |
|---------------------|-----------|-----------------------------------|
| atomic_number       | INT       | PRIMARY KEY, REFERENCES elements  |
| atomic_mass         | DECIMAL   | NOT NULL                          |
| melting_point_celsius | DECIMAL | NOT NULL                          |
| boiling_point_celsius | DECIMAL | NOT NULL                          |
| type_id             | INT       | NOT NULL, REFERENCES types        |

### `types` Table
| Column    | Data Type | Constraints   |
|-----------|-----------|---------------|
| type_id   | SERIAL    | PRIMARY KEY   |
| type      | VARCHAR   | NOT NULL      |

---

## 💻 Bash Script: `element.sh`

This script uses command-line arguments to retrieve and display information about a chemical element.

### 📌 Usage

```bash
# Make sure the script has execute permission
chmod +x element.sh

# Run with atomic number
./element.sh 1

# Run with element symbol
./element.sh He

# Run with element name
./element.sh Helium
 ```


## ✅ Sample Output

The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.

## 🧪 Testing Instructions
You can test the script using a mix of:

Atomic numbers (e.g., ./element.sh 10)

Symbols (e.g., ./element.sh Ne)

Names (e.g., ./element.sh Neon)

Each should return the correct and fully formatted element data, if present in the database.

## 💾 SQL Dump Backup
To backup your database:

```
pg_dump -cC --inserts -U freecodecamp periodic_table > periodic_table.sql
```
To restore the database later:
```
psql -U postgres < periodic_table.sql
```
## 📁 File Structure

periodic_table/ 

├── element.sh             # Bash script to display element data 

├── periodic_table.sql     # SQL dump of the normalized and populated database

└── .git/                  # Git version control folder
## 🔀 Git Commit History
Initial commit

fix: renamed weight to atomic_mass and column renaming

feat: added types table and normalized schema

fix: removed trailing zeroes and capitalized symbols

feat: inserted Fluorine and Neon into database

feat: created element.sh script with error handling

## 👨‍💻 Author
Shanmukhi koshireddy

📜 Built as part of the freeCodeCamp Relational Database Certification.

## ✅ Certification Objective Fulfillment
 Normalize and fix schema

 Create foreign key constraints

 Add missing data

 Write shell script to fetch data

 Perform validation and error handling

 Track changes via Git

## 🌟 License
This project is open-source and free to use for educational purposes.



