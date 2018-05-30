Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968530AbeE3Bi0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 21:38:26 -0400
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:39328
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965337AbeE3BiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 21:38:25 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
CC: dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Richard Liu <xuegang.liu@nxp.com>
Subject: RE: [PATCH] soc: imx: gpcv2: correct PGC offset
Thread-Topic: [PATCH] soc: imx: gpcv2: correct PGC offset
Thread-Index: AQHT9yPfZOIICd3jZkebU2yQtAPkpqRGvRaAgADBWJA=
Date: Wed, 30 May 2018 01:38:22 +0000
Message-ID: <AM3PR04MB1315EFC9F5CA9DBD7CBC54B5F56C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1527580944-10043-1-git-send-email-Anson.Huang@nxp.com>
 <0e0690c89b24b4b028e4a0dab63334af4b37fdd3.camel@nxp.com>
In-Reply-To: <0e0690c89b24b4b028e4a0dab63334af4b37fdd3.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1427;7:3uqbG/p+PExQKwp9tdDPbv0nECNDGqhLpYUmIFMAkLgkWPUM5KT/v+S0IP8g1sLU0FvEfp0mz1TWYKoKktaupjwuU0dCL5j54NF71Eg32SM52XrlVy0A7pYzanvgApmNtY61oGZoY2f5NAUEKsKXOY1eQl/osHurINm7JU4fFctEjvzB0P/SbwWjicCerMbWNicoCZ0sG370mIFe/Qs0r01/HnhQbzOJ2mRl60LKLjWTfqkaic9UMeI9xYCZ8PAp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1427;
x-ms-traffictypediagnostic: AM3PR04MB1427:
x-microsoft-antispam-prvs: <AM3PR04MB142724006215EBB0DB8EECB8F56C0@AM3PR04MB1427.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1427;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1427;
x-forefront-prvs: 0688BF9B46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(13464003)(199004)(189003)(76176011)(5660300001)(97736004)(66066001)(99286004)(575784001)(86362001)(110136005)(305945005)(7696005)(478600001)(7736002)(229853002)(6436002)(54906003)(105586002)(55016002)(59450400001)(14454004)(11346002)(102836004)(81166006)(81156014)(4326008)(53546011)(316002)(8676002)(446003)(26005)(74316002)(5250100002)(44832011)(106356001)(9686003)(53936002)(2900100001)(476003)(486006)(3846002)(6116002)(25786009)(3660700001)(6246003)(39060400002)(2501003)(2906002)(68736007)(33656002)(6506007)(3280700002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1427;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Zg/0BFJkCVO/hsWYo2MwkoiXSc/ZZhHsHRatn1EYRW5RmtgN3P8vP0fXTqF3P7VuTZ5Y9WrVCRC1jv38Uh2zXR1YRcpGWcdW1if+xnXK13eRirBM4st5sjnBtpw2o0z2iGav0MSYiDZcMT5XMEp7baZUTOd1h98Flw9odOi0N1DPeZh+QnQy6dLT6Jrr6eKy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 55aefd20-cd8f-487a-d600-08d5c5ce0795
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55aefd20-cd8f-487a-d600-08d5c5ce0795
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2018 01:38:22.3050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1427
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4U1cWZQ006431

Hi, Leonard

Anson Huang
Best Regards!


> -----Original Message-----
> From: Leonard Crestez
> Sent: Tuesday, May 29, 2018 10:03 PM
> To: Anson Huang <anson.huang@nxp.com>; shawnguo@kernel.org; Andrey
> Smirnov <andrew.smirnov@gmail.com>
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>; Abel Vesa
> <abel.vesa@nxp.com>; Richard Liu <xuegang.liu@nxp.com>
> Subject: Re: [PATCH] soc: imx: gpcv2: correct PGC offset
> 
> On Tue, 2018-05-29 at 16:02 +0800, Anson Huang wrote:
> > Correct MIPI/PCIe/USB_HSIC's PGC offset based on design RTL, the value
> > on Reference Manual are incorrect.
> >
> > The correct offset should be as below:
> >
> > -#define PGC_MIPI			4
> > -#define PGC_PCIE			5
> > -#define PGC_USB_HSIC			8
> > +#define PGC_MIPI			16
> > +#define PGC_PCIE			17
> > +#define PGC_USB_HSIC			20
> >  #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
> >  #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
> 
> This gpcv2 driver is currently only used for PCI, it probably only works because
> domains happen to be turned on by default?
 
I think so.

> 
> On imx7d upstream platform suspend is not yet supported but even doing
> device-level suspend causes a hang on resume somewhere in PCI on first read.
> This patch fixes that immediate hang.

I just added the imx7d platform suspend/resume support using psci in u-boot, patches
are sent out for review. 

I did notice PCI resume cause system hang, the root cause is PCI controller registers
can NOT be accessed after resume, and the PCI PHY PLL is NOT locked when issue happen,
the PCI driver should implement suspend/resume and redo the init flow after resume, since
its power VDD1P0D are OFF after suspend.

I saw you sent out patch to fix it, thanks.

Anson.

> 
> After suspend/resume lspci is broken (device doesn't properly resume), that
> probably requires more imx pci patches and unrelated to pgc.
> 
> --
> Regards,
> Leonard
