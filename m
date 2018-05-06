Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbeEFGKS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 02:10:18 -0400
Received: from mail-ve1eur01on0044.outbound.protection.outlook.com ([104.47.1.44]:17136
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750885AbeEFGKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 02:10:14 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Haibo Chen <haibo.chen@freescale.com>, Andy Duan <fugang.duan@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>, Robin Gong <yibin.gong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V6 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch
 screen support
Thread-Topic: [PATCH V6 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch
 screen support
Thread-Index: AQHT5Eu+7BQKgbFdhEu7laYNHJH8aKQhP9GAgAD5KcA=
Date: Sun, 6 May 2018 06:10:11 +0000
Message-ID: <AM3PR04MB1315E5B2A6C1DDCC6C279715F5840@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
 <1525508963-7986-7-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5A7bf1qcHrWjM1mr31Nkz+oDJ=fQo3rjksp1YY-HhPM9A@mail.gmail.com>
In-Reply-To: <CAOMZO5A7bf1qcHrWjM1mr31Nkz+oDJ=fQo3rjksp1YY-HhPM9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1171;7:nFKPprHNZmOJXUXarx1iNcCYBdD88NBlVZXHq/rdkFqbXos/dWu8jMEGi4rI9KEalOz6hyYKQhCu3uGm4/oOrVMTejXuzTBk6V1DBm+Pk3dQPQKBK42QAjxfepMhAxzKwbtwsYMzZJs1nPuM1c9wDezmICuj8Yx4lmyKDdYtBjswdXrAILv2oDiuaTiUbCyRCuoDsG9Ks+DF7RoHp3cHKVvmnBXslMc9CY0e7yQoD4w4VPJFeZJYpQpBGbyB4p9h
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1171;
x-ms-traffictypediagnostic: AM3PR04MB1171:
x-microsoft-antispam-prvs: <AM3PR04MB117115D679A24144B89E5610F5840@AM3PR04MB1171.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(101931422205132)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:AM3PR04MB1171;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1171;
x-forefront-prvs: 06640999CA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(346002)(376002)(366004)(13464003)(189003)(199004)(33656002)(316002)(6116002)(3846002)(1411001)(7736002)(76176011)(102836004)(2900100001)(186003)(106356001)(7696005)(14454004)(74316002)(53546011)(26005)(6506007)(68736007)(105586002)(6916009)(53936002)(44832011)(97736004)(66066001)(86362001)(478600001)(3660700001)(6436002)(6246003)(3280700002)(476003)(39060400002)(2906002)(54906003)(486006)(11346002)(5660300001)(446003)(5250100002)(8936002)(9686003)(8676002)(55016002)(4326008)(99286004)(81166006)(81156014)(305945005)(229853002)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1171;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: yNPoUEsRyNjD+qgbmHF2NU3hnVBicEn8MMk8CD3Z6Q87TtLXqL9il5ISCv9K91Q0aea91yI2zMsHWqqVmoWhXyGqRkySw/bs4N2JCoBfI9bVRKNFlhac2nzR5vwcf+OBmG053KSzG3iZPHsDmPaO6Fv5JaERrqt8HEfy2azjzJfhMRTTiVkEby83gdwRDRDl
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 306df553-c276-4e16-5eba-08d5b3180687
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306df553-c276-4e16-5eba-08d5b3180687
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2018 06:10:11.2133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1171
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w466ANdu006209

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Saturday, May 5, 2018 11:18 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Haibo Chen <haibo.chen@freescale.com>; Andy Duan
> <fugang.duan@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>; Robin Gong
> <yibin.gong@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH V6 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch
> screen support
> 
> On Sat, May 5, 2018 at 5:29 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> 
> >  &iomuxc {
> > +       pinctrl_egalax_int: egalax-intgrp {
> > +               fsl,pins = <
> > +                       MX6SX_PAD_SD4_RESET_B__GPIO6_IO_22
> 0x80000000
> 
> Please avoid using 0x80000000 and use the real IOMUX value instead.
 
Will use the expected pad settings in next version. Thanks.

Anson.
