% ---------------------------------------------------------------
% --------- Money in Utility Model(non-separable)
% --------- M. Fongoni, C. Poilly, Macroeconomics IV
% ---------------------------------------------------------------

% ------- ENDOGENEOUS VARIABLES -------- 
var 
    lambda  ${\lambda}$               (long_name='Lagrange Multiplier')
    m
    c
    R
    k
    h 
    rk
    y
    u
    pie      ${\pi}$
    i
    w
;

% ------- EXOGENEOUS VARIABLES --------  
varexo
    eps_mu   ${\epsilon_{\mu}}$     (long_name='Money growth innovation')
;

% ------- PARAMETERS --------  
parameters
    beta        ${\beta}$               (long_name='Discount factor')
    gamma       ${\gamma}$
    delta       ${\delta}$
    alpha       ${\alpha}$
    phi         ${\varphi}$
    rho         ${\rho}$
    sigma       ${\sigma}$
    gammac      ${\gamma_c}$
    gammai      ${\gamma_i}$
;


% ------- PARAMETERS' VALUES --------  
beta    = 0.99;         
gamma   = 2.00;
delta   = 0.025;
alpha   = 0.33;
phi     = 1.00;
rho     = 0.80;
sigma   = 1.00;
gammac  = 0.60;
gammai  = 0.40;


% ------- MODEL'S DECLARATION -------- 
model;
[name = 'Euler Equation on Consumption']
-c = lambda;

[name = 'Money Demand Equation']
(gamma / (1-gamma))*m = (beta /(1-beta))*R-c;

[name = 'Bonds Demand Equation']
lambda - R = lambda(1) - pie(1);

[name = 'Capital Demand Equation']
(1-beta*(1-delta))*rk(1) = R - pie(1);

[name = 'Labor Supply Equation']
phi*h = lambda + w;

[name = 'Law of Motion of Capital']
k = (1-delta)*k(-1) + delta*i;

[name = 'Capital Demand Equation']
y - k = rk;

[name = 'Labor Demand Equation']
y - h = w;

[name = 'Production Function']
y = alpha*k + (1-alpha)*h;

[name = 'Resource Constraint']
y = gammac*c + gammai*i;

[name = 'Monetary Policy Rule']
u  = m - m(-1) + pie;

[name = 'Money growth Shock']
u = rho*u(-1) + sigma*eps_mu;

end;


% ------- INITIAL VALUE DECLARATION -------- 
initval;
lambda = 0;
c      = 0;
m      = 0;
R      = 0;
pie    = 0;
w      = 0;
k      = 0;
i      = 0;
rk     = 0;
y      = 0;
u     = 0;
end;

resid;
steady; 
check;


% ------- SHOCKS DECLARATION -------- 
shocks;
    var eps_mu  = 1;
end;

% ------- SIMULATION -------- 
stoch_simul(order=1,irf=20,periods=250) y c R m u pie;
rplot y c;
