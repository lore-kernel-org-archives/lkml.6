Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeEVDaG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:30:06 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:24873
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751932AbeEVD3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:29:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, michael@amarulasolutions.com,
        matteo.lisi@engicam.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: imx6ul: add GPIO clocks
Date: Tue, 22 May 2018 11:26:00 +0800
Message-Id: <1526959560-6014-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
References: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:JqWNUgUedb71oLW4/gc3UrVnyYOYfGtfSopVLeVdHBfERuXJUXTYwbZv4il3fRaBwdazj9oW50bEymamHibzDzoTvAxXh73I6BwdZKyfHyLH0UaP/E0TEbtRpTW70Jb9hA6cGHAVFaRm4CDC6N1pcQGq8HgQvOAfSoXH1mrPrun9b6dpAN+bYnoUijgoFYpVa2GM/JPIDsIyKkBgLfP18qIrxF95sLwWVD2YUuieQNBrhwXY87rOlySxCGh++rgk;25:Y3fle5A2r/5I0lk5Im2oytlJfUNRookrxZXMQ0NOscebsGzccjefZ6xLMSTj16FSD0Eyaqgs/y2m3w0GeC9DCIhaIQ/Hfy7Xr4NHo/n8yet5nUqr99sy8ouf9yEBHfJOiX7556XSSKQ4XRoHuDsnGTulKWMYdgjk0/hOT/XXClm7b8NqE/3bNGy0eXj+6LNdXqFApDSFdVqKXfEPt95E5OtnvJ7KC5Zr1VOTrWszlPwL+RbiNLvRnE4dQ2ttjLN15pmWuGdDgIqkVnBg2Xj0SGy7lA30xpAh0CwQiIB3Km6E9OsC7166E7y/dkmpxRaiXoYwPwJZF8cb1aOfJcy8dA==;31:gpTOt7EWLc3KOTf+i3/MQRildDe/cvzln1RKjplQzVyRoKHMuKf612MER/7FR9Digelp4t9vBlvAeXq8udkPgYPvhfPtpWZdGil2v6I4OD9JBkLke20Qt4Lq5KgdUx+5/Smq4bswO+x3+kTlsafMrkHgAHkamPmTRwmWvDQbU78+nwCLilG9YsvcsHa5kdoZsL7RRr5Bttr9m5xfJ2F8CYfcqeWSJmOWnWD7Msh+E5g=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:rH/PHQ5Ythy7ELm5BX9tyQV9wj2XQVnOT5MJ1O9uAJ+GOzgshqw8+jvbII8zSEhQLJ1pukTysids/YDC5Xn7PjUdp2qeiwR7ijTx/1tMgKCg+ZZXsRi+4pc29mbpXRm8JvcFY8TUI4fAnhHtk8UDfcNHpdIxb8pdTiB3ga1km0OT+VoBjDt5i7uQmxUq39h0HqGCzfc9aqO8Bktip8Bn/9O/kjZUWS9YTMvoEPzGeQzooLmxo4hz8LYGz5Vvpo8FANVWJOgCSIePLWPocmfv2TDdgCdUq1xCEKOEDbq1HpW5XbzpIZVxCK8NumjgOzMRk8lZAVNcTnq1aFL1IR327VC3PtZqaL/ymbwpU/wIBUfKXZz34WnRtUS6Yj5BV92/09r7fkZN4cgzPvjw2txLPqpGH8W+9HWMSZqu2HgfrHFefcMjmEzzdqPOO58cCEI2gwqbt1ylIdLn693KldFYjwhqICirUtZlLdI4gY6PTHC9tFPr5lC1o/64O7BYO6oX;4:Mq0wuRSdPVRp0r2Gi7+no8rNXvRObQvMRAlgZmeGiXfo3aRtE070NzNb7LkiiqqZ+TDzDTxFJpvT385pRA8xcEOOKTwLHZ5GxiZFbT74wPnl0Pscqsu0txBx1OrIV33O5gjpoqdkRH1Y6wLwOoyDPTG33fRLLfouqvtqgyhdOf2iE7mY4yu6RijxIIR24hLmqEZx2MsLU2IvXZOVWoDNcE7YVMXeiAHhWZLKJg/yQ3ctzy6qRzf78+Rw/v8Ssw54I7mXmcJqVBnfIvmz8qoWezEavpCnYdxMO3wzgk4L1W1hKJyzSosQLUMeqUqx7hjb
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315146D9B8ACE4990828562F5940@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(366004)(346002)(396003)(189003)(199004)(316002)(16586007)(6486002)(68736007)(106356001)(52116002)(4326008)(6666003)(81156014)(25786009)(81166006)(47776003)(3846002)(86362001)(8936002)(305945005)(50226002)(6512007)(105586002)(6116002)(26005)(2906002)(48376002)(5660300001)(36756003)(386003)(53936002)(7416002)(50466002)(7736002)(16526019)(97736004)(486006)(2616005)(956004)(8676002)(76176011)(6506007)(446003)(11346002)(476003)(51416003)(66066001)(186003)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:K7FdceygarfH+0v1i1Q8gkeCQwAP9wnqY8+TUNZ9O?=
 =?us-ascii?Q?i4q8JC2aPWdl3sY9mClP5tL3J/n83iJHyWerK3F8F4ty868YLLaBGN+ebiil?=
 =?us-ascii?Q?AcMMTN1AbQYStWlWLHEwnbEetC9D3vr9qUbqPCCYN0bd1/cF9aOyTXKPERqw?=
 =?us-ascii?Q?CE6epIgaXtI6++nEiR4SarZ3rUCfQQg4ofPqYTP2mIKRobFuHV3m6unk72Z4?=
 =?us-ascii?Q?8Df2z7A1I7fyYLbHky6mgmfYeD3UcbzWPy78PGoezktgOAw78szlFCyF6i8o?=
 =?us-ascii?Q?IvNobrpcY5RVia0GhCf/gGzqo7CNlO4jXA/BPki6zD96tmC5ydY5UAHm5bk3?=
 =?us-ascii?Q?MHzbTjZ6DqXg5T3d2YIocWXlT+PG05q5R5lrthzzofgapqnf/R84cu/wRKSv?=
 =?us-ascii?Q?sQvJ6rcdLK4/CV1+W63t8y/fTlnLjGQD5EX5gAKDxlSU3rLczjNYYppaHTN7?=
 =?us-ascii?Q?wnP6CC8S8H/w5fomoWHpBO+ozNdklN4d0bJWKgBXcCXgf6qYAotiMEf+0T9Z?=
 =?us-ascii?Q?nng8hdYpS3SAojhmN6JBf3wzS36OpH3mf/ErIqrTLIyQRAEiFaSImTlSohpa?=
 =?us-ascii?Q?53vzbzJb9Tp4/U+lGiuhn2b/x97lHSeOMaXWU8xnmVMTF5C65JaD17Gvmwye?=
 =?us-ascii?Q?R5vnGQT6S9aCGhJnaTZKbFhSLlxe1Ahlwnk2bzwv3ViftJ60BYZiuk5MQjjz?=
 =?us-ascii?Q?T5qi7iNVgDiZfo+u7R+b5Bu/UgoSj4wqkeg7mJOqD/Mcuv61oDnC0qaEAPXI?=
 =?us-ascii?Q?4ATPxPiMmC6Z883ilgQ3GpVLg3KW1Nz1iBVajffjiQk4byVCcconXDzGUUJH?=
 =?us-ascii?Q?nJsxWFy3/sbPevhXREXH4ixyzfx8zOCqL6HiUjekWhVF7eWL/AL89FOEkopa?=
 =?us-ascii?Q?Cm0wyQT6xKnpsVYrIyC7bnXrYYYa9RoDrY0Zf+ihGJLfkKLcQDvmGcl7FVQh?=
 =?us-ascii?Q?DIq1LGaKtUHQx1VT60TGY+9smdDf5fkzBRgPzT18ivGCgIxIjoVJtqraleqs?=
 =?us-ascii?Q?Pp6mQSOZ1g32IVTLxLe6fFhAGEKq4o47Ni9qdpITa02aGCB7uZ5PeJKtJTRN?=
 =?us-ascii?Q?nir6AHtY08qRYYqDmUTpcYRzjo/W9OF14WnPqXE/f8pVBSGOWcyZ15roePr9?=
 =?us-ascii?Q?rGLH+qh2vo+OCOcJulC8oZTn0W7DZwgXZRt1Ux4OwqrazriJ6k29QH1qWHGa?=
 =?us-ascii?Q?gVAcQRSqjIYvqTbfF20t2zJUUh94no2VskD?=
