read_in <- function(){
  require(readr)
  read_csv('data/alachua_shots.csv')
}

clean_up <- function(dataframe){
  names(dataframe) <- tolower(names(dataframe))
  dataframe$dob <- as.Date(dataframe$dob,
                           format = '%m/%d/%Y')
  dataframe$date_vaccine <- as.Date(dataframe$date_vaccine,
                                    format = '%m/%d/%Y')
  return(dataframe)
}

read_in_old <- function(){
  read_csv('data/alachua_old.csv', skip = 3)
}

clean_up_old <- function(dataframe){
  require(dplyr)
  dataframe$date <- as.Date(dataframe$date,
                         format = '%m/%d/%Y')
  names(dataframe)[4] <- 'date_vaccine'
  dataframe$dob <- as.Date(dataframe$dob,
                           format = '%m/%d/%Y')
  dataframe$name <- unlist(lapply(strsplit(dataframe$name, ', '), function(x){paste(x[2], x[1])}))
  dataframe$middle <- NULL
  dataframe <- dataframe %>%
    rename(age_at_vaccination = age,
           type_vaccine = type,
           administrator = admin)
  dataframe$administrator <- ifelse(dataframe$administrator == 'PR',
                                    'Private Doctor',
                                    ifelse(dataframe$administrator == 'PU',
                                           'CHD',
                                           NA))
  return(dataframe)
}