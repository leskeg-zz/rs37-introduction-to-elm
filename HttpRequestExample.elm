module HttpRequestExample exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { topic : String
    , gifUrl : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" "", Cmd.none )



-- UPDATE


type Msg
    = MorePlease
    | UpdateTopic String
    | NewGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateTopic newTopic ->
            ( { model | topic = newTopic }, Cmd.none )

        MorePlease ->
            ( Model model.topic "spinner.gif"
            , getRandomGif model.topic
            )

        NewGif (Ok newUrl) ->
            ( Model model.topic newUrl, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ topicInput model
        , loadMoreButton
        , topicImage model
        ]


topicInput : Model -> Html Msg
topicInput model =
    input
        [ onInput UpdateTopic
        , placeholder "Topic"
        , value model.topic
        ]
        []


loadMoreButton : Html Msg
loadMoreButton =
    button [ onClick MorePlease ]
        [ text "Load gif!" ]


topicImage : Model -> Html Msg
topicImage model =
    div []
        [ img [ src model.gifUrl ] [] ]



-- HTTP


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
    in
        Http.send NewGif (Http.get url decodeGifUrl)


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string
