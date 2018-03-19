Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755082AbeCSDRs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 23:17:48 -0400
Received: from mail-sn1nam01on0060.outbound.protection.outlook.com ([104.47.32.60]:13660
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754523AbeCSDRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 23:17:45 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <shengjiu.wang@nxp.com>
CC: <Linux-imx@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: imx7d-pinfunc: update sai select input value
Date: Mon, 19 Mar 2018 11:14:41 +0800
Message-ID: <1521429281-23394-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131659030634230158;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(376002)(39860400002)(396003)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(85426001)(36756003)(53936002)(105606002)(356003)(2201001)(48376002)(86362001)(106466001)(50466002)(305945005)(5660300001)(104016004)(2906002)(316002)(68736007)(51416003)(16586007)(110136005)(54906003)(59450400001)(26826003)(498600001)(6636002)(72206003)(6666003)(97736004)(336012)(450100002)(4326008)(47776003)(1857600001)(77096007)(50226002)(8936002)(26005)(8676002)(15650500001)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2767;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD023;1:RtPxL1hEW0idDNuP08rmZc/1lxGvmjK2iHqdZIak+eABJBzOYrq1fA6YcBjAmVQDgvWPAw4s77NoyvWkFXWIoCI4ryoRVxoMsNZ5VRMr9K8+zSvbUv+jzSffhHL+N/pZ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43175110-d8e2-444b-f18e-08d58d47fae3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:MWHPR03MB2767;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2767;3:TnRnnHTKNrxmRWPnd0hil9xQC0ycO5bKLceLMjOcwxgxVj/hbQ11UCR62zykHhG2/zEO3yKqhXfsyyeFO2tix4fCLZ+3Zx4GoStshHbhAb+J5sP1Qn2fmFcqAfICnmXpDHg7olqJYfbU4N4Or7fJptkJLN8iqo/HP6VInEybSmXE0jQLUvw8oHja9wD9ej5ZNv5DvZYPHflh6s85IUxj+zoWu02zEzj9viDARP2jxJ2jYSL1V74WMZmXwi4mteN1B5w9LCoMY+MPKCqk1TZV708G+lZJmPD1xohrsr7uIbwaqwqvNsClL7ZV7OU6YU9sv8SrMib5SWfU8vaiZnkoKgvE2jaQD2GfrNryqVgTrFU=;25:8NaIoLLl/P3ySOTWzNwhrDMMxVM8STasfOXE5ePAiQpd1A9PAu3JknH7bpwYlAb7U90tt15TJDJJzkO5zk7qTN6jqPcqc1lkxmabhX5lC+vwcgLh2tIrmQIGafFhWUaA2QEbjXC3qcPyVc0QmejfFOqjlwbdriA77aajacKwwT3S1eFliPrwGnjBmKDEaMmw8Gl4ydoRY5LuF3ZAYbHNkcRrLXs73WnseBciFmhH7qPs+rbjdtCNin0OnHw4DgfQ6C5AbQtB0Agn3dUUiVor9QSxIkZ/o6lGqVbZ/y3rk8Fgy7mh/AhgnVlW3hBJmsnmiS4LzSjesh71YC7A3/pXEw==
X-MS-TrafficTypeDiagnostic: MWHPR03MB2767:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2767;31:NuuG9qKn8lmAJvrBA3Txjv9elTSGkcmyZ6lr/snGjwl1kwzT2vtsi0LSchG4/g1PYJHZYv1tcSJxRWzg15r/IyAPB/s1roGxpWlFqVptgXew3qxBXCzvNCtp9kSQM1TlaaxiZ9KOGoFEmikttnuZlYRVLxFBcMst0zOVXyj6bk7lgVaqcDHroF2BYwbyUHhD7oLP5WAP+goUul0+e9ttYXs5MJHHsA8yybSR8tpuDQA=;4:AZ1dyrz3vOmCKVTok7YzhuUt68fmiFLDG5qbvTH7jEZbPIr8TbhpkkpX3WurRBltQBF1PEbvsxqU2v7Zq0P5526w8fpJBeLHppqzQIf8wrKlkARQAy7sIV1AXxE6wxRS7foO6LHG40NLWh3khXm6e+PU7abf3NAMdEMASZW4g6iQUppZl0zYNgJ+62htg6g+vrmZE+d+oWhTVML1rKxl2kgvw33y/Stzg8xOOw9GwsiP9ZjCePVw7va44sXI1/gc9J5NG9h0cbqpGf+3I7/GKIKTAsQyYxwQZU13cDGCdaVt0mOotm0xEreWrVy/76lM
X-Microsoft-Antispam-PRVS: <MWHPR03MB2767E045370F112902556EA5F5D40@MWHPR03MB2767.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501300)(52105095)(10201501046)(6055026)(6096035)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123563025)(20161123559100)(20161123556025)(201708071742011);SRVR:MWHPR03MB2767;BCL:0;PCL:0;RULEID:(400006);SRVR:MWHPR03MB2767;
X-Forefront-PRVS: 06167FAD59
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2767;23:IdCQBhTyFdATl0trt+C0f9h3Cdv/VCr8DvXoEXCYk?=
 =?us-ascii?Q?UmUfJ+xko5z5K3ur9XBEWfATtY6h3x5dIOGfZ1OC19gcz6obPpsIetC33Dvq?=
 =?us-ascii?Q?ugYJ1Yk2IQgIq2j9ZGngqGi2xapF6T54oRZJGUqtypHyaIjU/lD35+BcuIIk?=
 =?us-ascii?Q?4sEQV7hrlX9X8kOVDcJJpJnrQ0zAjZuQ2kPVlD6uJimdMGFNxCtOOz4PYho2?=
 =?us-ascii?Q?MfY9owOE8+Y9/xH1pLU/d6eqP5GFdAx3zErWPbnVS1lvP2D/pJAqTMbv8sPo?=
 =?us-ascii?Q?7AxOZZKC9YocKZbvMIhOFicDlJq58yQwxmq64waO/xtLoErm2N3Kfxzqpch5?=
 =?us-ascii?Q?njr2A97Fc58XQxPZnzL6vlxnL/eL8aZa/jFH5pu3pLreD+Hvavh/opzGQdVs?=
 =?us-ascii?Q?bC5rdGA3ORJlCz7EwpqF9/NYvvrz+rAikjVgxe51BTa22TWVDuzi6xM2nUHB?=
 =?us-ascii?Q?LUb0vdrjKYkwxPwd3vsTYXU6zBc/fMjKwtNJ4ap6fKony5fZFzzig7E9/sf3?=
 =?us-ascii?Q?u4/dh+3AkwuJ5f+tdBq3bkMXJxH5sCP5ZaOK6DDjr6TuNvLotXJwxBGJGAP+?=
 =?us-ascii?Q?QiFL52B1dn+XDJlTAithAp/kSYGUnUSFf4O4rj4adYzVZIAGGIsMO/mgjNp9?=
 =?us-ascii?Q?a+M9eRglU2N55bP2wTrB0ITuOGfWTr03qORdfjA4MbnZfNzwkBtQe43mmMOP?=
 =?us-ascii?Q?kIi0wnEup6IGl22Pg68VCyue+q7u2hcN7bjKYHV7URv9RNgPc0G6Iu2mzmrK?=
 =?us-ascii?Q?0Bv2NiTX5IHg/SBWKPxCn4VA/EA+tAXNzGdB2kpnuRTjPseR2PD//52kijbc?=
 =?us-ascii?Q?RDtibmxI5WTxSeAY1xQfQMMMjnt7IWwHHa7pY9NCCK0JUb3TafVVto6AFw8I?=
 =?us-ascii?Q?LPvwKPCTK3Cry2UvBe3d+XYR89OYP5KPnSu0AkGgqwLHAF5EoE5/AyR8Pbh1?=
 =?us-ascii?Q?pnJ+bWaXTub9cUSDM44Zxb4bnWVvRr8++QuY1AaAkldZYNuYlwnKx4wTLSAa?=
 =?us-ascii?Q?CGfhm1dZMqlGUhMR5lkvaOMnpWm/Lti0074vcSekFQqVURZIvHcZmJmIs7cj?=
 =?us-ascii?Q?WRebo37zdc5QpMyGN7m4wNa3NYZ20KjQIVCqxYAFmExv9i8aPIfzQ1LPp/Kn?=
 =?us-ascii?Q?9tXknwJCKEfXecWROeWQVp9dJ6X6GvYHkutfx0OZH2h2U7jSRPxu2Zh/qjo0?=
 =?us-ascii?Q?BcuxNaZRilGdMcmJ3hIODP2L6er7iup/uO9?=
