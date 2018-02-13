Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934593AbeBMJWf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:22:35 -0500
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:14834
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934451AbeBMJW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:22:28 -0500
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
Thread-Index: AQHTmpZJ+PxrjoRrPk+EaFfwhBsz2qOONakAgBPtegA=
Date: Tue, 13 Feb 2018 09:22:24 +0000
Message-ID: <1518513744.25655.8.camel@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1655;6:VOke9P6DUlLgEwroL7YZzNPH8bEmfFifbfAfDyWU53QaplRRKjtEkrCCGQMtMP9I+l10L+V1ZiPq22RzxYoC0fUJq/72L9L77tW82RM7lVUHKpVV33hXj7ZoEewDQCJ5uzAsgZOtFeI7cXA5yWM3mKn/0lQ/9tTinj9fier85dHTcC5g1CEMaaWd3fP4FIZhcvRAOCDY5/wuZcMLvriEj6sL9FgxKwC2+gvtuymB4aDVOM92tAKWjs/ZauTahNnOpvaZi+JJQFIKJMIUe4VWH6kylfqVKkSbZIrl77XavUHgUfILyElol/TIJ+LmEt483wD1JR7o5OaBzR3e+p9kGruzDrJR+vhrhANA7uUFg+Drnmm5dpcLq/FQRqjcvU0G;5:A8xYOPYZmq2Ts9EMwXKt24gUvkBMSiwOlTZWoXx+6KNU/QGXO9TmpvpgWAqUQiAO5OZY1FQHDF7SXKTEZlOdGIDAgyRhDya1aEaJXyUaSATnycw4jdeX49Tzw1Ixi4utccBD5exUIZSdsQbVi5u9hQ2ODY5mjEVVe9b2ycdhXKo=;24:OtFkM/4qNy0BSMmf6YQoP7BhVsQPUWgR6MAtbnqdBAZ+uQlBwYhu1WUEJHkb34rgl7jg+RkHbxQ0uDbQYUabE6X6U7sWJK4tnXjtHDe4bHQ=;7:5Ck2iPW/7onC/90zJBi/E9vAc8cZ42C6AFhf2DMm6+fMOyZZGkQ3peqS6k2EHI85rGRb1tD8iHmeJwCmx3Fqj2VAZLHi0D5m22HprmKWwu4GHTFQrQ2l3MDytsZaBiJZAuk0CcU4JLcr/qh3IcB/lTm3mJqAtSAQjmTp7iO4wa9ctQ+akk0FN103a9EnLmH+eaA3RjGEasXEWRyvg8TClZSLVbnMyHh3XN1/Egfhzk+C7A5Kc5pgC09JEgjuXOMf
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb035928-27cd-4255-99ff-08d572c34b42
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DB5PR04MB1655;
x-ms-traffictypediagnostic: DB5PR04MB1655:
x-microsoft-antispam-prvs: <DB5PR04MB1655963CFD834A4D6D4C2DF49CF60@DB5PR04MB1655.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(944501161)(6055026)(6041288)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DB5PR04MB1655;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1655;
x-forefront-prvs: 0582641F53
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(39380400002)(199004)(189003)(6246003)(8936002)(53936002)(316002)(39060400002)(3280700002)(2906002)(14454004)(8676002)(86362001)(36756003)(6916009)(2950100002)(54906003)(6116002)(66066001)(76176011)(5640700003)(105586002)(3660700001)(2501003)(6512007)(3846002)(5250100002)(25786009)(6436002)(81166006)(81156014)(5660300001)(1730700003)(478600001)(6506007)(6486002)(97736004)(99286004)(68736007)(305945005)(103116003)(2351001)(229853002)(186003)(7736002)(26005)(106356001)(102836004)(2900100001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1655;H:DB5PR04MB1510.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: cYWE8RIKp5VJ5JSIvjuub92u5zWd2WnhNTSgN9ghuLokNEyER4KNZuHxpxxH9pNuGDpBewlyQiMZvq6/849rHw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEEC3802193D804DA3A698232AF5AA61@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb035928-27cd-4255-99ff-08d572c34b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2018 09:22:24.8388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1655
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1D9MdAo018173

Hi Mark,

> > 
> > +static int ak4458_hw_params(struct snd_pcm_substream *substream,
> > +			    struct snd_pcm_hw_params *params,
> > +			    struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_codec *codec = dai->codec;
> > +	struct ak4458_priv *ak4458 =
> > snd_soc_codec_get_drvdata(codec);
> > +	u8 format;
> > +	int pcm_width = max(params_physical_width(params), ak4458-
> > >slot_width);
> > +
> > +#ifdef AK4458_ACKS_USE_MANUAL_MODE
> > +	u8 dfs1, dfs2;
> > +#endif
> What's this and why is it a compile time option?

This is used to set the codec in Manual Setting Mode, meaning that
the default sampling speed is set based on DFS0 and DFS1 bits. In
Auto Setting Mode, the MCLK frequency is detected automatically and
DFS bits are ignored.
This compile time option is used to know when to set the ACKS bit in
init_reg function that switches between modes.
At this moment we are only using Auto Mode and I can remove it if
you think is not necessary.

Thank you,
Cosmin
