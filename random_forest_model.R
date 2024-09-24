# Load libraries
library(randomForest)
library(caret)

# Set a seed for reproducibility
set.seed(123)

# Train a Random Forest model
rf_model <- randomForest(SALE_PRC ~ ., data = train_data, ntree = 500, mtry = 5, importance = TRUE)

# Print the model summary
print(rf_model)

# Predict on the test data
rf_predictions <- predict(rf_model, test_data)

# Evaluate the model using RMSE
rf_rmse <- RMSE(rf_predictions, test_data$SALE_PRC)
print(rf_rmse)

# Predict on the validation data
validation_predictions <- predict(rf_model, validation_data)

# Calculate RMSE on the validation data
validation_rf_rmse <- RMSE(validation_predictions, validation_data$SALE_PRC)
print(validation_rf_rmse)

# Plot Actual vs Predicted for Validation Data
ggplot(validation_data, aes(x = SALE_PRC, y = validation_predictions)) +
  geom_point(color = "blue") +
  geom_abline(slope = 1, intercept = 0, color = "red") +
  labs(title = "Actual vs Predicted Sale Prices (Validation Data)", 
       x = "Actual Sale Prices", y = "Predicted Sale Prices")

# Plot Residuals vs Predicted Sale Prices for Validation Data
residuals <- validation_data$SALE_PRC - validation_predictions
ggplot(validation_data, aes(x = validation_predictions, y = residuals)) +
  geom_point(color = "blue") +
  geom_hline(yintercept = 0, color = "red") +
  labs(title = "Residuals vs Predicted Sale Prices (Validation Data)", 
       x = "Predicted Sale Prices", y = "Residuals")

