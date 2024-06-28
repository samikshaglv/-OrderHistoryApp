# Order History Application

This Rails application showcases a list of users and facilitates the download action to retrieve user order histories in CSV format. The primary purpose of this application is to manage the order history of users.

## Setup Instructions

### Prerequisites

Ensure you have the following installed on your system:
- Ruby (version 3.x or higher)
- Rails (version 6.x or higher)
- PostgreSQL (or another supported database)
- Redis (for Sidekiq)
- Bundler

### Initial Setup

1. **Clone the Repository**

   **bash**
   git clone https://github.com/yourusername/order_history_app.git
   cd order_history_app
2. Install Dependencies

Install the required gems by running:
**bundle install**

3. Set Up the Database

Create and migrate the database:

**rails db:create
rails db:migrate**

 Import Sample Data

Import user and order data from the provided CSV files. Ensure the CSV files are located in the csv_data directory.

rails import:users_and_orders

2. **Running the Application**

Start the Rails Server

Start the Rails server to run the application:

**rails server**

The application will be accessible at http://localhost:3000.

**Start Sidekiq**
Sidekiq is used for background job processing. Start Sidekiq in a separate terminal window:

**bundle exec sidekiq**

3. **Accessing the Application**

View Users

Navigate to http://localhost:3000 to view the list of users.

**Generate and Download CSV**

To generate a CSV file for a user's order history, click the "Generate CSV" button next to the user's details.
Once the CSV is generated, a "Download CSV" link will appear. Click this link to download the CSV file.

4. Project Structure
**Models**: Defines the User and Order models with validations and associations.
**Controllers**: Handles the logic for displaying users and generating/downloading CSV files.
**Jobs**: Contains the OrderCsvJob for generating CSV files in the background.
**Views**: Contains the HTML and ERB files for rendering the user interface.

5. **Additional Notes**

Ensure Redis is running for Sidekiq to process jobs.
Modify the config/database.yml file if using a database other than PostgreSQL.
Check the log directory for any errors and logs.

6. **Assumptions**
The input CSV files are formatted correctly as per the sample provided.
The application is set up in a development environment.

7. Contact
For any questions or support, please contact samikshaglv@gmail.com.

### Explanation:
1. **Setup Instructions**: Step-by-step guide on cloning the repository, installing dependencies, setting up the database, and importing sample data.
2. **Running the Application**: Instructions to start the Rails server and Sidekiq for background processing.
3. **Accessing the Application**: How to view users and download their order histories.
4. **Project Structure**: Overview of the project's organization.
5. **Additional Notes**: Important information regarding Redis and database configuration.
6. **Assumptions**: Clarifies assumptions about the input data and environment setup.
7. **Contact**: Contact information for further support.


