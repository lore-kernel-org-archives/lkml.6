Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754960AbeCVN37 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:29:59 -0400
Received: from mail-ve1eur01on0076.outbound.protection.outlook.com ([104.47.1.76]:56188
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752851AbeCVN3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:29:54 -0400
From: Abel Vesa <abel.vesa@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Anson Huang <anson.huang@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] arm: imx: Correct dram pll type
Thread-Topic: [PATCH 2/4] arm: imx: Correct dram pll type
Thread-Index: AQHTwcP0nAD5z5qd9kS658qZ/hXL/6PcL8CAgAAQbAA=
Date: Thu, 22 Mar 2018 13:29:51 +0000
Message-ID: <20180322132950.lkljwy2w7mobzgp2@fsr-ub1664-175>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
 <1521712529-632-3-git-send-email-abel.vesa@nxp.com>
 <CAOMZO5BVxp7pq44pUp444CqsYcJ5QQFqrgdRyFbaxRi0_d0ssg@mail.gmail.com>
In-Reply-To: <CAOMZO5BVxp7pq44pUp444CqsYcJ5QQFqrgdRyFbaxRi0_d0ssg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com;
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4352;7:7iLeZgaAgrPPofBOUNafjq3JoCV/O93Wc8RJ4nxPn07Gt9NQPok6nRYoeTjerk7TOvHCbYWapJDje4iiVJFxgAqfKgdv1QhHM+MlPRj+e7prygTDEUf2DE8htZQ6BmBEVsJCOQz1RRbgB1JnkTxbZ0kc+tkQmtD3BdBuDxq8iiMhgNp3SMfXNXYfjQLqicM+mgXBiwHHCCXDWcqgFG51/EHDZjcLG8MuhCrdHG1Lt2Hi7xIiGsmPJBUy6lKxpFx8
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4374e1cd-cbd6-40f1-35f7-08d58ff8fdc1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4352;
x-ms-traffictypediagnostic: VI1PR04MB4352:
x-microsoft-antispam-prvs: <VI1PR04MB43523A8CEE4937B4398E4377F6A90@VI1PR04MB4352.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR04MB4352;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4352;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(39380400002)(366004)(376002)(39860400002)(396003)(189003)(199004)(8936002)(102836004)(99286004)(68736007)(26005)(106356001)(2950100002)(105586002)(305945005)(81156014)(6436002)(6506007)(81166006)(66066001)(7736002)(6512007)(2906002)(5660300001)(6916009)(39060400002)(86362001)(53936002)(6246003)(3660700001)(5250100002)(3846002)(14454004)(25786009)(8676002)(33896004)(1076002)(229853002)(9686003)(2900100001)(316002)(76176011)(4326008)(6116002)(1411001)(478600001)(186003)(97736004)(3280700002)(54906003)(6486002)(33716001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4352;H:VI1PR04MB2144.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 0vneMwP2AXs071BkpM6aVWp39sJKyIm+OioHOzD1IcM5RDHCZzB5+1OME7pvsHOcg8k0yOqR1QEbD+aCJzwS+jLiPBEpsXooylf4aBU7Xn8JwOS4l8e9g0SohB88Tp/cFHhPCwUETxI89T8DkKxRlpmQ2ZzAblJdfqOPAmMjApKAFRGS8Yc9kiDUkBRiX5UTAm0QZ+TP4D6iGsdOmtE7yVgLPcJ8imK+qRqFir9z7yiaiOLAZGkgcIsSbhon32uyZj2ICRwe/cUVBOR5pO2JOthfiDFPXlV/6mbDN4Ta3ChDuytFybRiT9NzrMJRWylRsoahwRJol/jWH2Xe4+lT4w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C647CCC9C9B18C458E2BCEDB11497FC6@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4374e1cd-cbd6-40f1-35f7-08d58ff8fdc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 13:29:51.3658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4352
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2MDUBmO024045

Hi Fabio,

On Thu, Mar 22, 2018 at 09:31:03AM -0300, Fabio Estevam wrote:
> 
> This has already been applied in linux-next as commit:
> 
> commit b716aad97eb5 ("clk: imx: imx7d: correct video pll clock tree)

OK. Will create the patchset again without this one.

> 
> Nit: the prefix in the Subject lines of all these patches should not
> be "arm:imx".
> 
> "clk: imx: imx7d" is better suited to reflect the subsystem that thes
> patches touch.

Will change this too.

Which repo/branch should this patchset be created against ?

-- 
