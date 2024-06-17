import Avatar from '@mui/material/Avatar';
import { Link } from "react-router-dom";
import React, { useContext  } from "react";
import Card from "@mui/material/Card";
import CardActions from "@mui/material/CardActions";
import CardContent from "@mui/material/CardContent";
import CardMedia from "@mui/material/CardMedia";
import CardHeader from "@mui/material/CardHeader";
import Button from "@mui/material/Button";
import Typography from "@mui/material/Typography";
import FavoriteIcon from "@mui/icons-material/Favorite";
import CalendarIcon from "@mui/icons-material/CalendarTodayTwoTone";
import StarRateIcon from "@mui/icons-material/StarRate";
import Grid from "@mui/material/Grid";
import img from '../../images/film-poster-placeholder.png'
import { MoviesContext } from "../../contexts/moviesContext";


export default function MovieCard({ movie, action }) {
  const { favorites, addToFavorites } = useContext(MoviesContext);
  
  if (favorites.find((id) => id === movie.id)) {
    movie.favorite = true;
  } else {
    movie.favorite = false
  }
  
  const handleAddToFavorite = (e) => {
    e.preventDefault();
    addToFavorites(movie);
  };


  return (
   
    <Card sx={{ maxWidth: 345 }} >
 
       <CardHeader
        avatar={
          movie.favorite ? (
            <Avatar sx={{ backgroundColor: 'red' }}>
              <FavoriteIcon />
            </Avatar>
          ) : null
        }

        title={
          <Typography variant="h5" component="p">
            {movie.title}{" "}
          </Typography>
        }
      />

<Link to={`/movies/${movie.id}`} style={{ textDecoration: 'none' }}>
      <CardMedia
        sx={{ height: 500 }}
        image={
          movie.poster_path
            ? `https://image.tmdb.org/t/p/w500/${movie.poster_path}`
            : img
        }
      />
       </Link>

      <CardContent>
      
          <Grid item xs={12}>
            <Typography variant="h5" gutterBottom component="div">
              <CalendarIcon fontSize="small" />    
              {"  "} {movie.release_date}
            </Typography>
          </Grid>

          <Grid item xs={6}>
            <Typography variant="h5" gutterBottom component="div">
              <StarRateIcon fontSize="small" />
              {"  "} {movie.vote_average}
            </Typography>
          </Grid>
         
      </CardContent>

      <CardActions disableSpacing>
        {action(movie)}
         <Link to={`/similar/${movie.id}`} style={{ textDecoration: 'none' }}>
          <Button variant="contained" size="large" color="primary">
           Similar Movies
          </Button>
        </Link>
      </CardActions>
     
    </Card>
    
  );
}