defmodule Vimeo do
  @moduledoc """
  Provides access to the Vimeo API v3.
  """

  @doc """
  Initialises and configures Vimeo with a `client_id`,
  `client_secret` and `redirect_uri`. If you're not doing
  anything particularly interesting here, it's better to
  set them as environment variables and use `Vimeo.configure/0`

  ## Example
      iex(1)> Vimeo.configure("XXXX", "XXXX", "localhost:4000")
      {:ok, []}
  """
  defdelegate configure(client_id, client_secret, redirect_uri), to: Vimeo.Config, as: :configure

  @doc """
  Initialises Vimeo with system environment variables.
  For this to work, set `VIMEO_CLIENT_ID`, `VIMEO_CLIENT_SECRET`
  and `VIMEO_REDIRECT_URI`.

  ## Example
      VIMEO_CLIENT_ID=XXXX VIMEO_CLIENT_SECRET=XXXX VIMEO_REDIRECT_URI=localhost iex
      iex(1)> Vimeo.configure
      {:ok, []}
  """
  defdelegate configure, to: Vimeo.Config, as: :configure

  @doc """
  Sets a global user authentication token, this is useful for scenarios
  where your app will only ever make requests on behalf of one user at
  a time.

  ## Example
      iex(1)> Vimeo.configure(:global, "MY-TOKEN")
      :ok
  """
  defdelegate configure(:global, token), to: Vimeo.Config, as: :configure

  @doc """
  Returns the url you will need to redirect a user to for them to authorise your
  app with their Vimeo account. When they log in there, you will need to
  implement a way to catch the code in the request url (they will be redirected back
  to your `VIMEO_REDIRECT_URI`).

  **Note: This method authorises only 'public' scoped permissions
    [(more on this)](https://developer.vimeo.com/api/authentication#generate-redirect).**

  ## Example
      iex(8)> Vimeo.authorize_url!
      "https://api.vimeo.com/oauth/authorize/?client_id=XXX&redirect_uri=localhost%3A4000&response_type=code"
  """
  defdelegate authorize_url!, to: Vimeo.OAuthStrategy, as: :authorize_url!

  @doc """
  Returns the url to redirect a user to when authorising your app to use their
  account. Takes a list of permissions scopes as `atom` to request from Vimeo.

  Available options: `:public`, `:private`, `:purchased`, `:create`, `:edit`, `:delete`, `:interact` and `:upload`

  ## Example
      iex(1)> Vimeo.authorize_url!([:public, :private])
      "https://api.vimeo.com/oauth/authorize/?client_id=XXX&redirect_uri=localhost%3A4000&response_type=code&scope=public+private"
  """
  defdelegate authorize_url!(scope), to: Vimeo.OAuthStrategy, as: :authorize_url!

  @doc """
  Takes a `keyword list` containing the code returned from Vimeo in the redirect after
  login and returns a `%OAuth2.AccessToken` with an access token to store with the user or
  use for making authenticated requests.

  ## Example
      iex(1)> Vimeo.get_token!(code: code).access_token
      "XXXXXXXXXXXXXXXXXXXX"
  """
  defdelegate get_token!(code), to: Vimeo.OAuthStrategy, as: :get_token!


  ## ---------- Categories


  @doc """
  Returns a List of category as `%Elixtagram.Model.Category`

  ## Example
      iex(1)> Vimeo.categories()
      [%Elixtagram.Model.Category{...}, %Elixtagram.Model.Category{...}]
  """
  defdelegate categories, to: Vimeo.API.Categories, as: :categories

  @doc """
  Same as `Vimeo.categories/0`, except takes an explicit access token.

  ## Example
      iex(1)> Vimeo.categories("XXXXXXXXXXXXXXXXX")
      [%Elixtagram.Model.Category{...}, %Elixtagram.Model.Category{...}]
  """
  defdelegate categories(token), to: Vimeo.API.Categories, as: :categories

  @doc """
  Takes an category id and returns a `%Elixtagram.Model.Category`

  ## Example
      iex(1)> Vimeo.category(20)
      %Elixtagram.Model.Category{...}
  """
  defdelegate category(id), to: Vimeo.API.Categories, as: :category

  @doc """
  Same as `Vimeo.category/1`, except takes an explicit access token.

  ## Example
      iex(1)> Vimeo.category(20)
      %Elixtagram.Model.Category{...}
  """
  defdelegate category(id, token), to: Vimeo.API.Categories, as: :category

  @doc """
  Takes an category id and returns a List of `%Elixtagram.Model.Channel`

  ## Example
      iex(1)> Vimeo.category_channels(20)
      [%Elixtagram.Model.Channel{...}, %Elixtagram.Model.Channel{...}]
  """
  defdelegate category_channels(id), to: Vimeo.API.Categories, as: :category_channels

  @doc """
  Same as `Vimeo.category_channels/1`, except takes an explicit access token.

  ## Example
      iex(1)> Vimeo.category_channels(20)
      [%Elixtagram.Model.Channel{...}, %Elixtagram.Model.Channel{...}]
  """
  defdelegate category_channels(id, token), to: Vimeo.API.Categories, as: :category_channels

  @doc """
  Takes an category id and returns a List of `%Elixtagram.Model.Group`

  ## Example
      iex(1)> Vimeo.category_groups(20)
      [%Elixtagram.Model.Group{...}, %Elixtagram.Model.Group{...}]
  """
  defdelegate category_groups(id), to: Vimeo.API.Categories, as: :category_groups

  @doc """
  Same as `Vimeo.category_groups/1`, except takes an explicit access token.

  ## Example
      iex(1)> Vimeo.category_groups(20)
      [%Elixtagram.Model.Group{...}, %Elixtagram.Model.Group{...}]
  """
  defdelegate category_groups(id, token), to: Vimeo.API.Categories, as: :category_groups

  @doc """
  Takes an category id and returns a List of `%Elixtagram.Model.Video`

  ## Example
      iex(1)> Vimeo.category_videos(20)
      [%Elixtagram.Model.Video{...}, %Elixtagram.Model.Video{...}]
  """
  defdelegate category_videos(id), to: Vimeo.API.Categories, as: :category_videos

  @doc """
  Same as `Vimeo.category_videos/1`, except takes an explicit access token.

  ## Example
      iex(1)> Vimeo.category_videos(20)
      [%Elixtagram.Model.Video{...}, %Elixtagram.Model.Video{...}]
  """
  defdelegate category_videos(id, token), to: Vimeo.API.Categories, as: :category_videos


  ## ---------- Channels


  @doc """
  Returns a List of channel as `%Elixtagram.Model.Channel`

  ## Example
      iex(1)> Vimeo.channels()
      [%Elixtagram.Model.Channel{...}, %Elixtagram.Model.Channel{...}]
  """
  defdelegate channels, to: Vimeo.API.Channels, as: :channels

  @doc """
  Same as `Vimeo.channels/0`, except takes an explicit access token.

  ## Example
      iex(1)> Vimeo.channels("XXXXXXXXXXXXXXXXX")
      [%Elixtagram.Model.Channel{...}, %Elixtagram.Model.Channel{...}]
  """
  defdelegate channels(token), to: Vimeo.API.Channels, as: :channels

  @doc """
  Takes an channel id and returns a `%Elixtagram.Model.Channel`

  ## Example
      iex(1)> Vimeo.channel(20)
      %Elixtagram.Model.Channel{...}
  """
  defdelegate channel(id), to: Vimeo.API.Channels, as: :channel

  @doc """
  Same as `Vimeo.channel/1`, except takes an explicit access token.

  ## Example
      iex(1)> Vimeo.channel(20)
      %Elixtagram.Model.Channel{...}
  """
  defdelegate channel(id, token), to: Vimeo.API.Channels, as: :channel

  @doc """
  """
  defdelegate create_channel(data), to: Vimeo.API.Channels, as: :create_channel

  @doc """
  """
  defdelegate create_channel(data, token), to: Vimeo.API.Channels, as: :create_channel

  @doc """
  """
  defdelegate update_channel(id, data), to: Vimeo.API.Channels, as: :update_channel

  @doc """
  """
  defdelegate update_channel(id, data, token), to: Vimeo.API.Channels, as: :update_channel

  @doc """
  """
  defdelegate delete_channel(id), to: Vimeo.API.Channels, as: :delete_channel

  @doc """
  """
  defdelegate delete_channel(id, token), to: Vimeo.API.Channels, as: :delete_channel

  @doc """
  """
  defdelegate channel_users(id), to: Vimeo.API.Channels, as: :channel_users

  @doc """
  """
  defdelegate channel_users(id, token), to: Vimeo.API.Channels, as: :channel_users

  @doc """
  """
  defdelegate channel_videos(id), to: Vimeo.API.Channels, as: :channel_videos

  @doc """
  """
  defdelegate channel_videos(id, token), to: Vimeo.API.Channels, as: :channel_videos

  @doc """
  """
  defdelegate channel_video(channel_id, video_id), to: Vimeo.API.Channels, as: :channel_video

  @doc """
  """
  defdelegate channel_video(channel_id, video_id, token), to: Vimeo.API.Channels, as: :channel_video

  @doc """
  """
  defdelegate add_channel_video(channel_id, video_id), to: Vimeo.API.Channels, as: :add_channel_video

  @doc """
  """
  defdelegate add_channel_video(channel_id, video_id, token), to: Vimeo.API.Channels, as: :add_channel_video

  @doc """
  """
  defdelegate remove_channel_video(channel_id, video_id), to: Vimeo.API.Channels, as: :remove_channel_video

  @doc """
  """
  defdelegate remove_channel_video(channel_id, video_id, token), to: Vimeo.API.Channels, as: :remove_channel_video


  ## ---------- Me


  @doc """
  Returns authenticated user informations as `%Vimeo.Model.User`.

  ## Examples
      iex(1)> Vimeo.my_info()
      %Elixtagram.Model.User{...}
  """
  defdelegate my_info, to: Vimeo.API.Me, as: :my_info

  @doc """
  Same as `Vimeo.me/0`, except takes an explicit access token.

  ## Example
      iex(1)> Vimeo.my_info("XXXXXXXXXXXXXXXXX")
      %Elixtagram.Model.User{...}
  """
  defdelegate my_info(token), to: Vimeo.API.Me, as: :my_info


  @doc """
  Returns authenticated user albums as List of `%Elixtagram.Model.Album`

  ## Example
      iex(1)> Vimeo.my_albums()
      [%Elixtagram.Model.Album{...}, %Elixtagram.Model.Album{...}]
  """
  defdelegate my_albums, to: Vimeo.API.Me, as: :my_albums

  @doc """
  Same as `Vimeo.my_albums/0`, except takes an explicit access token.

  ## Example
      iex(1)> Vimeo.my_albums("XXXXXXXXXXXXXXXXX")
      [%Elixtagram.Model.Album{...}, %Elixtagram.Model.Album{...}]
  """
  defdelegate my_albums(token), to: Vimeo.API.Me, as: :my_albums

  @doc """
  Takes an album id and returns a `%Elixtagram.Model.Album`

  ## Example
      iex(1)> Vimeo.my_album(20)
      %Elixtagram.Model.Album{...}
  """
  defdelegate my_album(id), to: Vimeo.API.Me, as: :my_album

  @doc """
  Same as `Vimeo.my_album/1`, except takes an explicit access token.

  ## Example
      iex(1)> Vimeo.my_album(20, "XXXXXXXXXXXXXXXXX")
      %Elixtagram.Model.Album{...}
  """
  defdelegate my_album(id, token), to: Vimeo.API.Me, as: :my_album

  @doc """
  Returns channels the authenticated user follow as a List of `%Elixtagram.Model.Channel`

  ## Example
      iex(1)> Vimeo.my_channels()
      [%Elixtagram.Model.Channel{...}, %Elixtagram.Model.Channel{...}]
  """
  defdelegate my_channels, to: Vimeo.API.Me, as: :my_channels

  @doc """
  Same as `Vimeo.my_channels/0`, except takes an explicit access token.

  ## Example
      iex(1)> Vimeo.my_channels("XXXXXXXXXXXXXXXXX")
      [%Elixtagram.Model.Channel{...}, %Elixtagram.Model.Channel{...}]
  """
  defdelegate my_channels(token), to: Vimeo.API.Me, as: :my_channels

  @doc """
  Updates authenticated user informations.

  ## Examples
      iex(1)> Vimeo.update_profile(%{name: "test"})
      :ok
  """
  defdelegate update_profile(data), to: Vimeo.API.Me, as: :update_profile

  @doc """
  Same as `Vimeo.update_profile/1`, except takes an explicit access token.

  ## Example
      iex(1)> Vimeo.update_profile(%{name: "test"}, "XXXXXXXXXXXXXXXXX")
      :ok
  """
  defdelegate update_profile(data, token), to: Vimeo.API.Me, as: :update_profile

end