X-Microsoft-Antispam-Message-Info: R/WDz5ekkP1Suns7u88LWLZwn/xaGG2So2LYVkYX0+2MxnF1eGZJkdoISS9fEXCeHXfcz4+VEUCnryJy6KFE195LwFvFXMxPtx4ZDAxpgGnTyzQvvkpMZad91K9bQbBizqanxKyr/7nGFmdmAOl1g6RxwaFADVE3M6wmvuzlxrqNBZ0XQPWghnoUpO4MO5oD
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2767;6:GIMy5XvOTQ6sIdkwzno4Jj/qVJeGfb0ZoKhwiiXAorrCheaCWToRCfVpcPYNbEs+dAW98+A5ERWojZ4lhWrBs3zSUTlIJbxVBhc0ll5rqDRSP5bag8+hC0dBgU8QG0F9uuvjbUq3GxTyt32cNI+gOWfyGZhfb9gokigi/SuIYl71VemAM2/gOTttk5dgDpvBDgUoKxSm44XNkdm0wsqtdoCNUbwktivzNrLvstZ/U4JThgDMYfnQ2lI89B8ZvXCz8nHhH2/tTvBeYu6fhQdpuGEff1/d6CUYT3EZe9vU5jPiTX71FP53Gogx+fRRO0z10d/hrdGHxGQJXARjy2e8wDQ7Q3HbxDp1mX/ixp6EV78=;5:KHqhrac88pV0WsNZCYEo6/gFfwQxD6oAdK2/QMt5lpqFYXI+Kgfc39mwYNyosJmSYrIpbx5pqkvD2THD1Wy3jSiTLSrN/chDXo3Rvfz5oak1v4Gr+eoKEg/k/lW0YTnL40ujWwRw2op4+AtwKhANGJ6Db+hqZbywUkR0OYCRoA4=;24:oc1kg02qtJwiw7BeFbTOhIJFhRngilkVUXWpAFFV5dXZfu/VugFmC42mu77TPv3/6Jx4h/nFZYIN26b9VaHgH+pShyK1TGpvvu5A/ESk4uQ=;7:cC4jOpq7azZA+h7mAWo8ihcGwhTrPXYvLLw42t/bG9oH3mfS6BiPE9y1lZ6mIdI9OD41sABH5UHLTVFGVVI4Ajfsecg1IPlHFtP6YvZTA2r1gIbIw8QjnIVopOoUgvqObS3JtiVHSe28YrC8ydfLXZDoh0KW/8DvfxPsk6basDAR28ZE/4ByHUCC1+noG+AgJYQuqZmODX7zu7ikyUcoodpNPk0nImemnM+R0oIaQbBkq8+Lfk0bA5IzZrSqKa4L
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 03:17:43.2670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43175110-d8e2-444b-f18e-08d58d47fae3
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2767
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update SAI select input daisy chain value according to
Reference Manual.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/imx7d-pinfunc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-pinfunc.h b/arch/arm/boot/dts/imx7d-pinfunc.h
index f2493bc..aa9dbea 100644
--- a/arch/arm/boot/dts/imx7d-pinfunc.h
+++ b/arch/arm/boot/dts/imx7d-pinfunc.h
@@ -592,7 +592,7 @@
 #define MX7D_PAD_UART2_RX_DATA__UART2_DCE_RX                      0x0130 0x03A0 0x06FC 0x0 0x2
 #define MX7D_PAD_UART2_RX_DATA__UART2_DTE_TX                      0x0130 0x03A0 0x0000 0x0 0x0
 #define MX7D_PAD_UART2_RX_DATA__I2C2_SCL                          0x0130 0x03A0 0x05DC 0x1 0x0
