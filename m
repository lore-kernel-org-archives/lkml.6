Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755106AbeCSB7v (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:59:51 -0400
Received: from mail-ve1eur01on0072.outbound.protection.outlook.com ([104.47.1.72]:19728
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754805AbeCSB7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:59:49 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
Thread-Topic: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
Thread-Index: AQHTvecGA2WAr97bW0y2mrrIxoc0m6PUg4QAgAC/RZCAALH5AIAA2hWg
Date: Mon, 19 Mar 2018 01:59:41 +0000
Message-ID: <AM3PR04MB1315E036D33F27C9AF617252F5D40@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BzE46Dm24++j+xVA4KGFnpsopGfJ97h7sFGOAxVa19=g@mail.gmail.com>
 <AM3PR04MB1315E1C3071C0BD2E7169968F5D50@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AFJk_Q5CYrV0s+hLmORHosWujRSGjwf9smyAQc4nmJ+A@mail.gmail.com>
In-Reply-To: <CAOMZO5AFJk_Q5CYrV0s+hLmORHosWujRSGjwf9smyAQc4nmJ+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB418;6:y8OnC4VFx+WWgJAcLrQcG4MPRCqfpC01cSr7vqnQfVdpHjIxbR3cuBEX7UaF8ZF2IbofiQKJcBv+p+lhN+GF9uiEhflu6wzKAw1eNdMIn0IqP5OdcY08wIPkJSDytkIWT9J8vP8EsrdgnhIL9QDOXWHIVxXnoyLswfXdhGHRIAGQD7Z393xnukhNrWD4CmaoIr26aHu82mORnAJHCJ5zU7C7blKGWBEjK1BV5bYjHlnQ6Tel2WiRY36QU7iu05n3baAccQP4cAuqTxJfGev4nilI/lgQfI3hwVY9RHb5DRPpKEInxiLbFqUQjZtKmlrZ5SgtXoy8YjhXWTH1b6othQmQBCpugbr2ihKDZilQElV6jHhHxZqyKr3/u5za1BOE;5:j1JSEnPC0cjLYcVIeLfalR6Dcw1LHg+R9x5SaAhVUSDSy2LnZIpNHohAmptg+a7o2ZFd2+5NifOfRbc9fjWj1nIPejygNNYE9Zk5faypkTf+QYTbYpxmL8pE6dgV9+lhw/Cj85kD6FA1af3HkQye/4imuIlsLzpzWvLXteOALLk=;24:pClG27nD/9uf5B+Pb7i09oayJWEWUslQktT97fa730wvy3eeDUZkftbVLdBotZ9l4vfTXiW3VwbPf2aYaBJ3mtvFKLpcCDjC4h9rlznBs6I=;7:8cWQQVMQPJYvY4h96OACyJMP9qkGn4gLD9xap7EhsVje/dlN+8GFz9PtEnN5t6zTIojhK92sHYEXXdR1YH1h6So4We4QeC7dWvvOfeLHnGGMAwMlh0JfmCPnu6vR0NsYkwewhlTKZfq75J5QyNEVC74l8uCUfyukaFBx+Hsz/yvwKYpHBy+sruu7+0a8EiKNIsULgQ5ivggZmUitaEOr5c1dUMRXx/TCnDD8wukemxvt4RxgjdFSvcyl0HNTkrBV
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f03dae9-405f-42dc-f814-08d58d3d1491
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB418;
x-ms-traffictypediagnostic: AM3PR04MB418:
x-microsoft-antispam-prvs: <AM3PR04MB4186F40EB50BBBDB159F66CF5D40@AM3PR04MB418.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB418;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB418;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(39380400002)(346002)(376002)(366004)(13464003)(199004)(189003)(7416002)(86362001)(68736007)(6436002)(26005)(305945005)(186003)(1411001)(7736002)(102836004)(55016002)(33656002)(6246003)(53936002)(74316002)(14454004)(9686003)(39060400002)(229853002)(99286004)(15650500001)(5250100002)(54906003)(25786009)(8936002)(8676002)(6506007)(81166006)(81156014)(93886005)(4326008)(2906002)(316002)(97736004)(53546011)(59450400001)(66066001)(2950100002)(105586002)(6916009)(5660300001)(2900100001)(106356001)(7696005)(3280700002)(76176011)(478600001)(3846002)(3660700001)(6116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB418;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: K92ldVsVDf9Eo1A40fR7GZyVwnh8zUPrPkrqYmZGRBVLb6ywZj33kTRCsQCRoovbMVu1v7+9FFQzmOjDi7XkXQOG3b57zIJUDpddCxozwl73w9HyTVp9E5H6Xgsw+p3lcXt4VsCE60ucD/rfQgzQC8ASNNzRFtHv+jW9LzeXTuSThsDl5qgmXTNFK3ULe2bxwOaABGwApkzyAAqtye9OUeHSmHKSm6hAVqKx67dmM0sRsBfhWNWpAmQsFKnTuV2LoqNEzClohSHQu6z8fRc3OnzqRwq6YEXT2MOnxqLT/Wwe6LDXYtMNhQ0k1pzaV3+mD/V2VMMXyNV5xl9zzdzQoA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f03dae9-405f-42dc-f814-08d58d3d1491
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 01:59:41.9800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB418
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2J208tJ025073

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Sunday, March 18, 2018 8:55 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Robin Gong <yibin.gong@nxp.com>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <kernel@pengutronix.de>; Fabio Estevam
> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Russell King - ARM Linux <linux@armlinux.org.uk>;
> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
> 
> On Sat, Mar 17, 2018 at 11:23 PM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> > I thought the max value here means the capability of regulator itself, like the
> internal
> 
> No it is not.
> 
> Please check Documentation/devicetree/bindings/regulator/regulator.txt:
> 
> "- regulator-max-microvolt: largest voltage consumers may set"
 
OK, so I should change the max value of SW1A according to board design, such
as for MX7D, it is 1.075V for max cpu-freq's voltage, set it to 1.075 in dts?

Also, according to the binding doc, do you think the anatop's vdd_arm and vdd_soc/pu's max
value also need to be adjusted to match the value define in each soc's datasheet? 

Anson.
