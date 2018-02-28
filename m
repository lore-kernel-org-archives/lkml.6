Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964857AbeB1XQN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:16:13 -0500
Received: from mail-eopbgr00073.outbound.protection.outlook.com ([40.107.0.73]:41139
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935525AbeB1XQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:16:10 -0500
From: Anson Huang <anson.huang@nxp.com>
To: Leonard Crestez <leonard.crestez@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC: dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Subject: RE: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
Thread-Topic: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
Thread-Index: AQHTrUaBbjGKNqDEgkmaGwseKeSN56O6F7eAgABg+NA=
Date: Wed, 28 Feb 2018 23:16:07 +0000
Message-ID: <AM3PR04MB131547CE6052FAA9CC07CCADF5C70@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1519459369-29083-1-git-send-email-Anson.Huang@nxp.com>
         <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
 <1519838731.16494.8.camel@nxp.com>
In-Reply-To: <1519838731.16494.8.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.114.77.231]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB274;7:D5TCKP0rU1FO48lQZJpbV5dI9FXjGAd3kNP7umP0ZZNfRgOkNzFS+LgjVYx5v2bsvpEZYevZcX0GCeV37GfsGlJZMi39H4UOtzU6qS64BqcepNOr+hy/tMLFRlVkZoTYJ4BcEaUukL2LiPHve9sUxTthUbCdpq7oDQh5XKGAZVE6xz2tAdjUyCJLnabhJLh5+3KfrnHFVDetuN2Ip3fQ2K0dlv5Y0MASNrF2AIlNDjp6AY9yETu/CycLqE8tDU6N
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 750fa30a-8d61-4338-f59c-08d57f013f4e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB274;
x-ms-traffictypediagnostic: AM3PR04MB274:
x-microsoft-antispam-prvs: <AM3PR04MB274C0530933C063366025A9F5C70@AM3PR04MB274.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501221)(52105095)(10201501046)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:AM3PR04MB274;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB274;
x-forefront-prvs: 0597911EE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(396003)(376002)(39380400002)(199004)(189003)(13464003)(377424004)(2906002)(6116002)(39060400002)(68736007)(3846002)(59450400001)(106356001)(3660700001)(5660300001)(66066001)(2950100002)(76176011)(229853002)(316002)(86362001)(105586002)(81166006)(2201001)(478600001)(14454004)(81156014)(8676002)(53546011)(26005)(53936002)(33656002)(97736004)(55016002)(2900100001)(8936002)(3280700002)(6246003)(4326008)(6436002)(9686003)(2501003)(6506007)(305945005)(54906003)(5250100002)(7416002)(110136005)(7736002)(102836004)(74316002)(6346003)(7696005)(25786009)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB274;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-microsoft-antispam-message-info: jUchC62+5yzUprVcx2RxlKkwDKfXm1pUdKW6u2GQP87hcr8DFB5jOynqHPafBOi7cssFhliv9yc+U/qZLu1RzCZQuSO2NQnn/K+dK2Xg2nRu13vJjl0S7y+PZ39KJ8Hg2OpGa3GKC24OzAtZ0miHrzObyGNy4+y09WK2sjwrY7s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750fa30a-8d61-4338-f59c-08d57f013f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2018 23:16:07.5689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB274
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1SNGKme031157



Anson Huang
Best Regards!


> -----Original Message-----
> From: Leonard Crestez [mailto:leonard.crestez@nxp.com]
> Sent: Thursday, March 1, 2018 1:26 AM
> To: Anson Huang <anson.huang@nxp.com>; rui.zhang@intel.com;
> edubezval@gmail.com; shawnguo@kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-pm@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; robh+dt@kernel.org; Mark Rutland
> <mark.rutland@arm.com>; Fabio Estevam <fabio.estevam@nxp.com>;
> linux@armlinux.org.uk; kernel@pengutronix.de; Lothar Waßmann
> <LW@KARO-electronics.de>
> Subject: Re: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
> 
> On Sat, 2018-02-24 at 16:02 +0800, Anson Huang wrote:
> > This patch adds i.MX7 thermal sensor support, most of the i.MX7
> > thermal sensor functions are same with
> > i.MX6 except the registers offset/layout, so we move those registers
> > offset/layout definitions to soc data structure.
> >
> > i.MX7 uses single calibration data @25C, the calibration data is
> > located at OCOTP offset 0x4F0, bit[17:9], the formula is as below:
> >
> > Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> 
> On imx7d (also 6sx and 6ul) OCOTP read will hang silently if the ocotp clk is not
> enabled. For example this can happen if imx_thermal is built as a module or
> probes after unused clocks are disabled.
> 
> This driver has support for reading ocotp values through the ocotp nvmem
> driver (which handles clks properly). Since imx7d is a new compatible string for
> upstream maybe you could just make new-style bindings mandatory and drop
> the changes to imx_init_from_tempmon_data?
> 
> See commit 2067b757e972 ("ARM: dts: imx6ul: Add imx6ul-tempmon")


It makes sense, I sent out V5 to drop the direct OCOTP register access support, all OCOTP reading will
Be through ocotp nvmem driver on i.MX7D.

Anson.

> 
> --
> Regards,
> Leonard
