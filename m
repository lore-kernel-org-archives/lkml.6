Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeEDJPs convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:15:48 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:46080 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751001AbeEDJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:15:46 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRWlGSWpSXmKPExsUSt3Opse4BlTd
  RBnsfK1qcatnDbjHtzm5WiysXDzFZTH34hM2iccZ8VotvVzqYLC7vmsNm0bmrn9Viw/e1jA6c
  Hhs+N7F5tF76y+Yxu+Eii8fOWXfZPTat6mTz2Pd2GZvH+i1XWTw+b5IL4IhizcxLyq9IYM14d
  /oqY8FJ0YrWH9OZGhinC3UxcnEICSxhlOi4+oK9i5GTg03AQmLyiQdsXYwcHCICmhLvL+eC1D
  ALHGKWWPEdJM7JISwQIXHp9lYWEFtEIFLi38uJTBC2kcSHmzdYQWwWARWJnhmtYDavQIDE7i8
  tYPOFBFwl1va+ApvPKeAmcXwZ2EhGAVmJL42rmUFsZgFxiVtP5oONlBAQkFiy5zwzhC0q8fLx
  P1YIW15i+7ff7BC2vcTre+9YQEZKCOhL9DUWQ4QNJVZNOwAVNpdYfF0SYrqOxILdn9ggbG2JZ
  QtfM0McKShxcuYTlgmM4rOQHDELScssJC2zkLQsYGRZxWiRVJSZnlGSm5iZo2toYKBraGisa6
  ZrbKiXWKWbpJdaqpucmldSlAiU1EssL9YrrsxNzknRy0st2cQITAYMQLCDcc2XxEOMkhxMSqK
  86uGvo4T4kvJTKjMSizPii0pzUosPMcpwcChJ8B5UfhMlJFiUmp5akZaZA0xLMGkJDh4lEd4b
  IGne4oLE3OLMdIjUKUZFKXHeoyAJAZBERmkeXBssFV5ilJUS5mUEOkSIpyC1KDezBFX+FaM4B
  6OSMO96kCk8mXklcNNfAS1mAlos/P41yOKSRISUVAOjenPP+5fyC7sLp/gzGZ/LClSYt2e2SC
  ZjlEh0g87myN4NSgbuM7L07s1Z9aXaXmL/m5POCtv0J8jk+t1Mc5s3neXL6SXnD6+p8FYQmmL
  5tGdXFGeqTtGmFx9+sOd/MXW71SH/SiT2x4+K7LTrG5q4dOPqjjwXPuIyU6bY5XbkenvTX8+O
  PBBVYinOSDTUYi4qTgQAS0JBnoADAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-20.tower-246.messagelabs.com!1525425344!319009!1
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
Subject: RE: [PATCH v3] ASoC: da7219: read fmw property to get mclk for
 non-dts systems
Thread-Topic: [PATCH v3] ASoC: da7219: read fmw property to get mclk for
 non-dts systems
Thread-Index: AQHT4rThMROUX0IB20eBW5/kFdM036QfSrWg
Date: Fri, 4 May 2018 09:15:42 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1EA102@SW-EX-MBX01.diasemi.com>
References: <1525334313-28661-1-git-send-email-akshu.agrawal@amd.com>
In-Reply-To: <1525334313-28661-1-git-send-email-akshu.agrawal@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 04/05/2018 08:09:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 May 2018 08:59, Akshu Agrawal wrote:

> Non-dts based systems can use ACPI DSDT to pass on the mclk
> to da7219.
> This enables da7219 mclk to be linked to system clock.
> Enable/Disable of the mclk is already handled in the codec so
> platform drivers don't have to explicitly do handling of mclk.
> 
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
> v2: Fixed kbuild error
> v3: Add corresponding clk_put for clk_get
>  include/sound/da7219.h    |  2 ++
>  sound/soc/codecs/da7219.c | 10 +++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
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
> index 980a6a8..ecd46fc 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -1624,6 +1624,8 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct
> snd_soc_component *compone
>  		dev_warn(dev, "Using default clk name: %s\n",
>  			 pdata->dai_clks_name);
> 
> +	device_property_read_string(dev, "dlg,mclk-name", &pdata->mclk_name);
> +

Personally am still not keen on this. To me the use of a device_property_*
function suggests the same property resides in both DT and ACPI, but here we're
only using this for the ACPI case. DT has no want or need for this. I still feel
we should look at something more generic in the clock framework, although I do
agree with Mark that this should be properly specced.

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
> +	if (!da7219->mclk)
> +		da7219->mclk = devm_clk_get(component->dev, "mclk");
>  	if (IS_ERR(da7219->mclk)) {
>  		if (PTR_ERR(da7219->mclk) != -ENOENT) {
>  			ret = PTR_ERR(da7219->mclk);
> @@ -1971,6 +1976,9 @@ static void da7219_remove(struct snd_soc_component
> *component)
>  		clkdev_drop(da7219->dai_clks_lookup);
>  #endif
> 
> +	if (da7219->pdata->mclk_name)
> +		clk_put(da7219->mclk);
> +
>  	/* Supplies */
>  	regulator_bulk_disable(DA7219_NUM_SUPPLIES, da7219->supplies);
>  }
> --
> 1.9.1