-#define MX7D_PAD_UART2_RX_DATA__SAI3_RX_BCLK                      0x0130 0x03A0 0x0000 0x2 0x0
+#define MX7D_PAD_UART2_RX_DATA__SAI3_RX_BCLK                      0x0130 0x03A0 0x06C4 0x2 0x0
 #define MX7D_PAD_UART2_RX_DATA__ECSPI1_SS3                        0x0130 0x03A0 0x0000 0x3 0x0
 #define MX7D_PAD_UART2_RX_DATA__ENET2_1588_EVENT1_IN              0x0130 0x03A0 0x0000 0x4 0x0
 #define MX7D_PAD_UART2_RX_DATA__GPIO4_IO2                         0x0130 0x03A0 0x0000 0x5 0x0
@@ -1112,13 +1112,13 @@
 #define MX7D_PAD_ENET1_RGMII_TD3__GPIO7_IO9                       0x0250 0x04C0 0x0000 0x5 0x0
 #define MX7D_PAD_ENET1_RGMII_TD3__CAAM_RNG_OSC_OBS                0x0250 0x04C0 0x0000 0x7 0x0
 #define MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL           0x0254 0x04C4 0x0000 0x0 0x0
-#define MX7D_PAD_ENET1_RGMII_TX_CTL__SAI1_RX_SYNC                 0x0254 0x04C4 0x0000 0x2 0x0
+#define MX7D_PAD_ENET1_RGMII_TX_CTL__SAI1_RX_SYNC                 0x0254 0x04C4 0x06A4 0x2 0x1
 #define MX7D_PAD_ENET1_RGMII_TX_CTL__GPT2_COMPARE1                0x0254 0x04C4 0x0000 0x3 0x0
 #define MX7D_PAD_ENET1_RGMII_TX_CTL__EPDC_PWR_CTRL2               0x0254 0x04C4 0x0000 0x4 0x0
 #define MX7D_PAD_ENET1_RGMII_TX_CTL__GPIO7_IO10                   0x0254 0x04C4 0x0000 0x5 0x0
 #define MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC                 0x0258 0x04C8 0x0000 0x0 0x0
 #define MX7D_PAD_ENET1_RGMII_TXC__ENET1_TX_ER                     0x0258 0x04C8 0x0000 0x1 0x0
-#define MX7D_PAD_ENET1_RGMII_TXC__SAI1_RX_BCLK                    0x0258 0x04C8 0x0000 0x2 0x0
+#define MX7D_PAD_ENET1_RGMII_TXC__SAI1_RX_BCLK                    0x0258 0x04C8 0x069C 0x2 0x1
 #define MX7D_PAD_ENET1_RGMII_TXC__GPT2_COMPARE2                   0x0258 0x04C8 0x0000 0x3 0x0
 #define MX7D_PAD_ENET1_RGMII_TXC__EPDC_PWR_CTRL3                  0x0258 0x04C8 0x0000 0x4 0x0
 #define MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11                      0x0258 0x04C8 0x0000 0x5 0x0
-- 
2.7.4
