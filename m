Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbeCNKpX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:45:23 -0400
Received: from mail-sn1nam02on0041.outbound.protection.outlook.com ([104.47.36.41]:55830
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750855AbeCNKpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:45:21 -0400
Authentication-Results: spf=softfail (sender IP is 149.199.60.100)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <nagasureshkumarrelli@gmail.com>
To: <boris.brezillon@bootlin.com>, <rogerq@ti.com>, <lee.jones@linaro.org>,
        <alexandre.belloni@free-electrons.com>, <nicolas.ferre@microchip.com>,
        <ladis@linux-mips.org>, <ada@thorsis.com>
CC: <linux-kernel@vger.kernel.org>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: [LINUX PATCH v8 1/2] Devicetree: Add pl353 smc controller devicetree binding information
Date: Wed, 14 Mar 2018 16:14:16 +0530
Message-ID: <1521024256-30423-1-git-send-email-nagasureshkumarrelli@gmail.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--11.053-7.0-31-1
X-imss-scan-details: No--11.053-7.0-31-1;No--11.053-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131654979189218303;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(396003)(346002)(2980300002)(189003)(199004)(82202002)(86152003)(73392003)(106466001)(76482006)(87572001)(81166006)(81156014)(55446002)(316002)(63266004)(83322999)(51416003)(4326008)(8936002)(54906003)(110136005)(16586007)(8676002)(6666003)(336012)(50226002)(107886003)(36756003)(48376002)(86362001)(2876002)(9786002)(2201001)(77096007)(50466002)(26005)(2906002)(498600001)(5660300001)(105596002)(305945005)(61266001)(47776003)(356003)(73972006)(107986001)(5001870100001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB327;H:xsj-pvapsmtpgw02;FPR:;SPF:SoftFail;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT003;1:dZvn6YOo9hYaJAGKktMC9lbVbEC0LnRLy/J0QdXeP4glcxIcd88/YPfNloUPPtx5Divo4p+cPH2BX0NQjRKylgNKzTLP+sx/LCavSi7tXLVB6NjYMFZbHjEst6lWxWrH
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 514798b0-1ad7-4ec6-9283-08d58998ade9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BLUPR02MB327;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB327;3:LXSw2rRobSeFKnMGF3tJNc2hTKH1aGPtssFoYwe0k+JkR2YLG8VuCB2V1q2IwbsBHOKSfw4Q+VSzHzUzPG5wo9nwupdvgzibZDL60qBL4jj9kRx1PnWpKew2h7Zy6wwD7nI0RGrJtB4dDJlSQZ49gd5gyDlGAoqmRcEyQxDCk242wbl1dycKPEOEwRRMBzUV+K2V2wc6vPFS2J8UaIzC0GsmoWJmQBidh8blZRil0thdQrrQmlTfZsI4pNQ3eaIePPWqYljFPftci2BP/6RC28UcCqPm9uXeSo0PexvjXuIqUxOOj+41mg/YhQ8aKLwEZ/LLEtmQAU4NHWsSslKuXPvn8kpdXOp8yH1YBncQp80=;25:ETdWrP3Sr1aQDdb+ScRVWWYGLyFmn8cMqhdWIFnMysoHmdld09Zw4Lvxrhr8XfTGnhfWFOLjvqaLmxkcd58pBtV5EiTCDM6FnZ/TZsi2lu7B2G1l5fddIj6FyJsnS8juywlOI3aZOJitersGJnwY+BSMagROPfX7rnK6Hg68kqof/lEf2UdTYtnV3LDlNIg9KzK2zWJOoy8lfP3p+Zdd4g7v20BqL3mbfvygToYW41afgKtk2zbj9EaH/ZQ+pd/z00w6dHhOYXAOfjnnKD/Ak1B1BM8dPQsF1TllI6g8E4LmiXlFFbanE0k7HPIEiepkosE9u/oALEEbp0Fi72gAIw==
X-MS-TrafficTypeDiagnostic: BLUPR02MB327:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB327;31:pHgU3a12ZGJWPPygGOwQIam+RJNZYjh7eAh2uCO8WGmJbFiCVGgNVI0MvEPSTRBfF9qcJmpZgz1GJ4gK0XpN1lwwXLTkLi9omXgdQUdve470wzdt+0YmFdtJYxYQUzrh/VmkkG/ssrU/7HFzGaM0Pw4Ae0K4BboW04ug0Hoj62hRALOGztCQV0eLD6KWQ8bDxgid+rJnBY5IoqdbaXTce8RoIAsG0NeN1naDIzVlqBM=;4:APbSQGVBg7ToIkoeJgdd4xLl6CsZdYZXlwwrOnMCzsv1QD/4KcfSsNjNH8uMU7LEHcMAooBBhZwPMwHDIvQsaEla/m8BMNXSv2KrGX+uChjh2Fy1+5UvRzEYsxrpkGw2n0RMs5E8PnZGg+0wTxKfX1y/0hAp2zAhRLh5hsiRzfINlKDq6Ai0jKk6JPkT7nES/eZ1nn9C6t7/Xtzp/ndzf9CoptQ+fj14ueakSQUX2Bhjt4S699lg3BNPO8Hmui1Uaa5O9FG2trdRIUcmU6pLQgrL8t8b/zc75D+2e35ZAbER1Zev2fEzThZ9QGzQLyXV
X-Microsoft-Antispam-PRVS: <BLUPR02MB327694E092B19A653ABC878C6D10@BLUPR02MB327.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(6055026)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123563025)(20161123561025)(20161123565025)(20161123556025)(201708071742011);SRVR:BLUPR02MB327;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR02MB327;
X-Forefront-PRVS: 0611A21987
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB327;23:yEx9VaISMPvwlS7Mj6BExkouKoUBGhsQcNcfP3LDNl?=
 =?us-ascii?Q?yCmJGUIzR3HxWUOn9iIT8eNObVUi+8zUd0pBS9dxux4L6XY5RthqqrxLD+ei?=
 =?us-ascii?Q?ofBvPYP5+4IjRlf/0GGumU4/HR5dAHATWTtH4VI9Msky96Es6H54N4tHsWJ+?=
 =?us-ascii?Q?fMOEBfPo22qB0iYYNCB+c45LqQMUiRGm/tRruxXi8TXepTQqKuTjzWcJb76C?=
 =?us-ascii?Q?Apj7eCH+QYUlEkPKl437QyOR+MPVqVgDoRbLWRo1I0UcC8aXpxQ57j3Wyn6n?=
 =?us-ascii?Q?fKkwCPSPSphaoyKgBrB69WvI59R7CV6nqLQIZNhgiq36OCPHT8YqcTMYQpJ7?=
 =?us-ascii?Q?0buu3GtMPC4qdKYpy7Np75OYQUEwD9gvGnXQQTVk5YPO3ghoa0lWKpPxGRcM?=
 =?us-ascii?Q?xp41IwlQb02TYhnjtdg+A371YHFGBl7qKsSfW3B7EAdJcB5Sz64wnxo1rhQO?=
 =?us-ascii?Q?oqpH+POLwlLLt3/BxCPa1sp2XBP0nJPspydr0Rt4gt1mhss2BaBMU7JFaKVO?=
 =?us-ascii?Q?E8GJRcnHUMSBegOfzL4CCRUtVlcYOOwcCLl4u9IWk9YBv3GSL/5GwaCmBAbd?=
 =?us-ascii?Q?zZLO53ddVqfM4bNc0D4f4przhu4ctiFFBz2BWr5mKGBj+v/crUdw4hdVvCil?=
 =?us-ascii?Q?2ub6GluWDdkr0w+wM9iUnAuE8g/DiptU2Sf9vTaKkDGlvhiTJpDqvAuK9y8B?=
 =?us-ascii?Q?xuviJ2cFFN60Sfkx70bl5ja0nzz9YTSXnxtJ1MA2WWWDZeXO9RQXvGzMJN2V?=
 =?us-ascii?Q?Z5TpC8+kIiP+FYihr+1Sdd9Zl4UD7tDN15gyGmu7SiDTbH5D1fU7Oh5XZIp3?=
 =?us-ascii?Q?9GTedQYck6nnoG5z8rxf8Dh1cvaE+wD/ab3DT3RI+/pzf6aeppDVczRvEOok?=
 =?us-ascii?Q?VTKIa148vqz1mfc4sjqzznl529wQvwKYgUYwwuhj30QctpkNSXrrhWbbcTTM?=
 =?us-ascii?Q?4zvW9JArDPNIl6q0KRTWb2bxHLrnckA/hwo8X74NrG5eSKWKxM6yba37dfEd?=
 =?us-ascii?Q?uv4zh49/BuoxUpEfPBi9mUOC9LFOtcZEju7oTqQVZUnMPRJ/K7nZhsIgrHNY?=
 =?us-ascii?Q?1aKUQEDwcxJbLFV/fqQif0JETwkmvTmwKPqwD9E7vBvYCfndMETn8mzTDPaA?=
 =?us-ascii?Q?FXK3UymnJGNDXljFjXVUZQK/lIFa5GTvfSHHUHKqTR9i1p1rSvm/oFu+ORJ/?=
 =?us-ascii?Q?AJ2GQB+sz/STWI8/ttjnCuYDNvafgCrDle?=
X-Microsoft-Antispam-Message-Info: ia+hjGhTO5iJ/AX+KPX2Cq//GuLzszy+AX8yjqY9PhvbHWkwtmImaN7axLrnhE/y71d09lpEuVuPW23V4dXUHOOLhXlsUKj5QmERBDE7uothehZh70Msgcz6ZO6fq+5Z/TEssHItkHYcSOQSacDSrc5cDtpJYaNKshPUOS8cfXKzl+c3RD650juQpezlFrO9
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB327;6:DZUDfP9diuqps0tqlDWH/qMSigV7LVLPH2jXZFm1KGjtTNjv3h2uZh3efw0j8KaNAw3gVf/6qmPqXkxXtYAh1w+bst+KLcj/BV11jHqgB90Mbp8UBCNP1ju5sRtSN2sAxFlBmkgfwEYV1C4Y1AIbOQNx3P57LG/MjPpFe/oIuOHqKyYOUDk6aDs8olTTloVkftDohSe127onY59tJTu86s5q8d43fe0yDEKir6RMwQaSs9VTi+Dr7EyTvLrwjIjCesPYDjfy1jSzonqbneVaHTX/NBH8TAh21JCmLqLUJVvhFAPmJnPQXj19GNbjM5wOwYgwNdS1PJ7Fo/00hnSAgRKKI+chS/fJCnAkh5sgWY8=;5:w3Z64g8ySaFXXxJjE4flaJ7wJ7di/WF5T5eJpWiaXL3abj7OZY9cRw3RXpTN5QF3R1PXMDitkbICDrScMvM3CWxwS6VxOypiUsm29VeCPUpUORcXDqJbWWunGs0JeG43CajuLIYpO5u16nVsyERCtf+OL76IPL5SPm+yskxuukI=;24:hK37D9VGo/dd1r5fC6P9wmmWlL+twshfq3ZZfCDFtF89O2ENNwaq70MemdfArm9Ku1i3y+Mkg2iDsuER1Y3VQAnVIi47YWPxYujHFKs873o=;7:x9URVsNuqRSnv7JT2S2giRsE+P4dX7zPlqr9q32Nv5EQzs89+Hw1zfZAtAif5ucnB7lTW9gUeRe6Iaskx6Iem5ybO3XdHx0eV9hOIPiPLTM//JLHh0vKTWv8Ddzh66LFInmoxigXIkTODd+gxqIak2Z0roccTj3y7txb7tTLO9lRxcu97MLfN0ixbYCurVClEXXZLga7LWY5/zkd7fZv7OAKu5B1OTLYxc7+aUDICrQfjc0a/L9xYtUB9D+5RqZW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 10:45:18.6561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 514798b0-1ad7-4ec6-9283-08d58998ade9
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB327
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naga Sureshkumar Relli <nagasure@xilinx.com>

Add pl353 static memory controller devicetree binding information.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
---
Changes in v8:
 - None
Changes in v7:
- Corrected clocks description
- prefixed '#' for address and size cells 
Changes in v6:
 - None
Changes in v5:
 - Removed timing properties
Changes in v4:
 - none
Changes in v3:
 - none
Changes in v2:
 - modified timing binding info as per onfi timing parameters
 - add suffix nano second as timing unit
 - modified the clock names as per the IP spec
---
 .../bindings/memory-controllers/pl353-smc.txt      | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
new file mode 100644
index 0000000..551e66b
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
@@ -0,0 +1,53 @@
+Device tree bindings for ARM PL353 static memory controller
+
+PL353 static memory controller supports two kinds of memory
+interfaces.i.e NAND and SRAM/NOR interfaces.
+The actual devices are instantiated from the child nodes of pl353 smc node.
+
+Required properties:
+- compatible		: Should be "arm,pl353-smc-r2p1"
+- reg			: Controller registers map and length.
+- clock-names		: List of input clock names - "ref_clk", "aper_clk"
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+- address-cells		: Address cells, must be 1.
+- size-cells		: Size cells. Must be 1.
+
+Child nodes:
+ For NAND the "arm,pl353-nand-r2p1" and for NOR the "cfi-flash" drivers are
+supported as child nodes.
+
+Mandatory timing properties for child nodes:
+- arm,nand-cycle-t0	: Read cycle time(t_rc).
+- arm,nand-cycle-t1	: Write cycle time(t_wc).
+- arm,nand-cycle-t2	: re_n assertion delay(t_rea).
+- arm,nand-cycle-t3	: we_n de-assertion delay(t_wp).
+- arm,nand-cycle-t4	: Status read time(t_clr)
+- arm,nand-cycle-t5	: ID read time(t_ar)
+- arm,nand-cycle-t6	: busy to re_n(t_rr)
+
+for nand partition information please refer the below file
+Documentation/devicetree/bindings/mtd/partition.txt
+
+Example:
+	pl353smcc_0: pl353smcc@e000e000 {
+			compatible = "arm,pl353-smc-r2p1"
+			clock-names = "memclk", "aclk";
+			clocks = <&clkc 11>, <&clkc 44>;
+			reg = <0xe000e000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			nand_0: nand@e1000000 {
+				compatible = "arm,pl353-nand-r2p1"
+				reg = <0xe1000000 0x1000000>;
+				arm,nand-cycle-t0 = <0x4>;
+				arm,nand-cycle-t1 = <0x4>;
+				arm,nand-cycle-t2 = <0x1>;
+				arm,nand-cycle-t3 = <0x2>;
+				arm,nand-cycle-t4 = <0x2>;
+				arm,nand-cycle-t5 = <0x2>;
+				arm,nand-cycle-t6 = <0x4>;
+				(...)
+			};
+	};
-- 
2.7.4
