
library(ggplot2)
library(ggpubr)
windowsFonts(A=windowsFont("Microsoft YaHei"))
model_diag <- function(model){
  a <- ggplot(data.frame(y = model$residuals), aes(sample = y))+
    theme_bw()+
    theme(text=element_text(family = "A"),
          plot.title=element_text(face='bold',hjust=0.5))+
    labs(title="Normal Q-Q plot",x="Theoretical quantiles",
         y="Sample quantiles")+
    geom_qq()+
    stat_qq_line(size=1)
  # fitted v.s. residuals
  b <- ggplot(data.frame(x=model$Y_hat,y=model$residuals),
              aes(x=x,y=y))+
    theme_bw()+
    theme(text=element_text(family = "A"),
          plot.title=element_text(face='bold',hjust=0.5))+
    labs(title="Response vs. Linear predictors",x="Linear predictor",y="Residuals")+
    geom_point()+
    geom_smooth(method='lm')
  # histogram of residuals
  c <- ggplot(data.frame(x=model$residuals), aes(x=x))+
    theme_bw()+
    theme(text=element_text(family = "A"),
          plot.title=element_text(face='bold',hjust=0.5))+
    labs(title="Histogram of residuals",x="Residuals",y="Frequency")+
    geom_histogram(aes(y = ..density..))+
    stat_function(fun=dnorm, args=list(mean=mean(model$residuals),
                                       sd=sd(model$residuals)),
                  color='blue')
  # fitted vs. original
  d <- ggplot(data.frame(x=model$Y_hat,y=model$Y),
              aes(x=x,y=y))+
    theme_bw()+
    theme(text=element_text(family = "A"),
          plot.title=element_text(face='bold',hjust=0.5))+
    labs(title="Response vs. Fitted values",x="Fitted values",y="Response")+
    geom_point()+
    geom_smooth(method='lm', formula=y~x, se=TRUE)+
    geom_abline(slope=1,intercept=0,lwd=1,color='#a50026')
  ggarrange(a,b,c,d,
            labels=c("A","B","C","D"),
            ncol = 2,
            nrow = 2,
            align="hv")
}

model_diag(a)











