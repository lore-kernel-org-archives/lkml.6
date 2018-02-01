Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeBAJGG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 04:06:06 -0500
Received: from mail-ve1eur01on0087.outbound.protection.outlook.com ([104.47.1.87]:43584
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751423AbeBAJF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:05:59 -0500
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC: dl-linux-imx <linux-imx@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>,
        "mihai.serban@gmail.com" <mihai.serban@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mihai.serban@nxp.com" <mihai.serban@nxp.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK5558 ADC driver
Thread-Topic: [PATCH] ASoC: codecs: Add support for AK5558 ADC driver
Thread-Index: AQHTmpMmXJa7uwAgokSqghD+5lSJdqOOJ16AgAEbNgA=
Date: Thu, 1 Feb 2018 09:05:55 +0000
Message-ID: <1517475954.8615.18.camel@nxp.com>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
         <CAHp75Vdd58U1y-LOQGg=rePOWf1LeQsZxn2ykzBhXL013ztW3Q@mail.gmail.com>
In-Reply-To: <CAHp75Vdd58U1y-LOQGg=rePOWf1LeQsZxn2ykzBhXL013ztW3Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com;
x-originating-ip: [92.121.36.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0550;7:N51dv7bp+YSgvKRZwlr6ezMMs63r4ZsiQtu3xrUHD9eFed0xNYyYoh1ePqbV5+GjN8UKx1jEASt6aAUF8fCTTEJZDpN5IqafMXPZaq8FQVdsj+LrlB5tJhtkvUh0ijHcjAyYLLw3Pnz/eqhPEBhipxJava9ktK/c8d2fhj/pQMSwhMRdSeIojMk4RZ8cLKvgmbhbCbrxIL9KTLUbpJspVDnolrIJeyAyNioM9bbHIZ0JP0k0zkxarb2CztO3jJff
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 688f0542-bb8d-4784-bd80-08d5695300ba
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB0550;
x-ms-traffictypediagnostic: AM3PR04MB0550:
x-microsoft-antispam-prvs: <AM3PR04MB055017BBACD284EED26074F1F9FA0@AM3PR04MB0550.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB0550;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0550;
x-forefront-prvs: 0570F1F193
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(39380400002)(366004)(376002)(199004)(189003)(377424004)(53936002)(3846002)(305945005)(6636002)(3280700002)(316002)(229853002)(2950100002)(68736007)(110136005)(6116002)(99286004)(6306002)(8936002)(6512007)(3660700001)(5250100002)(102836004)(105586002)(8676002)(53546011)(76176011)(26005)(6436002)(186003)(5660300001)(6506007)(81156014)(2501003)(54906003)(86362001)(36756003)(4326008)(2900100001)(6246003)(66066001)(14454004)(25786009)(966005)(106356001)(103116003)(39060400002)(478600001)(81166006)(7736002)(2906002)(97736004)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0550;H:AM3PR04MB500.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: wZs7d4Ha1WA8GRCYFzfxayN8B+Hj8lp+Pv2k4OLPTJps1kYLJMOdeU3Gg9Vj0kTadeC5bhSFuZv3Nhqj2z/ehQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA9525180D80B24B8DCE8EB3B512EFEF@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688f0542-bb8d-4784-bd80-08d5695300ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2018 09:05:55.6514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0550
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1196Cli003310

Hi Fabio, Andy,

Thanks a lot for your comments. I will address them and send v2.

Few comments inline.

On Mi, 2018-01-31 at 18:12 +0200, Andy Shevchenko wrote:
> On Wed, Jan 31, 2018 at 2:57 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
> > 
> > AK5558 is a 32-bit, 768 kHZ sampling, differential input ADC
> > for digital audio systems.
> > 
> > Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
> > Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> 4 authors of the code?!

The code has a very long history. I will add under each SoB the specific
contribution.

Mihai got the code from Junichi and reworked it for 4.9. Then Shengjiu and
me added various features and cleanups.

According to DCO [1] all SoB are valid and required.


> > +MODULE_AUTHOR("Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>");
> > +MODULE_AUTHOR("Mihai Serban <mihai.serban@nxp.com>");
> 4 SoBs, 2 Authors. Please, fix accordingly.

Here I would prefer to list Junichi and Mihai because they were the main contributors.
Any other suggestion?

thanks,
Daniel.

[1] [1] https://developercertificate.org/
