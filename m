Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754363AbeD3TF0 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:05:26 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.141]:51818 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753397AbeD3TFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:05:24 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRWlGSWpSXmKPExsUSt3Opse7HjOd
  RBvefs1qcatnDbjHtzm5WiysXDzFZTH34hM2iccZ8VotvVzqYLC7vmsNm0bmrn9Viw/e1jA6c
  Hhs+N7F5tF76y+Yxu+Eii8fOWXfZPTat6mTz2Pd2GZvH+i1XWTw+b5IL4IhizcxLyq9IYM148
  ewXc8Ek4YqZ1zexNzD2CXQxcnIICSxllLjT4Q5iswlYSEw+8YCti5GDQ0RAU+L95dwuRi4OZo
  FDzBIrvoPEOTmEBSIk1i67xwRiiwhESjQuO8QMYRtJLHt7jx3EZhFQlXjftBCshlcgQGLC+mf
  sELtcJZ683QJWzyngJnHj7nUwm1FAVuJL42owm1lAXOLWk/lgvRICAhJL9pxnhrBFJV4+/scK
  YctLbFx5FqrGXuL1vXcsELa+xKPHjxghbEOJVdMOQMXNJV4/vcMIMV9HYsHuT2wQtrbEsoWvm
  SHuFJQ4OfMJywRG8VlIzpiFpGUWkpZZSFoWMLKsYtQoTi0qSy3SNTTVSyrKTM8oyU3MzNE1ND
  DVy00tLk5MT81JTCrWS87P3cQIjHgGINjB2LDd8xCjJAeTkigvy+JnUUJ8SfkplRmJxRnxRaU
  5qcWHGGU4OJQkeKvSn0cJCRalpqdWpGXmAFMPTFqCg0dJhLcbJM1bXJCYW5yZDpE6xagoJc67
  AyQhAJLIKM2Da4Olu0uMslLCvIxAhwjxFKQW5WaWoMq/YhTnYFQS5p0GMoUnM68EbvoroMVMQ
  IulGZ+ALC5JREhJNTCaS+3I4T++6FZ+u8femTuVLt569SkvsCOj5835P0w5hzPcJlzdv1Pm8t
  mNl1g55tQuv7CXb2XQ18MaK1t8Wv8F3s65lfbN/Fq63e7+sy8fnuaeNOGnytbMo3sDJlyXrjq
  p8XdW65eW3sXfjeQORJ7wkFywovXiZr/lPt82GDAYLPC+o+kVeXhysxJLcUaioRZzUXEiAK0U
  ywZyAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-3.tower-180.messagelabs.com!1525115120!106270880!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Akshu Agrawal <akshu.agrawal@amd.com>
CC: "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ASoC: da7219: read fmw property to get mclk for
 non-dts systems
Thread-Topic: [PATCH v2] ASoC: da7219: read fmw property to get mclk for
 non-dts systems
Thread-Index: AQHT4GUsuHphZND160Sqg+RURjmwB6QZqjfg
Date: Mon, 30 Apr 2018 19:05:19 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E93BC@SW-EX-MBX01.diasemi.com>
References: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
In-Reply-To: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.35.54]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 30/04/2018 16:14:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 April 2018 10:23, Akshu Agrawal wrote:

> Non-dts based systems can use ACPI DSDT to pass on the mclk
> to da7219.
> This enables da7219 mclk to be linked to system clock.
> Enable/Disable of the mclk is already handled in the codec so
> platform drivers don't have to explicitly do handling of mclk.

There is already a means via DT to specify the MCLK for a device using the
generic clock DT bindings, and this driver already uses that. Should ACPI not
have something similar to that which is generic, rather than adding device
specific bindings/properties to achieve the same? There will be other drivers
that will want to do the same.

>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
> v2: Fixed kbuild error
>  include/sound/da7219.h    | 2 ++
>  sound/soc/codecs/da7219.c | 7 ++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/sound/da7219.h b/include/sound/da7219.h
> index 1bfcb16..df7ddf4 100644
> --- a/include/sound/da7219.h
> +++ b/include/sound/da7219.h
> @@ -38,6 +38,8 @@ struct da7219_pdata {
>
>  	const char *dai_clks_name;
>
> +	const char *mclk_name;
> +
>  	/* Mic */
>  	enum da7219_micbias_voltage micbias_lvl;
>  	enum da7219_mic_amp_in_sel mic_amp_in_sel;
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index 980a6a8..aed68a4 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -1624,6 +1624,8 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct
> snd_soc_component *compone
>  		dev_warn(dev, "Using default clk name: %s\n",
>  			 pdata->dai_clks_name);
>
> +	device_property_read_string(dev, "dlg,mclk-name", &pdata->mclk_name);
> +
>  	if (device_property_read_u32(dev, "dlg,micbias-lvl", &of_val32) >= 0)
>  		pdata->micbias_lvl = da7219_fw_micbias_lvl(dev, of_val32);
>  	else
> @@ -1905,7 +1907,10 @@ static int da7219_probe(struct snd_soc_component
> *component)
>  	da7219_handle_pdata(component);
>
>  	/* Check if MCLK provided */
> -	da7219->mclk = devm_clk_get(component->dev, "mclk");
> +	if (da7219->pdata->mclk_name)
> +		da7219->mclk = clk_get(NULL, da7219->pdata->mclk_name);

By doing this you would need an associated 'clk_put()' whereas the devm call
avoids this.

> +	if (!da7219->mclk)
> +		da7219->mclk = devm_clk_get(component->dev, "mclk");
>  	if (IS_ERR(da7219->mclk)) {
>  		if (PTR_ERR(da7219->mclk) != -ENOENT) {
>  			ret = PTR_ERR(da7219->mclk);
> --
> 1.9.1
