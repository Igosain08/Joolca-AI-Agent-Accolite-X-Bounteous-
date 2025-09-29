# Airfoil Self-Noise Prediction: Advanced Machine Learning Analysis

[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange.svg)](https://jupyter.org/)
[![scikit-learn](https://img.shields.io/badge/scikit--learn-Latest-green.svg)](https://scikit-learn.org/)
[![XGBoost](https://img.shields.io/badge/XGBoost-Latest-red.svg)](https://xgboost.readthedocs.io/)

A comprehensive machine learning project analyzing airfoil self-noise data to predict Sound Pressure Level (SSPL) using various regression techniques and advanced optimization methods.

## 🎯 Project Overview

Airfoil self-noise is a critical factor in aerodynamic design, particularly for applications in wind turbines, aircraft, and other aerodynamic systems. Understanding and predicting noise levels can help engineers optimize designs for quieter operation and improved performance.

This project analyzes the **NASA Airfoil Self-Noise dataset** (1503 rows × 6 columns) to develop robust machine learning models that predict the Sound Pressure Level (SSPL) based on various aerodynamic parameters.

### 🔬 Research Question
*"Can we accurately predict airfoil self-noise levels using machine learning techniques, and which aerodynamic features are most influential in noise generation?"*

## 📊 Dataset Description

The dataset contains measurements from various airfoil configurations with the following variables:

| Variable Name | Description | Units |
|---------------|-------------|-------|
| `f` | Frequency | Hz |
| `alpha` | Angle of attack | degrees |
| `c` | Chord length | meters |
| `U_infinity` | Free-stream velocity | m/s |
| `delta` | Suction side displacement thickness | meters |
| `SSPL` | Scaled sound pressure level (target) | decibels |

**Dataset Statistics:**
- Original size: 1,503 observations
- After cleaning: 1,427 observations (76 outliers removed)
- Features: 5 input variables
- Target: 1 continuous variable (SSPL)

## 🛠️ Technical Implementation

### Data Preprocessing Pipeline

1. **Outlier Detection & Removal**
   - Applied Z-score analysis (threshold: 3 standard deviations)
   - Removed 76 outliers from original dataset
   - Final cleaned dataset: 1,427 observations

2. **Missing Value Handling**
   - Used SimpleImputer with mean strategy
   - Applied mean imputation for numerical features

3. **Feature Scaling**
   - Applied StandardScaler for normalization
   - Ensured zero mean and unit variance

4. **Data Quality Assurance**
   - Removed duplicate entries
   - Validated data integrity across all variables

### Machine Learning Models

#### Baseline Models Performance

| Model | MSE | R² Score | Performance Category |
|-------|-----|----------|---------------------|
| **XGBoost (Optimized)** | **2.26** | **0.949** | **🏆 Best Performance** |
| Random Forest (Tuned) | 3.20 | 0.928 | 🥈 Excellent |
| Random Forest (Original) | 3.21 | 0.927 | 🥉 Excellent |
| Decision Tree | 6.31 | 0.857 | ✅ Good |
| Gradient Boosting | 7.74 | 0.824 | ✅ Good |
| Linear Regression | 22.64 | 0.487 | 📊 Baseline |

#### Advanced Optimization Techniques

- **GridSearchCV**: Systematic hyperparameter tuning
- **Bayesian Optimization**: Efficient parameter space exploration
- **5-Fold Cross-Validation**: Robust model evaluation
- **SHAP Analysis**: Model interpretability and feature importance

### Feature Importance Analysis

#### Random Forest Feature Importance:
1. **Frequency (f)**: 39.52% - Most critical factor
2. **Displacement thickness (delta)**: 38.56% - Nearly equal importance
3. **Chord length (c)**: 11.60% - Moderate influence
4. **Angle of attack (alpha)**: 5.25% - Lower impact
5. **Free-stream velocity (U_infinity)**: 5.08% - Least influential

#### XGBoost Feature Importance:
1. **Chord length (c)**: 33.08% - Highest importance
2. **Displacement thickness (delta)**: 31.31% - Close second
3. **Frequency (f)**: 19.49% - Significant contribution
4. **Angle of attack (alpha)**: 8.16% - Moderate impact
5. **Free-stream velocity (U_infinity)**: 7.96% - Lower influence

## 📁 Project Structure

```
acm/
├── ACM_AI_Team_1 (1).ipynb    # Main analysis notebook
├── AirfoilSelfNoise (1).csv   # Original dataset
├── AirfoilSelfNoise_Cleaned.csv # Cleaned dataset
├── model.pkl                  # Trained model (serialized)
├── p.py                      # Additional Python utilities
└── README.md                 # Project documentation
```

## 🚀 Getting Started

### Prerequisites

```bash
pip install numpy pandas matplotlib seaborn scikit-learn xgboost scipy joblib
```

### Installation & Usage

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd acm
   ```

2. **Install dependencies:**
   ```bash
   pip install -r requirements.txt  # Create this file with above packages
   ```

3. **Run the analysis:**
   ```bash
   jupyter notebook "ACM_AI_Team_1 (1).ipynb"
   ```

4. **Load the trained model:**
   ```python
   import joblib
   model = joblib.load('model.pkl')
   
   # Make predictions
   predictions = model.predict(X_test)
   ```

### Quick Start Example

```python
import pandas as pd
import joblib
from sklearn.preprocessing import StandardScaler

# Load the cleaned dataset
data = pd.read_csv('AirfoilSelfNoise_Cleaned.csv')

# Prepare features
X = data.iloc[:, :-1].values
y = data.iloc[:, -1].values

# Load the trained model
model = joblib.load('model.pkl')

# Make predictions
predictions = model.predict(X)
```

## 📈 Key Results & Achievements

### 🎯 Model Performance
- **Best R² Score**: 0.949 (XGBoost)
- **Lowest MSE**: 2.26 (XGBoost)
- **Cross-validation stability**: ±0.0284 standard deviation

### 🔍 Key Insights
1. **Frequency and displacement thickness** are the most predictive features
2. **XGBoost outperformed** all other algorithms consistently
3. **Feature engineering** provided marginal but consistent improvements
4. **Model interpretability** achieved through SHAP analysis

### 🏆 Technical Achievements
- High predictive accuracy (R² > 0.94)
- Robust cross-validation results
- Comprehensive feature importance analysis
- Advanced hyperparameter optimization
- Model interpretability with SHAP

## 🌟 Applications & Impact

### Practical Applications
1. **🛩️ Aerodynamic Design**: Optimize airfoil shapes for reduced noise
2. **🌪️ Wind Turbine Engineering**: Design quieter blade profiles
3. **✈️ Aircraft Development**: Minimize noise pollution in aviation
4. **🔬 Research Tool**: Understand noise generation mechanisms
5. **🏭 Quality Control**: Predict noise levels in manufacturing

### Business Value
- **Cost Reduction**: Optimize designs before physical testing
- **Regulatory Compliance**: Meet noise pollution standards
- **Performance Enhancement**: Balance efficiency with noise reduction
- **Innovation**: Enable data-driven aerodynamic design decisions

## 🔮 Future Enhancements

### Technical Roadmap
- [ ] **Deep Learning**: Explore neural network architectures
- [ ] **Ensemble Methods**: Advanced model combination techniques
- [ ] **Real-time Prediction**: Deploy models for live monitoring
- [ ] **AutoML Integration**: Automated model selection and tuning
- [ ] **Domain Knowledge**: Incorporate aerodynamic theory

### Deployment Recommendations
- **Production**: Use optimized XGBoost for best accuracy
- **Interpretability**: Use Random Forest when explainability is crucial
- **Real-time**: Consider model complexity vs. inference speed
- **Monitoring**: Track feature importance for model drift detection

## 📚 References & Resources

- **Dataset Source**: NASA Airfoil Self-Noise Dataset
- **Research Paper**: [Airfoil Self-Noise Prediction](https://archive.ics.uci.edu/ml/datasets/Airfoil+Self-Noise)
- **Technical Documentation**: See Jupyter notebook for detailed analysis

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **ACM AI Team** - *Initial work and analysis*

## 🙏 Acknowledgments

- NASA for providing the airfoil self-noise dataset
- The open-source community for the excellent ML libraries
- Contributors to scikit-learn, XGBoost, and other dependencies

---

*This analysis demonstrates the power of comprehensive machine learning approaches in solving complex engineering problems, achieving high predictive accuracy while maintaining model interpretability and practical applicability.*

## 📊 Performance Visualization

```
Model Performance Comparison:
XGBoost        ████████████████████████████████████████ 94.9%
Random Forest  ████████████████████████████████████     92.8%
Decision Tree  ████████████████████████████             85.7%
Gradient Boost ████████████████████████████             82.4%
Linear Reg     ████████████                             48.7%
```

**🎯 Project Status**: ✅ Complete | **📈 Accuracy**: 94.9% | **🔧 Model**: XGBoost | **📊 Dataset**: 1,427 samples
