Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755032AbeCSCeC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 22:34:02 -0400
Received: from mail-dm3nam03on0079.outbound.protection.outlook.com ([104.47.41.79]:5888
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754936AbeCSCdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 22:33:54 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <shengjiu.wang@nxp.com>
CC: <Linux-imx@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH V2 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz clock source
Date: Mon, 19 Mar 2018 10:30:45 +0800
Message-ID: <1521426645-19246-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131659004329488732;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(346002)(396003)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(51416003)(336012)(76176011)(85426001)(2906002)(450100002)(104016004)(4326008)(5660300001)(36756003)(81166006)(81156014)(8676002)(16586007)(498600001)(50226002)(72206003)(8936002)(356003)(26826003)(48376002)(50466002)(110136005)(54906003)(305945005)(2201001)(86362001)(316002)(47776003)(106466001)(68736007)(53936002)(105606002)(97736004)(77096007)(26005)(2950100002)(6666003)(6636002)(32563001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2762;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD022;1:gNgGe1pNxOquUo1/WKyaqfH8FBrULTfzucRMXOxVf92q/4ubDA82Nra+WJ+0XZrDldGVx6XvAG26WqpxAiPimfSI5ouBz963aqllBqOO0xcCloMeueq+VIL984Q633Y4
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 546835a3-b91c-4fdf-715c-08d58d41db01
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:DM5PR03MB2762;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2762;3:qlKho4g6vW9la40YW8MU3G9dBjCsbDG1KwWRn/FvNgHBqSdJZNnjTddEoRJZuCgwo30vZvx/U/tZP9lA7eAfWKIMm/y1V8oLfTkuOBrVYsE/Ef+5GjWRLIlwTR0yD0nSinjDYCnHXBfMgBRraXxGdbu5+sfU9KW2T0sa5f7+jOB8mERA1c5aK4o/eS3or5vvwL2U/0K/RpoxLaZluulTeZp5I18ThNY7UC7vgI4PhxDO8lpw9tbzyXXg6Wn7xLzorZb5UnJAayFvIuW8HhMct0cxfhZIDHWIRTwNGFNAQDo09z70HawE8+2FRpZvb5EdJgXljEu1601CkLOMNUzsppSEvDyEvqknya2J77pywH0=;25:x/YXZnT9rPuew3aN81pqtVJp0g8mP59c6deaio7Zu79kaDuCJ9f6Ya39bLx+YSA76pM2E7p4h7UYZaAp4DZXSKLxTW6wqyZCbTSZ50DSaqq/xv1i/jYU2r4P1eXkXFVOUJPeS1VKGpSRxCWXzz5I5l3Ux9FzcpBaLpWozktuxs/hRNtK2gp09WrZaACzYAczzDs0xglalOC7jA8X4eRyexrnQBnZlxdFHn8j2zyNUPQhBtXipLTjHkpakQ6xxXkFGaYiptxienXk3Z7UT/I7k66VRTVupl6EqDixXWBlThDi8nVIONj64EyraAnXgXtU/0qKA1lbQGA+BVPiDAuTQg==
X-MS-TrafficTypeDiagnostic: DM5PR03MB2762:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2762;31:bOotCl4LKZ801Ind/8Mq54idQcD8EWiI1HVU+EKjmXygl+eLGeXUFf+JjneULd3azFBY3Nw22vU2UwsEuiSzzIkTGSgyyAs7b6U1yU3c12eYFsimAxYlGU7GnpJSeTvJC+4kY0AMLqzjq0bo7NbmHNrfl2QGeAVhXI+jhp36gVhAXQpBY3c33+CdgQlOyI+eAbQL6xODcXy4vfg9ltYGvch4p7/F+LGryCMZflGKSSk=;4:ezFD+dnSwSWnEABaSSgQTDuyCb446ZQy2YDEcoIN+8puwdKBQHGmn1E3qn5kVNE5M5u8KCljuBuJ9NTl2nUIXOrM/u2jFlRY3FlIKenir5ZTZUTtdQKveWD9lJYkZGtQZSiI8ZHdm5FW8eZWdoKFW55FpZNO+bwOzMjCS/LGX6S537ioDfiYqeBR3vAz+7ynvRzFXDl64ncyYtteom69a2RHUSzPnRDAJtePuhWn6fTDIFJ8FVnfBLq4HC9NW0xKIS5IB4nQVnL6/072ysujM4odAWFzV0kMcb95SG7McTGorFqqBwWJUnscFS5P61/o
X-Microsoft-Antispam-PRVS: <DM5PR03MB276276E7303B94E5CEB5BCFEF5D40@DM5PR03MB2762.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6055026)(6096035)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123563025)(20161123559100)(20161123556025)(201708071742011);SRVR:DM5PR03MB2762;BCL:0;PCL:0;RULEID:(400006);SRVR:DM5PR03MB2762;
X-Forefront-PRVS: 06167FAD59
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2762;23:whYGZf31mhLxZiYp5aMhccFlhQes85K8/iD+xu+Gl?=
 =?us-ascii?Q?hkjEtvh5QKgisVtUxJkNrn+4th6TyXPTpOmM6nCPb0dwfboo5TpVLOogjZ/+?=
 =?us-ascii?Q?w0NP8UUFBdprX1GqjEdSR/NiyNCwAybn9S8jVIBqB6tQIrJkbL/Jc2QPc/b0?=
 =?us-ascii?Q?PfR+9e7G6qGjbxKOlvtw1OuaCQabQMafS6tGWtGYnvGJzF66F8R/JVyejUTd?=
 =?us-ascii?Q?IpW+JQWbIdMAvmQb0+Mss6KNQIZ5U2iRAZv5kjLYpx+BrPEOZjC7XHy3qgjA?=
 =?us-ascii?Q?ICBT/nAc56SS7xRDJYLBqbHLPRU2bIVQZx/9EkGuRU7TGsfIsMn6aJn0OuOc?=
 =?us-ascii?Q?em6h2rku51wYMYNVStMdH5BwdS/v4G5oBugdcnmFcMq71PWYrFNDB8LXHjuZ?=
 =?us-ascii?Q?Cz1SX7ZdwiMHV1+lfLrL+5Nq8kWvlGOm0O4yQSLObXLdHmKNCCAePdoXUXVN?=
 =?us-ascii?Q?g+PN22SDrRygR7u02W7XiCMZRgFGAgo4KFQQy/wOAdntYE2N8bxVDRyZuDI5?=
 =?us-ascii?Q?F3AvJ+zbpX89V20rjxG0Ncs4ciLeOXhSXuYi/0DKAgl4JKy3zKrmf4KiGSRK?=
 =?us-ascii?Q?42yIbAehkQJ381h5kZVwCXOj8jC1c8hwCBi4kRght+pj3KMzjw8MmqO6hHjg?=
 =?us-ascii?Q?vzxbojfNKv+84hXakZ4XqYV4qw0oMEWYaNCnot4fVdVWs1cCLJLyyMVFCrVp?=
 =?us-ascii?Q?mZzD4yTyRnm90eoWNnnduLjMTTsoCLcdn5gJpAxJxGOt2Gyj54ZNfnpG/ymn?=
 =?us-ascii?Q?enMyyaRWmSzcyCOx2hex97KjjyVyxFXESTenk+sf9jKpeu9zLdEp0kZHCYcX?=
 =?us-ascii?Q?mpj4N1EoLPt7PmfoQenBVzVAAT5dw37yy3+y6xJ1936/qfOkrsNOrx1TJ4T7?=
 =?us-ascii?Q?abCT2+hDIOZIALRxugrqv0DM1F6z693lyaFSi9GNDdgB/AEP8Hk5Awq3U553?=
 =?us-ascii?Q?7BEiUL9cewrwXS89J5ipbAU/DPmCjnLQrMdObTKox4gw4OhhanjS4CgawVJg?=
 =?us-ascii?Q?78gUwR7I8/U3N1qJLcbI9kDOQCS+EX4u1rvpRGi460lA1Rb/ofs9CsZO7Ne6?=
 =?us-ascii?Q?pmnsFF85sSCK4MgL3X5P7m7vvd8nDYYAB/Jvq4v3vmaab4pBlax1zl8LA4oM?=
 =?us-ascii?Q?/CyN13ALu/TP/H6Dih54m/TtA8bZ9IqrXeRT5RrPJHOLtuJM/j6LQAiH4dT0?=
 =?us-ascii?Q?WpoILedWh+ucr/wYF4dEjZKibFz2HouMNtp?=
