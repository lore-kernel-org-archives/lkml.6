Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751057AbeBIKWY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:22:24 -0500
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:53248
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750878AbeBIKWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:22:21 -0500
From: Cosmin Samoila <cosmin.samoila@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>,
        "mihai.serban@gmail.com" <mihai.serban@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mihai.serban@nxp.com" <mihai.serban@nxp.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK4458 DAC driver
Thread-Topic: [PATCH] ASoC: codecs: Add support for AK4458 DAC driver
Thread-Index: AQHTmpZJ+PxrjoRrPk+EaFfwhBsz2qOONakAgA204QA=
Date: Fri, 9 Feb 2018 10:22:16 +0000
Message-ID: <1518171736.19973.7.camel@nxp.com>
References: <1517404809-25250-1-git-send-email-cosmin.samoila@nxp.com>
         <20180131170330.GB7763@sirena.org.uk>
In-Reply-To: <20180131170330.GB7763@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cosmin.samoila@nxp.com;
x-originating-ip: [92.121.36.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1095;6:n6hM6qQiM+qbfPUaw7+TppPdpLDDWtd+qY42UrsQQWcT2iWwK79jwWdOFIVDedrgj+geYOP3v9aHuxrk/m+nzc2+oJYRQjrJogZcRyK9t7uwmXfWOT1G5cNtwUfmy2uh9CW4OghAIV307Fir57K/yhPlDEbsLhtMMVaJuua9GIVAQposEaB4tGJjqqfH8VhxX2tTMHg0DzVNgmGrnXjDVtilh1nsZOchjFb1k079JzxsboDiL1dz0lndv34kKRv5PTCmHHF3ejViuqWs36/+Ugi+tjHsm1hYzQAyNXZi054FNSvo1gyYXxhby7/4QqiqmBod/HFtct1tvWMHwPU293TMTa9rZci0XC6/xHlWbus2x///9WoQdQ9irH3Ca4XK;5:Ceqt0WVLs1UWTMObSIj19doZRgBFtrGmYBZuk0VLEhk0UsOMuoipS2U3HZwYYzLkXBep5G2ofQUxFi47dQUOy5ASjUI5Vl0PyMQpSEkNGejbGJQ0w8BEBp0stF4TOH2kxLOtsZSgPveEhzCzfqpg14olsAbPE11lQOJpEA7rg7Q=;24:TF+nd7e+jSkbZbGFwI50o9u2o5/XcPfgtOuhQpIn4pDBADm/nZmcVgpTuevxz/ZbXzlYskc7WAbfNKfOViHQLPoBONpp7uI+rAKD53qP50A=;7:Z7OwZELVGPoNxRvrUQMbub9EaP9uX++tubQPxo/0pBKZ6sKvKVPfrUqVoVDXKQ8MCozXu8wian67sCUoVeDS14+4KN5k2nmqkETjvYJkdD37+gHR4XF36kDD9rfpK5qD/MLiI5MFFzekVlKEsTPuC7Lw8jAtfQrrtdkz7yvHAIe8OeNP1hBIE8kW6t+9iFVV/Of5MiuVQZ77tMR6hgDuFE0QeUAOcmgoB/rdgkh/54XBjtFcqqWSA3EOTqjIn/W1
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51ff6cfd-9071-47e6-244b-08d56fa6fe7b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DB5PR04MB1095;
x-ms-traffictypediagnostic: DB5PR04MB1095:
x-microsoft-antispam-prvs: <DB5PR04MB1095261189D004A88C64CB2A9CF20@DB5PR04MB1095.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DB5PR04MB1095;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1095;
x-forefront-prvs: 057859F9C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(376002)(366004)(39860400002)(199004)(189003)(40764003)(3846002)(76176011)(81156014)(5660300001)(2900100001)(81166006)(8676002)(106356001)(1730700003)(6506007)(99286004)(102836004)(6436002)(5250100002)(3660700001)(2501003)(478600001)(6916009)(2950100002)(345774005)(229853002)(86362001)(6486002)(68736007)(5640700003)(305945005)(6512007)(53936002)(186003)(6246003)(97736004)(26005)(7736002)(36756003)(316002)(4326008)(103116003)(39060400002)(54906003)(6116002)(66066001)(14454004)(2906002)(3280700002)(25786009)(2351001)(105586002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1095;H:DB5PR04MB1510.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jbbiXQF3uW1DvIPP3qoxRumyvFJtFf2WK8Lo5lczsfmhE3n42DnWqJQza/AUtn5La2t+1B0CXYyE3DugpKoD6w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E42495FC0835B74085021FA379D47FFD@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ff6cfd-9071-47e6-244b-08d56fa6fe7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2018 10:22:16.5655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1095
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w19AMTf1018576

Hi Mark,

> > +static const struct soc_enum ak4458_dac_enum[] = {
> > +/*0*/	SOC_ENUM_SINGLE(AK4458_01_CONTROL2, 1,
> > +			ARRAY_SIZE(ak4458_dem_select_texts),
> > +			ak4458_dem_select_texts),
> > +/*1*/	SOC_ENUM_SINGLE(AK4458_0A_CONTROL6, 0,
> The fact that you need these comments is why these arrays are a bad
> idea
> - just use individually named variables as other drivers do.
> 
> > 
> > +static const struct snd_kcontrol_new ak4458_snd_controls[] = {
> > +	SOC_SINGLE_TLV("AK4458 L1ch Digital Volume",
> > +		       AK4458_03_LCHATT, 0/*shift*/, 0xFF/*max
> > value*/,
> > +		       0/*invert*/, latt_tlv),
> > +	SOC_SINGLE_TLV("AK4458 R1ch Digital Volume",
> > +		       AK4458_04_RCHATT, 0, 0xFF, 0, ratt_tlv),
> It'd be more idiomatic to combine these into stereo pairs than have
> them
> as single channel controls.
> 
> > 
> > +static const char * const ak4458_dac_select_texts[] = { "OFF",
> > "ON" };
> This looks like the users should be switch controls - what's the goal
> here?
> 
> > 

I think this is to allow users to switch off sound for all channels but
it seems silly to have 4 controls doing the same thing.
We now have two options:
- one control to switch off sound for all channels
- one controll per DAC

What do you mean by "users should be switch controls" ?
Should we use SND_SOC_DAPM_SWITCH instead of SND_SOC_DAPM_MUX?

We are still learing the inner details of ASoC.
Thank you for your help.

Cosmin