X-Microsoft-Antispam-Message-Info: shlznfGW7IvQJXVoY8ZJqLwYFNk5mm1d67Bq7QK7RZg3/3WhkkoyzWiFr22JLBZfZVvRWw7/uylIUEjdLKeDoE33DYVN3n14Gzm/UhVRxIINZr9QOiJJce6/KwhNKTIWvt+e7c0a8/Dc0EcN5T+uVvPJSr651L9nSmuheH153j5SQucA8gnWkoZo7jYhuBpR
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:jp4TicZP7BtHrE5cIJi4bpDp4Z9Nwvm3EHUhIRE+Pm4SVNvhEvKUE3dHz3mJh0Yy/eIWPebNr0yI0jacnajRh60GspJpBb/z6dqkQ+xeFDb+f9WFhLezOt2qsS75+LcD1hCN8cWSPQPZp175eZIkqp8XihoSLLi4v/u69OCNNTJ9HD2il3PRwQRFDMMQtZiwtQCM4TFdiY4nTLN1/WzKCWC9+X9KLRtQL4/mnoTxNBZ31rxFijeQwB2SASIsqVQfIUGbyRBerA1Glbargp0bP/TdgRKzVYWYlQkzeod4VFbp6sx/RFMDK4mPJwz0E7NQgBnxlzH+3bA3DJQYRpy7fotYzfNUBYMPkkzP4lV1CPujyTl4TtDj5PGluY6tx07ig45nzHkA69WzJKYRe9DPJyMVPdIMMnlIwis/ZM7/ZilflXDMb9AATSnYEO+FxOJO410wWO14VxHv+rtxi8skxA==;5:ZMrQ2g/M+nTdJrsm+hE1po3X6eyv2wx2JEB5H0m2ebnlLh2bgxLkbC1GFJebaKRBcAcGVwMrtenIT7yh+BktCA45iGxXn9n5A/lAH8h9azvf1fYpCoq1ABZjCvyrtOxluzNN7f7JMS6dImuegN+vg1+5MsliaSIJl/jTgPHqp0w=;24:lggnT+WmFwgrVERCK3yt4XTMTZsU2FZmsMwd6m23AXF+dOLqGylejoiJ96rmNk8tyyOYpgjKQ7gvzFo/NTDri2vMolnsK55eDDIWnSP5RyQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:5a3vFYC2NPh7yAAwwvh1p9TgygvyVcPubvOpj1vWaSWC3/3K3CD823rCr8MzRcuWEtXmS3/1uUptSR6oJPyw7VP/fWAQEiD86uofKGLTFGkQY1L4rJXZe9ggKojozvl7UtdNmehPv/DvYMHgYYVqrkcTAgh/lCZ/8tFonUQlsUr5GWU9YLdJxdxahMwwXiP8acXloO4/QErZHKJoan2AY4LicrihgzdyUifM2NYgasFU6ryWQs/Q3QgKpk2RJNHe
X-MS-Office365-Filtering-Correlation-Id: 6f36eccf-3682-467d-aef6-08d5bf94452c
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 03:29:43.4417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f36eccf-3682-467d-aef6-08d5bf94452c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6UL has GPIO clock gates in CCM CCGR, add
clock property for GPIO driver to make sure all
GPIO banks work as expected.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 1241972..405e068 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -437,6 +437,7 @@
 				reg = <0x0209c000 0x4000>;
 				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO1>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -450,6 +451,7 @@
 				reg = <0x020a0000 0x4000>;
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO2>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -462,6 +464,7 @@
 				reg = <0x020a4000 0x4000>;
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO3>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -474,6 +477,7 @@
 				reg = <0x020a8000 0x4000>;
 				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO4>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -486,6 +490,7 @@
 				reg = <0x020ac000 0x4000>;
 				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO5>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-- 
2.7.4
