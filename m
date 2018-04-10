Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AIpwx4+7O0tXzpzsLPzrTv8H7dy7RCZtTciANjhS80JHxFlhQEMy/EoyXRE7yjUSubqEUdT5fBfh
ARC-Seal: i=1; a=rsa-sha256; t=1523389175; cv=none;
        d=google.com; s=arc-20160816;
        b=Ql4l3g+C2lIpZhAi453M9tnqnKIgg7RWy7YaoFdw2bJ2Xu9EKFiPIUY6aYj8pgLj06
         JVjV7ZMFr8mQZ24ErlAS03XQ+5LDHQheO48xeM/cB4qUlZWjwANdXKwDj866Aexr77zM
         F6aF3VkB6BsFpru2N+1C47JzM2gvYLrgY2PX7HOH5OP3NnrytzDKe2142JBJWhGYQInV
         /feajR4yjOgopHhfyLmGCY24GArrYscXyy2V/ccYx3xwIlstGz/S+kXkg0cB5yUeG82V
         cJ/H8asguCQ2a4XSNgy9Z2SbwYzqjoEBc96fUbT3+PutKVPxv5L88t3GgwLgdAQqIHzw
         aycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=uyV1mdz8+1xBD1YQhlnaGHBaJUY161lU9bIW0SV3lwY=;
        b=qTLizxgpS33F6KTtOmENZB1L/C9EN36YN3oOIY3xHd5DyGEwbl1RnPakTkFvbN4u72
         mUHyBaRXHFbYV0u8jQN2AvEWqEapiPHZVk4pmAUBM+HTKSKNLUuMkgbbPGKwVzgKQ8nU
         p7HZKNwdBUFTv7Sz+wq3ebkxtdzSx/PBfJAT3bGcGKh5QIl/fb/LuLVs3R+DZn9SL2Mx
         EAqliSbBz+vtaZl0RQVgP7/uvLVdm+jax6jx66Iq0/nbQkNw6KUNnAvyLydZX4q/URqF
         ORjctpyjh+z8diHtX0FBAGo+JoPciPfpo76me44eX5tv5V0eZREINuYbDrHFeFgtTxBN
         tnKg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=Yf/Koyym;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.34.56 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=Yf/Koyym;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.34.56 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
	<gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
	<sudeep.holla@arm.com>, <hkallweit1@gmail.com>, <keescook@chromium.org>,
	<dmitry.torokhov@gmail.com>, <mturquette@baylibre.com>,
	<sboyd@codeaurora.org>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Jolly Shah
	<jollys@xilinx.com>
