# Hyperlocal Apartment Marketplace

A secure marketplace for apartment residents to buy, sell, and trade goods/services within their building community.

## Table of Contents
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Database Schema](#database-schema)
- [Development Roadmap](#development-roadmap)
- [Security](#security)
- [Setup](#setup)
- [Deployment](#deployment)
- [FAQ](#faq)
- [License](#license)

## Features 🚀
### Core Functionality
- **Resident Verification**
  - Address normalization service for fuzzy matching
  - Unit number validation against admin-curated lists
  - Mandatory SMS verification via Twilio
- **Listings Marketplace**
  - Create listings with photos (S3 storage)
  - Category filtering (sell/buy/rent/service)
  - Apartment-scoped browsing
- **Secure Transactions**
  - Stripe Connect with Express accounts
  - 72-hour auto-release escrow system
  - Dispute mediation dashboard
- **Private Communication**
  - Twilio-powered SMS proxy
  - Anonymous number masking

## Tech Stack 🔧
| Component           | Technology                  |
|---------------------|----------------------------|
| Framework           | Rails 7 (Hotwire)          |
| Frontend            | Bootstrap                  |
| Database            | PostgreSQL + PostGIS       |
| Testing             | RSpec + Capybara           |
| Payments            | Stripe Connect             |
| Messaging           | Twilio API                 |
| Storage             | AWS S3 via Active Storage  |
| Auth                | Devise                     |
| Hosting             | Render.com/Heroku(tbd)     |

## Database Schema 🗄️

# Apartments
- normalized_address (tsvector for search)
- valid_units (array)
- status (active/pending/inactive)
- has_many :users

# Users
- phone (encrypted)
- unit_number
- stripe_account_id
- apartment_id (FK)
- verified_at (timestamp)
- belongs_to: apartment

# Listings
- price (integer, cents)
- category (enum)
- photos (Active Storage)
- status (enum)

# Transactions
- escrow_release_at (datetime)
- stripe_payment_id
- status (enum)


## Development Roadmap 📅

### Phase 1: Core Infrastructure (Week 1-2)
- Address normalization service
- SMS verification flow
- Admin apartment/unit CRUD
- RSpec test scaffolding

### Phase 2: Marketplace (Week 3-4)
- Active Storage + S3 integration
- Listing creation workflow
- Apartment-scoped searching

### Phase 3: Payments (Week 5)
- Stripe Connect onboarding
- Escrow transaction flow
- Webhook handlers

### Phase 4: Security (Week 6)
- Audit logging system
- Rate limiting
- Deployment pipeline

---

# Security 🔒 (work in progress)
- Address normalization for fuzzy matching
- Encrypted phone number storage
- Stripe webhook signature verification
- Daily database backups
- Bi-weekly vulnerability scans

---

# Deployment 🚢 (work in progress)
1. Create a [Render.com](https://render.com/) account. (will most likley change to heroku)
2. Connect GitHub repository.
3. Add the following environment variables:
   - `RAILS_MASTER_KEY`
   - `STRIPE_API_KEY`
   - `TWILIO_*` credentials

---

# Setup 🛠️
1. Clone the repository.
2. Install dependencies: `bundle install`.
3. Set up the database: `rails db:setup`.
4. Run the application: `rails server`.

---

# FAQ ❓


---

# License 📜
    - tbd


# Development Tracker

## Completed Tasks

- **Rails Application Setup**: Initialized the Rails application structure.
- **Devise Setup**: Integrated Devise for user authentication.

## In Progress

- **Apartment Model Setup**: Creating and configuring the `Apartment` model.

---

This document will be updated as development progresses.

# Application Flow

# User Sign-In Flow Documentation

## Overview

This document outlines the user sign-in and sign-up process for the application, which leverages Devise for authentication and includes additional functionality such as phone number verification and address normalization to enable apartment buildings to be searched by address.

## User Table Schema

The `users` table includes the following columns:

- `full_name`: string, not null
- `email`: string, not null, unique
- `password`: encrypted string, not null
- `phone`: encrypted string, not null
- `address`: encrypted string, not null
- `unit_number`: string, nullable
- `stripe_account_id`: string, nullable
- `apartment_id`: integer, foreign key, nullable
- `verified_at`: timestamp, nullable

## Sign-Up Flow

### Step 1: Initial Sign-Up Form

1. The user navigates to the sign-up page.
2. They fill out their email and password.
3. Devise checks if the email already exists in the database:
   - **Existing User**: The user is prompted to log in.
   - **New User**: They are routed to a second form to complete their profile.

### Step 2: Profile Completion Form

The user is prompted to provide the following additional information:

- First name 
- Last name 
- Phone number
- Address
- Unit number (optional)

#### Phone Number Verification

1. The phone number is verified using Twilio SMS.
2. A verification code is sent to the user’s phone.
3. The user enters the code to confirm their phone number.

#### Address Normalization

1. The address submitted by the user is normalized using the Google Geocoding API.
2. The normalized address is checked against the database for existing apartments:
   - **Apartment Found**: The user is prompted to join the existing apartment.
   - **No Apartment Found**:
     - An admin is notified to create a new apartment.
     - The user is notified via email that their submitted address is under review.

### Step 3: Completion

Once the profile is completed:

1. The user is routed to the home page.
2. They receive an email explaining the status of their apartment association.

## Sign-In Flow

1. The user navigates to the sign-in page.
2. They enter their email and password.
3. If the credentials are valid, the user is routed to the user dashboard.

## Notifications

### Admin Notifications

- Triggered when a new address is submitted with no associated apartment.
- Includes user details and the submitted address.

### User Notifications

- **Email Confirmation**: Upon successful profile completion.
- **Apartment Status Update**: When an admin creates an apartment for their submitted address.

## Summary of External Integrations

- **Devise**: For authentication and session management.
- **Twilio SMS**: For phone number verification.
- **Google Geocoding API**: For address normalization.

## Future Enhancements

- Streamline admin notifications for quicker apartment creation.
- Implement real-time updates for users on their apartment status.
- Enhance address verification with additional validation layers.

---

This document serves as a guide to understanding the sign-in and sign-up workflows and their dependencies in the application.

