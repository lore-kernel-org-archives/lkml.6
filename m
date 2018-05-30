Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968585AbeE3BAh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 21:00:37 -0400
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:19005
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968219AbeE3BAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 21:00:34 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc: imx: gpcv2: correct PGC offset
Thread-Topic: [PATCH] soc: imx: gpcv2: correct PGC offset
Thread-Index: AQHT9yPfZOIICd3jZkebU2yQtAPkpqRHVlwAgAAeaiA=
Date: Wed, 30 May 2018 01:00:29 +0000
Message-ID: <AM3PR04MB131532FD87FEDB5D85E43B9DF56C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1527580944-10043-1-git-send-email-Anson.Huang@nxp.com>
 <CAHQ1cqF1-zkR_wQgRK1M3Wd+Hvha+St3jT=-Qvn1RM8N88qW8Q@mail.gmail.com>
In-Reply-To: <CAHQ1cqF1-zkR_wQgRK1M3Wd+Hvha+St3jT=-Qvn1RM8N88qW8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB419;7:bA1Bsa4/+3Zc1Smrs1gsasvpASzwLVKkI058d4e07jy/Kl1yYNsqhcW8WZjYxKPKUoHBRECiVwmoUgd8Xdi9QoZ0wj+BGF+kzKc6jVSpX7+zL2mNAX4VsrpVOzGOd1szIjjST2RlHn50IM+tk2kxhxSAi3LTlZ8cvwaWlvNvVsy0A/HUaISnS2iCdU770wcVwgvn6iym54io7k7+GEG/zZW2qNo9DXDu142herageAuSYqWvTSzYStGrIqi8/CZG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB419;
x-ms-traffictypediagnostic: AM3PR04MB419:
x-microsoft-antispam-prvs: <AM3PR04MB41938069E456BFBD82083F4F56C0@AM3PR04MB419.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB419;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB419;
x-forefront-prvs: 0688BF9B46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(396003)(366004)(346002)(13464003)(189003)(199004)(97736004)(9686003)(305945005)(7736002)(68736007)(53936002)(81156014)(2900100001)(81166006)(86362001)(74316002)(55016002)(446003)(14454004)(33656002)(316002)(39060400002)(53546011)(5250100002)(7696005)(6506007)(8936002)(6916009)(76176011)(4326008)(3660700001)(99286004)(26005)(3280700002)(6436002)(6116002)(3846002)(54906003)(44832011)(486006)(106356001)(25786009)(6246003)(478600001)(66066001)(11346002)(476003)(5660300001)(2906002)(8676002)(229853002)(102836004)(186003)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB419;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: XQ+4yGUofcX+yOcfaXr6WeSrrjHbmV4i5hApuPPyjg0bm8w6DUin0yNI4W79eLL8dV8+D9Ox+t9ZZwOkzTl6v6SNyIH1SaZNYEBgjHyfZYvYT+O8aJ4BRPHkOdUULr7Sm2g3HZ6Kf5krNtEk9m595gJlgL65E2jq4sOPYEng90dgnq6w4tynh/kuIslEW8ji
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 973b25e1-7578-4e71-0fac-08d5c5c8bcc4
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973b25e1-7578-4e71-0fac-08d5c5c8bcc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2018 01:00:29.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB419
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4U10xvo006327

Hi, Andrey

Anson Huang
Best Regards!


> -----Original Message-----
> From: Andrey Smirnov [mailto:andrew.smirnov@gmail.com]
> Sent: Wednesday, May 30, 2018 7:11 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> Estevam <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel <linux-arm-kernel@lists.infradead.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] soc: imx: gpcv2: correct PGC offset
> 
> On Tue, May 29, 2018 at 1:02 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > Correct MIPI/PCIe/USB_HSIC's PGC offset based on design RTL, the value
> > on Reference Manual are incorrect.
> >
> 
> Nit: I'd s/the value on/the values in the/ here.
> 
> > The correct offset should be as below:
> >
> > 0x800 ~ 0x83F: PGC for core0 of A7 platform;
> > 0x840 ~ 0x87F: PGC for core1 of A7 platform;
> > 0x880 ~ 0x8BF: PGC for SCU of A7 platform;
> > 0xA00 ~ 0xA3F: PGC for fastmix/megamix;
> > 0xC00 ~ 0xC3F: PGC for MIPI PHY;
> > 0xC40 ~ 0xC7F: PGC for PCIe_PHY;
> > 0xC80 ~ 0xCBF: PGC for USB OTG1 PHY;
> > 0xCC0 ~ 0xCFF: PGC for USB OTG2 PHY;
> > 0xD00 ~ 0xD3F: PGC for USB HSIC PHY;
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/soc/imx/gpcv2.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c index
> > afc7ecc..132c946 100644
> > --- a/drivers/soc/imx/gpcv2.c
> > +++ b/drivers/soc/imx/gpcv2.c
> > @@ -40,9 +40,9 @@
> >  #define GPC_M4_PU_PDN_FLG              0x1bc
> >
> >
> > -#define PGC_MIPI                       4
> > -#define PGC_PCIE                       5
> > -#define PGC_USB_HSIC                   8
> > +#define PGC_MIPI                       16
> > +#define PGC_PCIE                       17
> > +#define PGC_USB_HSIC                   20
> 
> As a suggestion, please add a comment explicitly saying that those values
> might differ from what some version of the RM might specify.
> Explanation in commit message is great, but seeing a note in the code might
> save quite a bit of digging for someone who is reading the code, double
> checking those values and thinking that they might be wrong.
> 
> Other than that:
> 
> Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> 
> Thanks,
> Andrey Smirnov
 
Thanks, I will improve them in V2 patch.

Anson.