Subject: [PATCH v6 01/11] dt-bindings: firmware: Add bindings for ZynqMP firmware
Date: Tue, 10 Apr 2018 12:38:37 -0700
Message-ID: <1523389127-14243-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(396003)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(305945005)(426003)(50226002)(8936002)(54906003)(5660300001)(39060400002)(2616005)(186003)(77096007)(6666003)(478600001)(126002)(446003)(356003)(2201001)(9786002)(63266004)(486006)(336012)(26005)(11346002)(476003)(48376002)(106466001)(316002)(50466002)(16586007)(81156014)(8676002)(36386004)(106002)(81166006)(76176011)(36756003)(107886003)(7696005)(51416003)(110136005)(47776003)(7416002)(2906002)(4326008)(72206003)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB0584;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT035;1:UMxczY6EkFoqIdjLedFVmr/5Ya9You3ugWfVFdnYsyVBjDXH0zHb/otGmb4nC9OwAdEH0OU/sweS+Xox0wej0fcYf0btz/qkadCgfGj1SHFOQnIN3E23ZE4DSTN0myg2
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR0201MB0584;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB0584;3:gutPxBL5X7E/0weMBQSdx9etR+RYWZPYDF65MW0Tr6U5zkedTMQ/bWEsq9KUZujvDgsvJwAyMx+y3evHWXA6IFCZtnqwBrTH+5b1yhubOOBnrCMUEO+aN4FDAA7payKCJWDUBqLa+ak/KNe4NUjk0UqivOSZtByVgGLBJwko/7RlI3mKAaQm0qr43EadXdk8NU2Zsdd8Ze2sCNQvQGdMsNkk7tMyfriue4MLJdrdFijdp2pu/FM2Ed+m7c0afRrvraJ40wvyXpFStfdTbjSyAbjGqSI50d2UlcqAQxug5PMHY1Dtvp9poHCqe+dYxP44nDSWTYoiJHH3nHmjG95ht8YaRoPvY6YEasxYjTVuPzU=;25:j200/hn5Wt7tvXP4q9gpBxwS5DQQLmjgGKUOmNgpGcFrvZ4rEvbDfUPVqRxk3SUzGpXfiFdH+XaAuqFh0kCFQWosUmPfD1eUQqYiIhKeGEsRs9JrpeaT8TbDpQc2GwWtEEF6YAMnZ8tv6oGP/yiVNF6eiGowfJz5zEG2hu7U4K/Rs4ltmnVOt21Co1n/7u+iou/QwLZGobYDKVXpurIJRRwVya2BJzjg1PebE2MkaoRYlfqjrQSg/o8o0R7vhF9htgvLz40NBKWOJTwEzbynLAipgEkgn7EFwWvcV2FbOu0SJhDa3v4do1Mpu19vyZWzRcBA7jK0fvk1P5rq3If5yA==
X-MS-TrafficTypeDiagnostic: BY2PR0201MB0584:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB0584;31:j5EXtQzW4fUBuPVBxRR4c21u4eVdzrpHbu8pJs6E8Qg4k48XMHnOz+EDyfHyA4bsKKBacI0SLIV9mnrDW62tFcBnDUMYOHaNLtst+Q8PGJBC7LesN8NL8Gg0gqL8xhwUkXAQpQe+BU0vMWpeNbSQxrfdu9p3fLDEBA16eClRvOnl10wbksRSfDdxdffE4P2EJxPSJHLjOPmifiFpJ02raM+dizwzWVGOGqJhRUXRo48=;20:vBheSMWOanThgwAEQRGM6tm8KyQtWA4//YyyLVWCuZr6yuNEqrBzmLF0vxDUM7eYYBpNlh4mzQdA2N+FKYT526AR0BS1PU45we7vxTIABCTwP9glk9YGMQVFT1GgnFlMJIMgZz4iBCw0NUM03MJwp06/ktvo2nNt/DqvFZr88nKMml7r1FGQ+42ZpsmA0hQK55KlkWrIHF3arIpJU8wM3v4UypBGVKF5d0USR6Sf+P464fMmzeg17AKYDOf7R/9HVGv7iTjkXGeKDA4EfBAKf7VpU8aGQC8f8GbBvVJY7lftJfu17K8pyj6pZNX/jwFZYJ+avU/iCWlsAwpq04gQS9ydSV867v1qF+PbQRS92DgqPJ1lUGflg2JiJxbqG6FyqwvYRIwi2xtA1i6ry7scXqFvoPDTe2a+0oArOP5lMQBK8ZHTeUiK3PvTmrxv67/uDy7CguNMWGPy10YJTdRfEZCrZRdDPEe1g6dGKF5nF1JqG2Fa43iaFOJBuhbBI7vV
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB0584DAD36A67BCA5BC410221B8BE0@BY2PR0201MB0584.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231221)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR0201MB0584;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB0584;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB0584;4:a4e2V6hvcgaCpZ9pZgxDDrbL1VNcVKrujSWHKq0wW/DufOxAVCm6LZ23Fff7M++grl36/lylpPNfPQm2gw/I/WHJyRsYbH++Rknt7pL6OM/4C9zs+qWZrjAFHnXtVY5atqwxq7T78xLGC0m/MH2sOlOhhVn1MZC/pKOJHVJIqHr4I/bqVXHNsMSpHQM9yKxzrse3luXDpY88ONaVXwBhXnNiWOuS2wTSLPKADUpe33BXtxHKAkh/5MLVdSDnYZM4sasRrw5U28ZcS5x21H7XXiQxqJNq8PQtX3X9rc6XZcv4+2w76UPsaGSyj3ydKZOe
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0201MB0584;23:tpz1f3I+BnTpzvYQhKW0poTNcF5s0vFQ47ofU9f?=
 =?us-ascii?Q?ytcS3zSUX5Pmy1HgOxrX7mrWtDSw0Lsxwvxzyl91iCN/WmRj+PWPwqLsZf6H?=
 =?us-ascii?Q?Z0we7krFmBGTUKSDFzFX6gbo6i9+pXtiQ4rKpvKPAQyg6PCG6bCzssGuY/+E?=
 =?us-ascii?Q?9HXldTYrhJS08OjKIg3oCFdjBtj7322/oZ+iwpSYUzO2PWX0NrMqKoqMhIqC?=
 =?us-ascii?Q?PyxAK99h8FxnLOngqY8SlS6rfaDhdfUcaHjzAUdUbItf66IZsjunAXxTbAyk?=
 =?us-ascii?Q?JxLPU8yrg4/8Q498N+ak1AfSasCOa0aHAFFbo3HEOCh1TcGHmNR+LtMfkcN2?=
 =?us-ascii?Q?G1Y7kiQTqYReIc4pfIAfzJQoZnsrgUWGIq+zNnG0z6mN0aShRBrQ/1+tg0jq?=
 =?us-ascii?Q?7bwSbVAEfvv2pI8ooaTKJOGY4J5mJHzZHUH+TKBdlos8FKmsO19WmkNKTMfK?=
 =?us-ascii?Q?qdLePqU8ltVwHa6uS/K5/IqClmT3oLNdU6B29LutrXe7SXQhcX35Pzjyh6uX?=
 =?us-ascii?Q?gCbzZznAaDNcI5cHfubxTHqgKA64BPAJcTLuB5XvaDfGICLJe5yFy6POMQhY?=
 =?us-ascii?Q?g4OZ9rWgFcL6EyewEK2kWiMbgb+jIiEwsgWcxj3cKNrLJjGeNFcLlvZF0+FF?=
 =?us-ascii?Q?SSdBv4kY5MW1Zudx+GNilBghW4vcTm0EzxmJo5aLtZx63bnjdsE6qTgCN6xa?=
 =?us-ascii?Q?FL2g9DOx16LR1srhIJsIIeBl5mBClxFZjnJAx6UgkGqJROXdi2mTZjJY8Ab0?=
 =?us-ascii?Q?WpVJ5ZkDsl6sgslQh5FWSBX/fP0WEQCu0zqCmB86SXjMoUpeYrs6UMFJ5+Hw?=
 =?us-ascii?Q?zfYlxKFz5aUgNgh9bYNSqxt3rHv+3ldY4RvyRLGRf3echP9XAwD2v8zCy+mT?=
 =?us-ascii?Q?FaOVc6GmhgKedXRONKRnn5+YnBOpih/Tu3TUWEpOz2YX43e/780275c30X7g?=
 =?us-ascii?Q?cdF2L72LUlbsmpHLe3CX3rCfruA9n8Iy5Y5LT34GsR0LdSDyL0TV9cisdH5J?=
 =?us-ascii?Q?oDZJOQRYl6yUk9UwLuoyIGdp4W90guQd93GuCw/+cTeqtYazJrwMNA94m2Lj?=
 =?us-ascii?Q?s8ZtyL1GbaCCqqXbjm92P0BAdldLMT/5G7e+7MabkjnKeeGpo+9PDFHdQG+i?=
 =?us-ascii?Q?AqkjH1DO6dTASaKsduy3kxxRCijhxyh6Y9vWIId7WcAkdb1t/kAS2ReijlD7?=
 =?us-ascii?Q?Q1tQbxqmItFBt3e6fGIwMyMNur9GReM7RNZFNsoP0sz7rw+xQMUZvucHGeP0?=
 =?us-ascii?Q?3e61nbI8wr2UTicoEHnObyRIQuPHGjzTLvUmQTG0N?=
