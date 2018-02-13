Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935121AbeBMMPl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:15:41 -0500
Received: from mail-db5eur01on0075.outbound.protection.outlook.com ([104.47.2.75]:7687
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934806AbeBMMPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:15:24 -0500
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "mihai.serban@gmail.com" <mihai.serban@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mihai.serban@nxp.com" <mihai.serban@nxp.com>
Subject: Re: [PATCH v3 1/2] ASoC: codecs: Add support for AK5558 ADC driver
Thread-Topic: [PATCH v3 1/2] ASoC: codecs: Add support for AK5558 ADC driver
Thread-Index: AQHTnqMe40f3GRvnnE2u97ukorH0vKOgtVyAgAGV/oA=
Date: Tue, 13 Feb 2018 12:15:20 +0000
Message-ID: <1518524119.17642.15.camel@nxp.com>
References: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com>
         <1517850115-24340-2-git-send-email-daniel.baluta@nxp.com>
         <20180212120213.GB12976@sirena.org.uk>
In-Reply-To: <20180212120213.GB12976@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com;
x-originating-ip: [92.121.36.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB370;7:yXTZVkvjCQC44uYsXPkTR4SS2l9ey/E/e1b4z5BViod37WAq1UXhbwAivcJ7Li9GWtENZXeXca205GxboJRyDKn9hycPuJIF1nHDMEuX11znIsg8VqKOGv4CvZCkXzLrN+991jvfMs4ds0YWAzD7ZLxdk/JZy+1814toXlqOlg+O8lJQ8WSGrM0BH1V92R37JoxoVg9O7UbWP2JGZ5CF7D/IcrSa47/JFD4TK4NE2Ea+QQZnvtsiB9dGoiQwbZow
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec0d69ad-ea3a-47ae-ed77-08d572db7355
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB370;
x-ms-traffictypediagnostic: AM3PR04MB370:
x-microsoft-antispam-prvs: <AM3PR04MB370A0DCFC8338E11F441F9BF9F60@AM3PR04MB370.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(944501161)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB370;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB370;
x-forefront-prvs: 0582641F53
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(39380400002)(396003)(189003)(199004)(377424004)(39060400002)(4326008)(2950100002)(6512007)(103116003)(3846002)(53936002)(8936002)(2501003)(2900100001)(36756003)(305945005)(478600001)(1730700003)(5660300001)(81156014)(8676002)(54906003)(25786009)(5250100002)(76176011)(5640700003)(2906002)(6116002)(81166006)(7736002)(3660700001)(6916009)(106356001)(316002)(2351001)(3280700002)(26005)(6246003)(99286004)(66066001)(186003)(86362001)(6436002)(59450400001)(14454004)(6506007)(97736004)(68736007)(105586002)(102836004)(6486002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB370;H:AM3PR04MB500.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: U8FiGPNh1qcReJWs26s03gKUy8NWUfo/CxNHUQGTfIzbJy+ARkqlZ42ptJmok73AJqpvORdSjq88JAjlgc/5Gg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDB44FFC22D9194A9A45C96998A96FBA@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0d69ad-ea3a-47ae-ed77-08d572db7355
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2018 12:15:20.0271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB370
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1DCHl7O005127

On Lu, 2018-02-12 at 12:02 +0000, Mark Brown wrote:
> On Mon, Feb 05, 2018 at 07:01:54PM +0200, Daniel Baluta wrote:
> > 
> > AK5558 is a 32-bit, 768 kHZ sampling, differential input ADC
> > for digital audio systems.
> > 
> > --- /dev/null
> > +++ b/sound/soc/codecs/ak5558.c
> > @@ -0,0 +1,618 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Audio driver for AK5558 ADC
> Please don't mix C++ and C style comments - just make the entire comment
> C++.
> 
Sure. Will use:
// SPDX-License-Identifier: GPL-2.0

> > 
> > +static const char * const tdm_texts[] = {
> > +	"Off", "TDM128",  "TDM256", "TDM512",
> > +};
> This looks like it should be a set_tdm_slot() operation, and indeed
> set_tdm_slot() appears to be implemented and duplicate this.
> 

Yup, will remove this. At first there was no set_tdm_slot.
> > 
> > +static const char * const dsdon_texts[] = {
> > +	"PCM", "DSD",
> > +};
> This looks like it's setting the DAI format?

Ditto. Will remove.

> 
> > 
> > +	SND_SOC_DAPM_MUX("AK5558 Ch1 Enable", SND_SOC_NOPM, 0, 0,
> > +			 &ak5558_channel1_mux_control),
> On/off controls should be switches not muxes, though if this is just
> selecting which channels are active (rather than a mute) I'd not expect
> it to be a control at all - the board can say if inputs are disabled.

OK, agree that if we want to have a way to select which channels are active
we should use a switch.

Will remove this control for now.

> 
> > 
> > +static int ak5558_set_mcki(struct snd_soc_codec *codec, int fs, int rclk)
> > +{
> > +	u8  mode;
> > +
> > +	mode = snd_soc_read(codec, AK5558_02_CONTROL1);
> > +	mode &= ~AK5558_CKS;
> > +	mode |= AK5558_CKS_AUTO;
> > +
> > +	snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_CKS, mode);
> > +
> > +	return 0;
> > +}
> This appears to just ignore the parameters?

These are left overs from a v1 cleanup. Will fix.


thanks Mark! Will send v4 asap.

thanks,
Daniel.
