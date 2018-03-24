Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeCWRrJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:47:09 -0400
Received: from mail-bn3nam01on0082.outbound.protection.outlook.com ([104.47.33.82]:6592
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752338AbeCWRrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:47:00 -0400
Authentication-Results: spf=softfail (sender IP is 149.199.60.100)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <chinnikishore369@gmail.com>
To: <srinivas.kandagatla@linaro.org>, <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Nava kishore Manne <navam@xilinx.com>
Subject: [RFC 1/2] documentation: Add nvmem bindings documentation
Date: Sat, 24 Mar 2018 23:16:37 +0530
Message-ID: <20180324174638.12621-1-chinnikishore369@gmail.com>
X-Mailer: git-send-email 2.16.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--9.193-7.0-31-1
X-imss-scan-details: No--9.193-7.0-31-1;No--9.193-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131663008181974804;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39380400002)(39860400002)(2980300002)(199004)(189003)(82202002)(87572001)(106466001)(76482006)(86152003)(5660300001)(61266001)(47776003)(4326008)(107886003)(55446002)(81166006)(110136005)(73392003)(51416003)(8676002)(336012)(426003)(81156014)(6666003)(105596002)(77096007)(73972006)(356003)(305945005)(87792001)(1076002)(8936002)(83322999)(316002)(498600001)(50226002)(86362001)(26005)(9786002)(63266004)(16586007)(36756003)(48376002)(50466002)(2201001)(2906002)(2876002)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB327;H:xsj-pvapsmtpgw02;FPR:;SPF:SoftFail;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT013;1:oJJ6XinOxMrZshBFOM9GiO9VG1Tl4jHe0dkUE/cHJ3WzYf5k++puYcOqhUbH9zwQpNGyQ/VXFXRTwfNw0qCfwcGz/fmuU5lywqejNtx2Acy3jCHwmwlas51ZZzdUgL/b
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a3327a8-6138-4846-81c3-08d590e61320
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BLUPR02MB327;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB327;3:BWhC+XB/cENR4NUI/ZJf8jCK70zE3zpdcqYZfjBVA3HIEsJqRRYmdVLD/iHewpepksaqyQq6VSMnoDm6H0scFnAEaWhEoD5auoJrj3t3mUh5x0RM/X2iGAJ/bnfMf38S6Hg395ypdQvAmi/YcCzwkcBhxserhw8J75xtggFpszvEbzlR0KuTJuC3pU5bxuJ8TjQ56joVSpCBlDo6KJaJ6w+pE773RkGPmWpK4o7XdSmGp3QRp/c4PUb0CqboAYr5cq3R3TqydBSt9IjlFuqmbY6hB1yQZhr5WVc3WCjtsrVKFPPjDeq/C0MvJdr4hTlMKotZxCoo5c/u4QucJkAtolmOUA/mJ66EoxTcC2Emw5A=;25:nm280QbH0oYsCmwY5R8IWVTzU9o7XV07gKzBIZUnqfuXNSPC+lsP9stIR+QFW4M+MAswbZNXwoa2iqbJRhLvuHmwsc/cycc6XnWIipbK07JwrmXaUCTS8DPQuzUvy/3vHG3jETE256kD2Y2DzAq0edphQCO0D68+2UxzzxSB0W3M6f+Vma3Dfr3awl/n5Wa9CeUrIXivSjhQktf5hPcHg50wYHbIBcHSxTAY6CQ6qlH1Ch0THSRpbpV8Ak8hxS6Ggv5+HTWeIEizpgG446WaO89FqpDG3hw2ksVZbTTkj/0yJGVHROTtoa3j/trQcw6vBTleyNpVDuOmvE/SV5SFZQ==
X-MS-TrafficTypeDiagnostic: BLUPR02MB327:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB327;31:f0EMAO6Wd3EWCBT/yXZYoTKy+HvZhgrCqi9kc4DGKCKeOG6JI3LYo375qABaltdtTm3Wztl2Vc9mfDCfSCl+THfiEKNa1p2fv3OhimApmakkSHtUjrD6fZuLgAMr5SvSoxFk6lCQ7jwqgll4tBwrdKAmjFVvleFtPAmY7D6KUE1KtjaQwAI2Bp7ODRkJfYFVnBVhT5xcI3+myS2G2QcI42TNlMHpryD8ZQqALJyNtyI=;4:suKNv+rgyg0fMvUKq4GcOF+wSU4Q9AbMDIUS++KHzCa8YuQY4o+Q1FU3cEMIGKdOw4CkXwe6nte0Z9a4yi3FRBxKDWiXVPSJ0+z3T6jJ9HnWt20GABbxyTPKV3fFvgcifrlNOSTzvIKQOui8HEHEy2CeNxoM+35ReozPTeajh1sVEX5jdvX3I/6MycvaYkUAI5W/4gqW3+JgKUkxAgsnOYku/gubClDk+7cxoSjltyvY07nK2oAz2Loz8rP+FC/uAiuRaVZ8SH8+YCFNU9ZJtgm5+v6EMgIuO+HcFfmDvhJBbTjhDw/TPmZBR4P886jL
X-Microsoft-Antispam-PRVS: <BLUPR02MB32704C6182869F35A4A41238DA80@BLUPR02MB327.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6096035)(20161123563025)(20161123565025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123561025)(20161123556025)(201708071742011);SRVR:BLUPR02MB327;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR02MB327;
X-Forefront-PRVS: 0620CADDF3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB327;23:KkLvE7bEqmDPcOFQXdKL7kDLruTBURCsw5Geiz3Fd5?=
 =?us-ascii?Q?lmy1AxJWjFUTW6nWkid8eWyOS2bQ+fkA4+9iJJM0ZzcwJLUeEfm/wpTvDrmi?=
 =?us-ascii?Q?9acwZ6Pj4CcGjKxG+OsD1Bqj+gEgGbHW30kFQjbdKrQBcqZvBd8zP2f1q6/7?=
 =?us-ascii?Q?LyYuOokQwveU1EslQHjFcHQ39J1EOw7LZ9lk0Tns6WjcltTYjJG8JTQT11ZQ?=
 =?us-ascii?Q?P8kpFyt9znzINMciDAvJePjc/uItBVXPo1s+u97ERxPbn40k1i7XmoK+wwv5?=
 =?us-ascii?Q?pKjQQxa8gd8og3X2/kXXkL2uTQjqujD4xUJ9UjdYSWJfAskE3v8XzelWkEGP?=
 =?us-ascii?Q?aS34WBQDHukMIY1uUn7ZSOzrt6bWcrT4Rks91mCZw2t4UgNDe8cdSzGe/Crt?=
 =?us-ascii?Q?eTtrVpJYhjnQMONR010BV2VAOVfsz/+7IvrgHTJP03Oz+74ogcgaTceWaZbT?=
 =?us-ascii?Q?b7h6TLagok/LT01Qx8gbZcSKiHCTmeu8fLd7BELEBy+Pwq9zy26xHj1ADLQc?=
 =?us-ascii?Q?3WlVspHkuYK0M95BWJ/fswUOBw54fQZOSDecZArvawqxX4Jdi+EDYuSMzGQa?=
 =?us-ascii?Q?5g9e64EsUEEGeBX7m+pKuEMh1vJPCQ6UWpI/CW7k9VHoEIiBTetBtZ9oFYji?=
 =?us-ascii?Q?E2XcnkQjCNE+hcbeY+dFMaOfn7xUD7o303qdbfuzDerBJOQrUiD2f3rkRHZi?=
 =?us-ascii?Q?x1S3JX4NeBTrRIN8qiFHRuOTmMEVpbK5zJEm7Dve5EdBEeWydaZHCkwOLvUu?=
 =?us-ascii?Q?fc6zryXGY5znJ3fHQE/v9fw7oriPeEe8YBBloqtqsCX9RhMmxjZe3zAjIvDl?=
 =?us-ascii?Q?dSCyV9zIltmeLAtqrVbquskOJgMCWQIEOqnmjd+tq2+P07VE7tzvgsSYI8+K?=
 =?us-ascii?Q?1opX2Rfx3HapugwQAp7z3G+4c+t5thHNxQKxnjHl7yA6OOAJNhsdjMOI2jfu?=
 =?us-ascii?Q?gw6w/PjSbiuwniMyRc83ZmDh+8aL7usI1d6a+Od8Re4zRPNe5UEig32iM7yp?=
 =?us-ascii?Q?tNr4zQDxzm7CeIhjuaLz9TEOE3P9yNReSkj0b9/RmvF1VktHfe3NXzfPt5Yp?=
 =?us-ascii?Q?6zJzLkVgZIRNbefG2JcsSCsMiGG691kd29KIHSL+mhEB5WA0JzMA/FJv51ZE?=
 =?us-ascii?Q?4tfwDl+3DVPfhE1SfX/dn/ZBJriHTsvWq+V8higXDcLLArS/HSH67B4br5+j?=
 =?us-ascii?Q?kr8kueYF0ceE5OViyT5TiwLh9VaGJ9utnodIbthQ4hzPSdZaSSL3XvLt2rdd?=
 =?us-ascii?Q?shbMIU8+X9KqPShfE=3D?=
