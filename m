Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeEPJhx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:37:53 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.132]:16174 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751182AbeEPJhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:37:50 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRWlGSWpSXmKPExsUSt3Opse7r37+
  jDD4f1LA41bKH3WLand2sFlcuHmKymPrwCZtF44z5rBbfrnQwWVzeNYfNonNXP6vFhu9rGR04
  PTZ8bmLzaL30l81jdsNFFo+ds+6ye2xa1cnmse/tMjaP9Vuusnh83iQXwBHFmpmXlF+RwJrRs
  ewiY8FLxYrmSR9ZGxg3KHYxcnEICSxllDi7uYuli5GTg03AQmLyiQdsILaIQKLEnuc7mUBsZo
  FeZoklE7NAbGGBCIlLt7eyQNRESvx7OZEJwnaSmLZ+BlCcnYNFQFXiMidIlFcgQOLxxHtgFUI
  Cuxkl2u+BTecUsJaY8nYFmM0oICvxpXE1M8QmcYlbT+aD1UsICEgs2XOeGcIWlXj5+B8rhC0v
  sf3bb3YI217i9b13LBC2vsSjx48YIWxDiVXTDkDFzSWaJi0EqucAmq8psX6XPsQqRYkp3Q/ZI
  c4UlDg58wnLBEbxWUiumIXQMQtJxywkHQsYWVYxWiQVZaZnlOQmZuboGhoY6BoaGukaGRjqGp
  ma6iVW6SbrpZbqlqcWl+ga6iWWF+sVV+Ym56To5aWWbGIEpgIGINjB+Ohb8iFGSQ4mJVHe6d2
  /o4T4kvJTKjMSizPii0pzUosPMcpwcChJ8PoBU4uQYFFqempFWmYOMCnBpCU4eJREeF/8Akrz
  Fhck5hZnpkOkTjHqcjy5PK2HWYglLz8vVUqc1xRkhgBIUUZpHtwIWIK8xCgrJczLCHSUEE9Ba
  lFuZgmq/CtGcQ5GJWFeK5ApPJl5JXCbXgEdwQR0BOMBsCNKEhFSUsD0lt1t8WG9XcC1MvPkx9
  p72i+7+p3JNt0T+NRkzzT3HSwr90RJXzzqzicsc01hVWjjRWbOucoWLZeX1t9ZtT5YrHzBYsY
  nvZ8YEr3sONf862ksmpW8901CMO/JBo17p7JXzjxg7JK976aN2mOnnw19slUbDqxcrsHAGCqs
  cEp32ZILTcd+1U5QYinOSDTUYi4qTgQAR1CDkYsDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-3.tower-302.messagelabs.com!1526463467!3123!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC: "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] ASoC: da7219: read fmw property to get mclk for
 non-dts systems
Thread-Topic: [PATCH v3] ASoC: da7219: read fmw property to get mclk for
 non-dts systems
Thread-Index: AQHT4rThMROUX0IB20eBW5/kFdM036QfSrWggARc3wCADoE7oA==
Date: Wed, 16 May 2018 09:37:46 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1ED3D3@SW-EX-MBX01.diasemi.com>
References: <1525334313-28661-1-git-send-email-akshu.agrawal@amd.com>
 <2E89032DDAA8B9408CB92943514A0337014C1EA102@SW-EX-MBX01.diasemi.com>
 <e17e2c9e-923d-fea6-26be-5f14c99a45cb@amd.com>
In-Reply-To: <e17e2c9e-923d-fea6-26be-5f14c99a45cb@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 16/05/2018 07:55:00
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4G9bw6x021732

On 07 May 2018 05:50, Agrawal, Akshu wrote:

Apologies for the delay in response. Please see comments below.

> On 5/4/2018 2:45 PM, Adam Thomson wrote:
> > On 03 May 2018 08:59, Akshu Agrawal wrote:
> >
> >> Non-dts based systems can use ACPI DSDT to pass on the mclk
> >> to da7219.
> >> This enables da7219 mclk to be linked to system clock.
> >> Enable/Disable of the mclk is already handled in the codec so
> >> platform drivers don't have to explicitly do handling of mclk.
> >>
> >> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> >> ---
> >> v2: Fixed kbuild error
> >> v3: Add corresponding clk_put for clk_get
> >>  include/sound/da7219.h    |  2 ++
> >>  sound/soc/codecs/da7219.c | 10 +++++++++-
> >>  2 files changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/sound/da7219.h b/include/sound/da7219.h
> >> index 1bfcb16..df7ddf4 100644
> >> --- a/include/sound/da7219.h
> >> +++ b/include/sound/da7219.h
> >> @@ -38,6 +38,8 @@ struct da7219_pdata {
> >>
> >>  	const char *dai_clks_name;
> >>
> >> +	const char *mclk_name;
> >> +
> >>  	/* Mic */
> >>  	enum da7219_micbias_voltage micbias_lvl;
> >>  	enum da7219_mic_amp_in_sel mic_amp_in_sel;
> >> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> >> index 980a6a8..ecd46fc 100644
> >> --- a/sound/soc/codecs/da7219.c
> >> +++ b/sound/soc/codecs/da7219.c
> >> @@ -1624,6 +1624,8 @@ static struct da7219_pdata
> *da7219_fw_to_pdata(struct
> >> snd_soc_component *compone
> >>  		dev_warn(dev, "Using default clk name: %s\n",
> >>  			 pdata->dai_clks_name);
> >>
> >> +	device_property_read_string(dev, "dlg,mclk-name", &pdata->mclk_name);
> >> +
> >
> > Personally am still not keen on this. To me the use of a device_property_*
> > function suggests the same property resides in both DT and ACPI, but here we're
> > only using this for the ACPI case. DT has no want or need for this. I still feel
> > we should look at something more generic in the clock framework, although I do
> > agree with Mark that this should be properly specced.
> >
> 
> I am not an expert in field of ACPI, IMO forming a Spec and changing
> ACPI to have DT like clock framework is good to have but a bigger change
> which should be taken up later.

That's fair enough, but I wonder who will take that on. Really would be
beneficial to have something generic on the ACPI side.
 
> The current code of handling of mclk in the driver is usable only by DT.
> The device_property (though ACPI specific) makes this code, a common
> code for DT and ACPI based devices.
> 
> https://www.kernel.org/doc/Documentation/acpi/DSD-properties-rules.txt
> "....Still, for the sake of code re-use, it may make sense to provide as
> much of the configuration data as possible in the form of device
> properties and complement that with an ACPI-specific mechanism suitable
> for the use case at hand......"

Given that on the DT side there's the expectation that the generic 'clock-names'
property might be provided to the driver, could we not reuse that rather than
introducing 'dlg,mclk-name' and diverging DT and ACPI properties?

> 
> Thanks,
> Akshu