X-Microsoft-Antispam-Message-Info: eMmFSp01PKCgjuhXf7nJUjQl75WEN4Vfq4pIEvSbIVfEryL6M2ft3lK3wFyndcXf7YplYfbqbO4cmqZzhLEspm+Stm3+E7XijXAZZKcYIgKVUn2FiyaWB67zhjJ81r/+J6bSxO/UdJSIbf6jFjflotum0sTOYmzGkm2v0Xw8DXASEMWxSZmC8U0isb8dvXXG
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB0584;6:nJeXPvSwBOQq4+CHXA/xFI9rQQdkbcx9+SnHGY3FYQ8hezXazaP4bf3yP07tXMkvFnlv6GUWtKFOU/wZwIgUqM/23jd2sVMSh+vlDcxt3lUVPfsrd38QdIy6ylBfLCD9pWpjbIdgkGSDmVNr/KFEnsbsQ8Dfl6GxqueTJ7D9nWe2NFYuY7nH8a4a/hv/N7kfyV0bxT9yfagFpT6y/uqEQXYRwaxeQ5R2SBo7qOOPy5AT72zHDJfO10aLLcChtJw/PhjFNZcp4DfdnNu7pIAMstwShv1aJqCpMUTbsvDPnwopVYHBWqjn/K9ftaVuqnuo/jCP+4DnR7WIlRt0+w9eaV0I+bDjKRpSsOVJpkzEY95ulOBhsgTQB6/3M4R+JfumdKm+uNbrw+JqghBYUEIYOeWHhrBL7fx4XQYEIlvMHpXzlrUH/l5+Ex8J0IysTj1DJLsPqEMOX608UI2RADbWRg==;5:gIGCDLOYxOgloPGCYCbFpYDblHjbA6o6OHvpY94UhhLGROYy4WV/ZLajqjojBzMUdss2tIKYetPvPanK+5jMwRdPaCa20Sik08I4kLSW1VX4qsWBCrIHWlEkTfto9066s/I99cWjCLpubaWp0e2VoC7GI+rvrDm8mF8cSd6VH8Q=;24:MaKUWkWxDK89qx0ktU0jkcUx3VItQ8SeHQdeXyLjxUgSq43wdsp9NvGuC3nbK5scAwf3nQLGXBfXiDoM2dkQhf/F7G7TwXjkZHS6LleuK+M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB0584;7:9ksFEXr0yIQGwkdzstAT/KRqkBgiliO56jN9FVCa599UEgkRgxNDaBY2HEexgxCA0rdrM3N9fduhf1SFo5iGMJ10qbqZBtnk5wjRrvS305U4BHID/L14YwkkSqVz0SJ/TfPFchFUFjKSIyR6myL32Od+dQ535lyBewgNM7y/6KsY56Ujb7raqekvjFfaQ5pmzVxmyRd5k7da4kcbvyZ82+1Fp7zKi9nfPRUE98Ty4rT6fv+UNWfd4Ill7iCme8ne
X-MS-Office365-Filtering-Correlation-Id: 8702a4bb-ccb1-4097-e641-08d59f1ac6b1
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 19:39:28.5400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8702a4bb-ccb1-4097-e641-08d59f1ac6b1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB0584
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389328219344129?=
X-GMAIL-MSGID: =?utf-8?q?1597389328219344129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rajan Vaja <rajanv@xilinx.com>

Add documentation to describe Xilinx ZynqMP firmware driver
bindings. Firmware driver provides an interface to firmware
APIs. Interface APIs can be used by any driver to communicate
to PMUFW (Platform Management Unit).

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
new file mode 100644
index 0000000..1b431d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -0,0 +1,29 @@
+-----------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Firmware Interface
+-----------------------------------------------------------------
+
+The zynqmp-firmware node describes the interface to platform firmware.
+ZynqMP has an interface to communicate with secure firmware. Firmware
+driver provides an interface to firmware APIs. Interface APIs can be
+used by any driver to communicate to PMUFW(Platform Management Unit).
+These requests include clock management, pin control, device control,
+power management service, FPGA service and other platform management
+services.
+
+Required properties:
+ - compatible:	Must contain:	"xlnx,zynqmp-firmware"
+ - method:	The method of calling the PM-API firmware layer.
+		Permitted values are:
+		  - "smc" : SMC #0, following the SMCCC
+		  - "hvc" : HVC #0, following the SMCCC
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+	};
+};
-- 
2.7.4