X-Microsoft-Antispam-Message-Info: HzsmJ9zxKV862FIVXz0uRU7VseEcrpjqYIFex6M9mygGm/CailW+EPiJQvg3MyYyzk+hnF4bKPPN/odMdSASgD+SLKSzl1OYAD6yxvxWAdVDunCODOCdiQ62WUF/gHeIIMiztH0nBAZj/UGT/XKrFj5rGMvOA1ibIiMs99xASEswUUv1mK6PyZ4Jl/qHh8yw
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB327;6:YZkOY/Q1qYbNUhV86Auy+DKczUmiRZzKbEr2o0VYkUsNcZHH6VBD9moM4SVizRZUlmDeC/xpVe5INlSrujNXRG53EXrJI0IU0P8fa7TCbdOm/XGKNTLYYHYFJ8k6m+2Np5mcguiGmDfRj7ECAWWSvsqh2l3QYc0ENhh6dTMqW8ZouL0l3Q3GrUSsO4eOWUmuh/RVpJihiXP9QY/3yflYW5hKD22+Y8V+V4RQ8/R2p64qaCpokQbqWv4KfQ+YmRhE0A8UfYeLWx5XU8HLl4J3RLb73MhOo12IL4qe/0qBZBtOs59Un9wOoq51GJVTR1c4XBRQ+XYBmhxvhbzTjTsilsgAgAkjT1JCG/8Sk86qb9pm2/Oq+FWA86/XVxRkouoYAE9G0xpn5IGEET6t+ycrdOGnpHsxf1myjurdLOv2BQVntlbq+qc5RuKA6ZiwcXZoWxhqOCrWaNh4Tnlat8A/DA==;5:G2y3ty4GAlbbciurDPMMCV7RQ1IHpNIgFXHzO+Gn9yqBXl6QMWmT+IZzxyGihszWVnXOdOn7aURXrFa4eBq359BgsPILqikcObRRgv6oY7eZ28H4atwF8Hs4SqlWdlvz1wtZjRf9xrU+As/XYHp7LQIyIqBYlHAtL6Ke35UVBHs=;24:dpDA3Y6JX1yuYLhp2bTzIHTR2So7JvRcsDJNvi022+F8UsBjPlvZr0lg70zqTpy0SPdnFLQJixgNOlFqwlaA9Mi4qpncQlGF3XaIoo8CX0M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB327;7:TApxn2uvRmZ6J6pRskjY6OnqDm3OFUgy3ZhHG/xmgeaYN0061bS/VQc9yjImCZxIAl0ST/F5/gWCh6hVoYrHeII9BjICiXou9IUbp81WojIpZv4Dg+84tRRXeI0dR+UVzoXabigCLDW9lzaxxr8KmZqxSELABlUikz+lz+KjEBEJp9agkYumC77s/wLV53jBCgY32fOZ17guvsTSTHQs28wqp1WI9+TmdSgzoYB5pzbC9hSCvVtFTYiVoSB8/QcK
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 17:46:57.8693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3327a8-6138-4846-81c3-08d590e61320
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB327
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <navam@xilinx.com>

This patch add the bindings document of zynqmp silicon id driver.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
 .../devicetree/bindings/nvmem/zynqmp_nvmem.txt     | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt

diff --git a/Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt b/Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt
new file mode 100644
index 000000000000..94332f160a92
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt
@@ -0,0 +1,32 @@
+=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
+
+Required properties:
+- compatible: should be "xlnx,zynqmp-nvmem-fw"
+
+= Data cells =
+Are child nodes of silicon id, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+Example:
+
+	nvmem_firmware {
+		compatible = "xlnx,zynqmp-nvmem-fw";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		 /* Data cells */
+		soc_revision: soc_revision@0 {
+			reg = <0x0 0x4>;
+		};
+	};
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+For example:
+
+	pcap {
+		...
+		nvmem-cells = <&soc_revision>;
+		nvmem-cell-names = "soc_revision";
+	};
-- 
2.16.1
