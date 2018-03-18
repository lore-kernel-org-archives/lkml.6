Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeCRDR2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 23:17:28 -0400
Received: from mail-bn3nam01on0052.outbound.protection.outlook.com ([104.47.33.52]:63724
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753256AbeCRDRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 23:17:21 -0400
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
Subject: [PATCH 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz clock source
Date: Sun, 18 Mar 2018 11:14:13 +0800
Message-ID: <1521342853-2941-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521342853-2941-1-git-send-email-Anson.Huang@nxp.com>
References: <1521342853-2941-1-git-send-email-Anson.Huang@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131658166390320975;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(39380400002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(2906002)(5660300001)(305945005)(6636002)(81166006)(51416003)(76176011)(26005)(316002)(85426001)(356003)(2950100002)(8936002)(54906003)(16586007)(110136005)(4326008)(50466002)(450100002)(50226002)(8676002)(48376002)(81156014)(97736004)(26826003)(36756003)(498600001)(77096007)(47776003)(86362001)(106466001)(68736007)(104016004)(53936002)(72206003)(2201001)(336012)(105606002)(32563001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2160;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD012;1:npxBB7BP6HAaSmm+8Op8VNj76sC0hvLKNQWInZm5xF1y6MSg8ADPc3mH4urQjl23friTE8fNCalDGgtNgOVRqNw+fbQjqEYCJr2kB2/ejMsq61DBoP1kP8r/z/LnaqWv
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b6f1088-655e-439a-6f4f-08d58c7ec1f0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:SN2PR03MB2160;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2160;3:1curoGVWr/m+03M9bwUE/y3Kke3i2l5R4CTp2Fzgn3huvBFGmmVUH4OTYGsoh4REjA431Hg8mAy+k0/8adIdVhB7ZLjA5fGSzoHtsIgz8ous/1SsgdsvhzE30WIr68MYk0WAZfpW5U1FyxmeXNy0tN7ExpvAoLL/JvvD8RO1mRHPBhmfEMUHotLu46LRugVh7CXQ9wr9H0GPj8rJPFGFvjMmAaQEhxX7KIe5co9KEcBaSJRZgGiARRY/1GAyGVlqpol8bs/pEHXgpRLK+mATpF0Xosn+J/gplUNQMzS/wn7ltt2miV63DN5Xi3Xj54aofxHmUM1x4SuYfKwI0pOqNJM8fcblxgKULcIsCfoVsIY=;25:31yFkh5G3CLoRHqVe6xrYX658HsF95TColV49E07ouBpPlhOgsJP1sgKRFMSkiwqN3ufsCTCy9WqXGJjzJsOzGG+Y4KWEJ/O+xtWqcGTT++6JDPlDt1EasYk+kd1v2x7J64KyVq7PWGl8a81NfKLFF6ceVYAPDIysRAxL4s5Kpr85b/9QElzsVpQq3VuLle+A1MUFkJzl5LNPPQbbznbxce4uZHLpy/fNlm2lqIjDSDpBA1z7l23bESC7NLtzji3gZMqk/BMt7IQoh2lqV2znAbUCEonv9MTf1M9fae9YuRtveQcjW9I2GOeRwaHEPabM2+yZAjUxBx5mmqz16SD9g==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2160:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2160;31:9mqXdU3j/oT1aC0PP1qCoNW5SkMsHNHRrnqEgDNJBRG513U4FDrWKS1tZK62rLH6zCfK9ynC/8Zw8xdgngTFi9AE0pkeKaW3nTJid4Je9fHDMzHFx3qsWbvRRo+kNB1VXH+rHzjZqXZlcT8DOCmZIL4mA3Y8CGCI3BM5GIyqQ1wGf4gaOYyVyz9s19KJes/16OzxcmrfVr1alM6oM1o48SqF2mcOiLgKYJe0Yn3YgKA=;4:6bj/OWgb6zuh5+TuYIhg6DPdrHe0Hnc/7fnDQevqJ2z9DaMhMpf+6WX1QhQt/hIn+j0V+zvFCHAwUrXbSLyZYjULySrqYO+DL9qXZ6x/e67ws8Hzsnsuyw+plm9lde6NC1k8Di+z28mGcqaUUNVBPBg0QYC2vSXS7GMzoPbRzu+ENdFuKUcAY6aiDX9U+IFw00qTkytn45aNvlDvCHAE+QWFUkYa1Lq2I69wUXmP2nY0dLUNOb+3Go5T+WkX9OqXjWdcR+OtgwYd+k3gwq2q+FxJfRrWfJcryzrhOa1MTbDdGcytIqK5czNUOQiuhoCf
X-Microsoft-Antispam-PRVS: <SN2PR03MB21602C04E8218C82FA2F197CF5D50@SN2PR03MB2160.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(6055026)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123561025)(20161123565025)(20161123556025)(20161123563025)(201708071742011);SRVR:SN2PR03MB2160;BCL:0;PCL:0;RULEID:(400006);SRVR:SN2PR03MB2160;
X-Forefront-PRVS: 06157D541C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR03MB2160;23:b7sZ2nMbqtIU+VK/kymC3X525qSlXynaNtuz6+7zI?=
 =?us-ascii?Q?zvJnbx3EPQQLcqbOZoUdbI/iM7yMRafhS7p6uNT/rwNrwbBLeMo/ZWhreBe2?=
 =?us-ascii?Q?i9j5Wmc8NFCXT7nny6rb/vLc6VA9ZPFPftRYwhKCN77Xs50bAPEoKIqMI9Tp?=
 =?us-ascii?Q?nw+jTtuxBgDF4WVBMOCyc4pC/ER00NMrQL1mrBVnSgtuG7SEZrvDFdoAjptT?=
 =?us-ascii?Q?QnJtRWY8TteN0LWe1wMu8h22N1FnLMTJ2V5d0HvkmV3G5MmAOeIN42EgPD4I?=
 =?us-ascii?Q?2yD0r57ymobEKA2qTnVa5jqQsUYWfq27bnn2qIXXzkQsrNXlKs2ggjz3i7da?=
 =?us-ascii?Q?Bo/zFEpcqJDEaD+8qyYnCfjjGvuveP8u8JskLeqQ/l7QUIgAG0MqpdT55511?=
 =?us-ascii?Q?O3VuTlb12uEowkVIiFud5aDttxMnUSvQiNuDHplZx35VqxIe79Ob35reP7vD?=
 =?us-ascii?Q?g0Xy+BQInXCVcLAsg9I7qYRKv2e6X4TOv+KTUjbYrFCWaQlklBFkV1mnSYY1?=
 =?us-ascii?Q?6tt5EKxLuvXa8Z52PcI9FeYjXLMHfdWizFuKqsqFzJkYzfsmu8EFj4tnTr0p?=
 =?us-ascii?Q?Spb5t0CgRFbqDddXz6Q6hG00Y1blP+AHTXFR5PmpC+4/EWeoifFol6H0zgXV?=
 =?us-ascii?Q?twrfsy3UhNKHfHlfO0vJIutHujvrOydfWlaXqB0OVwGOeK8HZENEtA114C+k?=
 =?us-ascii?Q?xiEX9bPDwufUTg40JSCm03CEBrKV3tNNLCUO1kg0mnou9MzkREGyZIbWmWLd?=
 =?us-ascii?Q?fE2S0gf/M5le9sqvFh/Ck/XMPZGPFWcRDyN5DSpLn0LgbiTKLZxzMgCRzEMB?=
 =?us-ascii?Q?vIWU2Apbfq0RrYwZe4XNeavvlXvP/mRR8COISN0WkgdqOHUw0DQawWGkixog?=
 =?us-ascii?Q?rJV7J28TzmrMhrt0IzvZvjREsTAdVE8L/QpBF2ghFm8PvO5j7dVQi0nSsdfj?=
 =?us-ascii?Q?+Ei0bwrj/diiW+b1aGWg09pbzJP73Rg37vjudTyGaCWzhop9+99ENdoi8kQb?=
 =?us-ascii?Q?ZPCXoNPA4b3npGFrLXyBCnWAGc/3SNIecoSw1+f7dBtrcY0LgW68CqjvNzxM?=
 =?us-ascii?Q?7d5bCqHl26ZYF6E52FQBe4nuJ/xq4jJ6MsVT5syZPcLtn43E8vO8camNSB5X?=
 =?us-ascii?Q?3asnz82idBCXL6yZik2UfxI3gExEAxI/PqdtO30paL8EPQw3bEGlUYBeOezm?=
 =?us-ascii?Q?UqlgnkE4+F2+9k=3D?=
X-Microsoft-Antispam-Message-Info: wLPfYVWExYBDiIJRggV4Q3TG1lkRaC80RuZy/oQ74gAmh4aCwfWrfNh6ymXtw8TXVDkOAV3+3pvIEVTYmoIT4nCoDTU+KmqLikCGtbB7YRCiKfhzRWJcFlAZrE4r3SH1qFSBIwtY16WsmMT4GzKiU54dLWAymP3Lv2e/tDzX2oGakjAnSssA1drC2ZhVFlXc
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2160;6:1LoiWJVJezHAd6MycORSHUEPm0LmVgQ2a+u/KVyodN/54GT8KmjHpf7PCP3kDwffGc/xZwuBc/gDLI0zZvjctpSxoCiW/3QE7T4kL62W80P/H3JgaBXeYMtIG0W8K0djrdXG+puJ8tFtWzSKV1eRXyc/btCfeuGIa4GNIaiG/4vgL/k5PNGBRx5W628EK9A/0IANpAos14zaZts1MknwxyivlPOyt+jCmMPm9dbskm8u1Afhz7YnYxxQ8OzaFrEVbbIZuKQKwDOZt8G3cnCqn7qD0v1hn/AMtERXeZTvnJBx1nbtBpUSQvgD6ynlXmrhaJ2pbPVAbt75TGBUOu6pEqUR8OJGhVpbw4z0oIjMwgo=;5:c5XQmlWxmwRvZmFMRDGvsxp25DKvEhgGHH32N2eCfor7b7ZbW1HVNmg23g4wOifxWEFpLOSxh+2tDJDOsmuwTdvqPVBpJN4ha2Db2MkQKp0bU8IO66zS9E8q+0pDTD7Ywpowcx3iDiEMDl3Tscv4enxhjT5u7jAA9zog/NLRUYs=;24:FZc+6hM5xRsI26HMjd5Icht6Y9H9bTCRgC0IG1ZLpOgX7AavQvpQP4naCIneFc0J0bHdl6kOqnaa0oq+M0f/yf3HHhMS1Za9KkYUyvsO2R4=;7:ODAnebkSgYUOtsGtu2cFtQVHFhcnAhYFzkvm9kwZq45yq8aF5y36tilT6o7/FhTcOivp/omlfpsRP3IckZpyp/mPjBqsTX497QxEl8dIyKbotb/aqV5m7PIaV04JP8c9OCqPGgXCC7fn1+vHx+rjNFv55a+udXo6zsGs7BeBfqKudRZOdoJnM1+UoXJh37XNlfC37KoQo6+l8Mxa5m+3jpJuLR4iFReHSzhpksWVX7XZjbnpdjNUbW1UWD+4U90I
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2018 03:17:18.8604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6f1088-655e-439a-6f4f-08d58c7ec1f0
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6SX SabreAuto board, there is external 24MHz clock
source for analog clock2, add this clock source to clock tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 72da5ac..83f7cac 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -18,6 +18,14 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	clocks {
+		codec_osc: anaclk2 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24576000>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.7.4
