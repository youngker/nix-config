use std::io::Cursor;
type Result<T> = std::result::Result<T, Box<dyn std::error::Error + Send + Sync>>;

pub async fn save_image(url: &str, name: &str) -> Result<()> {
    let dir = format!("{}{}", std::env::var("HOME")?, "/Pictures/Bing");
    std::fs::create_dir_all(&dir)?;
    let path = std::path::Path::new(&dir).join(name);
    let response = reqwest::get(url).await?;
    let mut file = std::fs::File::create(path)?;
    let mut content = Cursor::new(response.bytes().await?);
    std::io::copy(&mut content, &mut file)?;
    println!("{}", &format!("{}{}{}", dir, '/', name));
    wallpaper::set_from_path(&format!("{}{}{}", dir, '/', name)).unwrap();
    Ok(())
}

pub async fn bing_wallpaper() -> Result<()> {
    let response = "https://www.bing.com/HPImageArchive.aspx?&format=js&idx=0&mkt=en-US&n=1";
    let json = reqwest::get(response).await?.text().await?;
    let json: serde_json::Value = serde_json::from_str(&json).unwrap();
    let url = format!(
        "https://www.bing.com{}",
        json["images"][0]["url"].as_str().unwrap()
    );
    let name = &url[url.find("OHR.").ok_or(0).unwrap()..url.find("&rf=").ok_or(0).unwrap()];
    save_image(&url, name).await?;
    Ok(())
}

#[tokio::main]
async fn main() {
    bing_wallpaper().await.unwrap();
}