X-Microsoft-Antispam-Message-Info: tDMBh2nh3/nKvcVDpGahXJOOb7+gQ9EEcJlJanFbH++9OYc7kKTGsapnel72dvG5licbLlGVUlWho1ExA3kCuxCtzUXXTv6FeAYt4XcEN24j5v5Azj8OdO7g8fMQvWwZx5WB0x5B5BwNgNClvvRhJaQM8xhtMdZ0MOfCoxYUS8qN2sIw7eEZwE5RcpDKe0dc
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2762;6:0RIqX3ICeTBNDDVItURG8+ROG/zRVS5Fu4Q2IM+Usj1zH/edpLWsgpLl/l2lL1PaO5kCgnrH8Oet5nrhhYQv7ug2XI+ooMBKNlIZhF+pqy3StrqWq75ZJlxOJReMoOSArVOE3jWokseGoUJ0a7eOuwu/ggUU7hFHB97zSM4jSS9L7VcTF/p2YGW3qfXSBZPkPiCD6yZSV7onealv9ijyTW6sjSLEDPNv64k+yM/0g0gqxfSuT4OEWn3vVWZWhjRSsEqlAOHNzFBwfJW3spm1cv3XROKeSw4ZRRSWc1OJTeIZgNXk12B0XT/kmX0NYS1z0fuxwW80YR6SYzbR/b8KCcMKD1Ewus2cUecqHwqVyw8=;5:GO3oFa3VlbL3Nb4be241GkTW5qED8QJ9Pt9wSzqk7Wo86FuGh8fhHreoW5EMjhtmU4pU8NU3jIpKZ2l+rAKF8Q8SFmRz4IAY9+4/1MqvikYTgs9fTEaEcXnwtgsiYktP22DGehWYvkbMYNXd6rWYXI+11Kmrb4jmaslrVyzCmBg=;24:1vXV/R4C9vSllGsHxyyi3cYfLczLCVAvBu3E1Uo1wc8U8C0e3Xk6y0BnZAjElMOFLQI7I1KEl8VNEniPhGhFFEx4nYApM36sYzfrKZeHOfM=;7:pw4I1Yk2JWHkLR5be0yYA7yO8I0yG8LetdeDFAmU+VfNFORvKgEdAkapVWu9q4pDUYmrSDz0Qw+bPFt5sFs4vUzuwFvd7drGgnl8mwOsbQWoQGQVR9/NvPLs0WuUqjo0ukhZCicSMJ18KJ+7vm1AVYt3glbMhkTmlVUafl44I7gYS00Kmf854jsBXArzDSg4kttixuJ9mysM8aczvtnbwfTc/RWn2w9KL5uRy7A6h7Ar3TNpL0puPd8VQVFBJNir
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 02:33:52.7772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 546835a3-b91c-4fdf-715c-08d58d41db01
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2762
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6SX SabreAuto board, there is external 24MHz clock
source for analog clock2, add this clock source to clock tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	remove unnecessary clocks container.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 72da5ac..a3b022b 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -18,6 +18,12 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	codec_osc: anaclk2 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24576000>;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.7.4
