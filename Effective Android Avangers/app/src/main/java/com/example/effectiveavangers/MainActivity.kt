package com.example.effectiveavangers

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Card
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.TileMode
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.effectiveavangers.ui.theme.*
import dev.chrisbanes.snapper.ExperimentalSnapperApi
import dev.chrisbanes.snapper.rememberSnapperFlingBehavior

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            EffectiveAvangersTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = mainBackgroundColor
                ) {
                    MainScreen()
                }
            }
        }
    }
}

@Composable
fun MainScreen() {
    Column(
        verticalArrangement = Arrangement.SpaceBetween,
        modifier = Modifier.background(mainBackgroundColor).padding(vertical = 40.dp),
        horizontalAlignment = Alignment.CenterHorizontally,


    ) {
        Logo()
        Text("Choose your hero",color = textColor, fontSize = 30.sp, fontWeight = FontWeight.W700 )
        CharactersList()
    }
}

@Composable
fun Logo() {
    Image(painter = painterResource(id = R.drawable.marvel), contentDescription = null, modifier = Modifier
        .padding(bottom = 25.dp)
        .height(40.dp)
        .width(200.dp))
}


@OptIn(ExperimentalSnapperApi::class)
@Composable
fun CharactersList() {
    val lazyListState = rememberLazyListState()
    val flippingBehavior = rememberSnapperFlingBehavior(lazyListState = lazyListState)
    LazyRow(
        state = lazyListState,
        flingBehavior = flippingBehavior,
        ) {

        item {
            CharacterCard(imageId = R.drawable.captain_america, name = "Captain America", backgroundColor = captainAmericaBackgroundColor)
        }
        item {
            CharacterCard(imageId = R.drawable.iron_man, name = "Iron man", backgroundColor = ironManBackgroundColor)
        }
        item {
            CharacterCard(imageId = R.drawable.spider_man, name = "Spider-man", backgroundColor = spiderManBackgroundColor)
        }
        item {
            CharacterCard(imageId = R.drawable.deadpool, name = "Deadpool", backgroundColor = deadpoolBackgroundColor)
        }
        item {
            CharacterCard(imageId = R.drawable.thanos, name = "Thanos", backgroundColor = thanosBackgroundColor)
        }
        item {
            CharacterCard(imageId = R.drawable.thor, name = "Thor", backgroundColor = thorBackgroundColor)
        }
        item {
            CharacterCard(imageId = R.drawable.doctor_strange, name = "Doctor strange", backgroundColor = doctorStrangeBackgroundColor)
        }


    }
}

@Composable
fun CharacterCard(imageId: Int, name: String, backgroundColor: Color, ){
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(25.dp),
        shape = RoundedCornerShape(25.dp),
        elevation = 5.dp
    ){
        Box(){
            Image(painter = painterResource(id = imageId), contentDescription = null, modifier = Modifier.size(350.dp, 600.dp), contentScale = ContentScale.FillBounds)
            Text(name, color = textColor, fontSize = 30.sp, fontWeight = FontWeight.W700, modifier = Modifier
                .align(Alignment.BottomStart)
                .padding(bottom = 30.dp, start = 40.dp))

        }
    }
}


