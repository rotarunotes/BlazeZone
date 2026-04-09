
![[Pasted image 20260408102447.png]]

Il Progetto Del server sarà impostato in questo modo:

``` Tree
Server
├── Controller\Api
│   ├── AuthController.php
│   ├── BaseController.php
│   ├── DailyWorkoutController.php
│   ├── SetController.php
│   └── WorkoutPlanController.php
├── inc
│   ├── bootstrap.php
│   └── config.php
├── Model
│   ├── DailyWorkoutModel.php
│   ├── Database.php
│   ├── SetModel.php
│   ├── Usermodel.php
│   └── WorkoutPlanModel.php
├── Authmiddleware.php
├── index.php
├── JWT.php
└── setup.sql
```

1) dove si inserisce il token dal client