# examdata

## Synthetic Multiple-Choice Exam Data Generation

**Purpose**: The **examdata** package generates **fully synthetic multiple-choice exam data** using beta-distributed latent abilities.  

It allows you to simulate realistic student-level item responses for arbitrary exam structures by providing flexible parameter settings to adjust the ability distribution
This makes it useful for:
- Testing scoring algorithms  
- Training data analysis workflows  
- Educational data modeling and teaching examples  

Users can specify:
- number of students (`n_stud`)
- number of exams (`n_exam`) 
- number of items per exam (`n_item`)  
- parameters of the latent ability distribution (`shape1`,`shape2`) 
- whether the item responses are to be scored or raw (`responses`)

---

## Installation

You can install the development version of `examdata` from GitHub:

1. Open R or RStudio

2. Copy this to your console:

```r
# install.packages("devtools")
devtools::install_github("ylvazm/examdata")

```
3. Execute

---

## Examples / Tutorials

If you want to create dataset representing the responses of 30 student on one exam
with 15 questions, using the default shape parameters for the response distribution:

```library(examdata)

set.seed(123)
df <- GenerateData(n_stud = 30, n_exam = 1, n_item = 15)
df 
```

If you want the responses to be scored as correct or incorrect, add `responses = FALSE`
to the arguments of the function: 

```
set.seed(123)
df <- GenerateData(n_stud = 30, n_exam = 1, n_item = 15, responses = FALSE)
df 
```
If you want to customize the underlying response distribution, customize the arguments
`shape1` and `shape2`:

```
set.seed(123)
df <- GenerateData(n_stud = 30, n_exam = 1, n_item = 15, shape1 = 5, shape2 = 20, responses = FALSE)
df 
```

For more info on the underlying response distributions, [check here](...)

For more info on the the psychometric properties of the generated data, [check here](...)

---

## Authors

Ylva Matejko (2025)

---

## Recommended Citation

If you use `examdata` in your work, please cite it as: 

TBA

---

## Contact Info

Suggestions, issues, and pull requests are welcome on [this project's GitHub Repository](https://github.com/ylvazm/examdata)
Inquiries can be mailed to [Ylva Matejko](ylva.matejko@gmx.de)

---

## License

This repository is licensed under the [MIT License](LICENSE.md).

---







