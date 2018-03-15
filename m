Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbeCOASe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 20:18:34 -0400
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:44887
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751408AbeCOASU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 20:18:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com;
From: York Sun <york.sun@nxp.com>
To: bp@alien8.de
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        York Sun <york.sun@nxp.com>
Subject: [PATCH RFC 2/2] arm64: Update device tree for ls1043a and ls1046a to enable edac driver
Date: Wed, 14 Mar 2018 17:17:47 -0700
Message-Id: <1521073067-24348-2-git-send-email-york.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
References: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.92.81.50]
X-ClientProxiedBy: MWHPR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:301:3b::18) To HE1PR04MB2073.eurprd04.prod.outlook.com
 (2a01:111:e400:7be9::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3004930c-2515-4111-f1b8-08d58a0a3f93
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB2073;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB2073;3:eORQql5rsAu1k9AwodcSqVn01qO9Jqi6xqSLQjRBv73cDf6RiA6d3saCGAF5wuD4OPV/0kasB6iCJQyn6nwSBRXYhDQeR+H9Yd4I4XX0Mc+NVw26+G/pQWma8JpIthAKZxAfN209IF9ItzzpB5zhE7sc2Q+ASfw/SFLfMI1rTPtyc5Nl5M7eYM6dlNOED/uDezg4IN+A1P4ataJqNvNzDwiLD2EHKTtdM/og38pdBuHt/npo5pb2wNEkrEzWOQ+m;25:JMDUMCfHivoZJzRT3Cd++o8CloeM07tcjSToK45lfhUz2zEY7lmrbrqtoz08ONFM+lXbU3bz/75oUfecKRFjQM1EjLPIAwDZNivyg7fB0us3dktlvwYQ7adBKsuTffxzG0+TrMtlUurLyVE5p++3shgQUXK0XPKqnb63kkyAZm7a/oamatQC8hD/jydCNKxhA4+MSxWZ9v7lMiUq1Ut5LT7kE3MZUufZw/eivE0IWJhy11hwnIL0ycbBmRzNO7DtTkQT9R6o8ukZXf6XoX/x3DBhXKD3kqe/zwSrqi6LmPdFa/bq8dgC0y6CRbMCqIrotEj9CW2ZiyXSx1mK/EWIqA==;31:/gBmtDiWtJnwuXlKfQ7tRuvY1QeZv+Kg6SbQhiL1/olY0Wr84Ry5M1WEko0R8bqV9bhF2YGxiz7TkeW73SGnkQzoT416F6hBwzqu8HU2m84LON9pujcKf+KJIupLUbKj0imZLQIbruR+EpkFbws2bARrRpP7pNMyJK6v5WV+ck/ElIrjt+8eBguyxoK3stig6A2jct3q90aLzRM4U0pzhFYuaUxo8qjsfvDAuzoFSZg=
X-MS-TrafficTypeDiagnostic: HE1PR04MB2073:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB2073;20:OhSZTNubHnXWCVgYX7qGnBS766I6u3D6JnPFccuwneLRVN/4aFWdl9bfEq2tDXI/n8w5+MO66T+D2bviuj96QW+eXnXDH8eAWZXFJRfIbpA5Mj0P30yzKx/j5M7/LCfwCjde8YaHAfydTJN0RlQLbHoRiXuFm84u05qYG5GeHanXd4665rwgJhjHUwgvAUMKtXegPfIL7OZXB6aFqHuh53df/36QGGTlzNS4y4CSjg3AygVz5k66zAAIbPGLD5RSI2vsfm/rhLlQzrryiDZOJ4R1rmQ42nC1UhM6zNgwWfSIMde+rHczsAVOpogBtreITHKDeIM0cdIbbXF21cuPZGnfieQmE5WWNK5r26Z+WAZxZjxAHiBmgUbsBV7MB8aehJFa8LlileVi7mzLJ186NgywpNHGZq5L08cktC4ckxrNyxqReqFjie8QPVeckS3rPSviBXP/1L776mShGvIkp5kWcItdeeizE64j58w7yHAhkIoPTrIKvccyIpKSnpRR;4:SID62RtrYHPxWe+oJjgrsfOK+MJElSsum35CMTb5RyS0TtLep3rvnQngaJfpwPB8NItx89FHGTT9nHmW/UoKvBTlJx4l2jQYUnWr/cBeLEKbMDH0CDYzZjDMCCQyBfO9IXzgP+OJR8a0ey8JR4fX9XjcuuRSRvt9L+J0Pz3xvfajg5fIBZty9LhSlZa1e3ek0l8fRwvUxcCwNzLc6g/1gMP8bK+IpgHo8lR8AfkR/lZrwBtb682zZd1Od1j5RM6uelt0/+/44V/0bo/VZDvtIT9Jiixd2Evgx1lhXxIJumEjTPeT6kAAFVFefkM8t5gT
X-Microsoft-Antispam-PRVS: <HE1PR04MB207315CDE8CCDAF3CBEEC9639AD00@HE1PR04MB2073.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR04MB2073;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB2073;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(376002)(366004)(39860400002)(346002)(396003)(199004)(189003)(36756003)(6506007)(386003)(53936002)(97736004)(47776003)(2906002)(2950100002)(26005)(16526019)(6116002)(68736007)(52116002)(51416003)(186003)(3846002)(6512007)(478600001)(105586002)(25786009)(316002)(76176011)(66066001)(6916009)(16586007)(86362001)(4326008)(106356001)(575784001)(50226002)(5660300001)(2351001)(8676002)(6666003)(81166006)(48376002)(2361001)(81156014)(305945005)(7736002)(50466002)(8936002)(6486002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB2073;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB2073;23:YUyQbOK3iscR75TaaVo61v+W29UEnQVTwKlECLApc?=
 =?us-ascii?Q?qsBdf6rdP41ibwNcqQPJTGsGW8uBJUfzApjOtnd19OCh8kw4EUhU452g2P0F?=
 =?us-ascii?Q?nVwg0S+OcZD8HibKXBjJuqaEY6aBeHLRDFAMwzLzsYtm2A5wtUfboe/XPS1P?=
 =?us-ascii?Q?xEFJyjmubEYp7RZDdvSK2z+vDSLmMBW2SKN8FLyMAvhn9MJ7AzwhhGEv04U8?=
 =?us-ascii?Q?61QXRjeZzZBYoRhF7TUIAAAHrt5MhPsLXUusCc3URF6iHCh6EaT6Ip2vtjix?=
 =?us-ascii?Q?J7Q5SDmcILKIY4a4FknQj1BYIvHHQ/H3tHFF3qc4SZaKNsz27HHH7e3sm7XG?=
 =?us-ascii?Q?RSDMIztEEJ0TzrMd7HeI4I+4lxVtpcwzZbLNMYD/jVo/V86fGhk/7I5PbEKq?=
 =?us-ascii?Q?6PuxFBvM0+epfbSJ2ECRyjnEvO2E9s740lrzmrf184ALZhkyCE2Gt7gfCZW/?=
 =?us-ascii?Q?2+h0/36k9J+bnsAQ+oGrR/+N/K+c4xWFBvrXogL5FrLLYpz43yYTxWPdvqah?=
 =?us-ascii?Q?mdBgscpjeTP+j8WngboR5+dQSBjCUM0WEIe0fqDPOiMaitq9PcrYyEjQ6sAn?=
 =?us-ascii?Q?8ZJy+YJopF3EsBbKSzg9kNKKKzx64dZ2B+tFYlW5xG6SAebZ4K5mGozEd9qH?=
 =?us-ascii?Q?Cdj3uEjYUyNawC3WprNZ6TwucQFR4IhCAgffjvl6MyJq5KoHk6Obrlo71sne?=
 =?us-ascii?Q?XxaH+NCmdII+FAlnmROFOAbIlQEc8KPUSw85E2aaAOAM23a/YTQSAIcI+Rhm?=
 =?us-ascii?Q?De2Dqfu/nyUwd4xA4YWzO2GzY72g/nUBQdmJnrbY5jRQTzRiC+4h2VNpFz6D?=
 =?us-ascii?Q?BNehPhlDsoKkKKHICTUA5YSE3qrmgQ/RRypEzk3MyyjSpsUjAGqCvysmR9+n?=
 =?us-ascii?Q?iq1HWU3GGgeXJQOcv0G6yY6EOx8T4WaVK5kgomWuAM0bf4wk3d/L39RAyNgD?=
 =?us-ascii?Q?ekREvMlorL1jMd0VymO9gwitvE9zAwhTYIAzcARq6vDRpUs15PPNPsOdmape?=
 =?us-ascii?Q?vDE0mmWMS02gWJBXwF3uuTFH6Pd/wfCu+ifxf7KpzD1KuhG/kVgwd/ANSEY/?=
 =?us-ascii?Q?d+m3qF9mI1ccKnJKr9tA44fFESVbjOzLoOiODoA+LsP6SdGaXALDYWZh087w?=
 =?us-ascii?Q?B7Evd3PGyLxx2uG2NcNDbtY1d9ulcp7UNHwkVPF5zlPg5kjiDQqcJqXNZ8Cq?=
 =?us-ascii?Q?t/BNLU0akUvg+j5tZWRYgQRoAB4J10QS57i?=
X-Microsoft-Antispam-Message-Info: xjrWfhz8VKwXVY+90q1hUCMxnp+JMENPJOtHLo3RIYrLoakBWrCpoIUFGePuF9QkEIzvNfKwcEKXUBfegXmvpMWeoi10is/X7awjuidXtQWyX/TMho0OwBVIEI2wa9YlSX3iu11Vn0JIH3PPwQ98UauyyQRAZ4lXtvDpsolqlkBRcGynMm9tS8FD4A7L2okU
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB2073;6:GCp3JaryoOb3BhHnFB4foKlvubZ3O0+7afhHYxx9ov9h4JbpBAJHPPYTS6541VrVyQgJ23p5cIYE9yY+BDwizvgHKIE6ETnM2UnaDHrFVtTWocs9QCmUm4epSCdTI1g09sHEcn5/1YRUrQu/6q8xyAq7Wa+y0dM+2Rj+PwFJzxABCglK1DUmjo41uPxQTOGButzGkG5xjwcJPBpKhKN2a8v4w1l6HdeEzpNbr2QR1N+HBoOSvXrfbw32kwMBqnV5a9H6H3AaSspUgTPEPTnXYuX/WDCPDMPWg1lqDWz/nSLGWSB297jzVDk3GMBbeYLziTT9GEbQrVSyvnxM3OQyROTV1wvczDlvfUu/Lypwcmk=;5:T2HQgo2/eb7+BHENVXBCEx/XVyi6KlICVebKoIYFpyf9LV8qDJs7l1HajMaF8Waa+OJmtQzd0yJLZTBw+6VNphzAJ5dGpqV4toHII5wmyF0pHfP5H1IS2UlnFzFRm8saRRqahILQac8K3/N0pi1V5nI7g8wpHLjcrvohqlruf/4=;24:+Eb4D+SXTBnIm9h5xkgX8bGBxqsf1LdzJx99BlT5xR07WitV8B0zxFIN8rxQuk2dilLgi/QeGOtYHWqMoWTiKcStx3zCcr1Qmg+pBT4Etg4=;7:KegBHER9Jdxsc/ZqlEFpq5PiOhUK7xn3qlMO5X9a5R4p/HFWOIZxxuqfeUbAiGPzvj4UFw5Txrx6JLW2AKrQaG8URwKy3/tzfCQgewRl87DbxBjOwkpVx6qCFE0mpBVJS6WZ+YXkFqKnIm38ol2k3YBxD09eatK40FwGjjCKNM4QBN8XyV8w7MAMSMHRQkublNORdQiUEd9ClLIyLAN8DODjsv/r9tc/1PwnhKL0GXxh8ASq7UXXceVhh8n9f2zf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 00:18:14.9226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3004930c-2515-4111-f1b8-08d58a0a3f93
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB2073
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add edac node to enable error detection for L1 and L2 cache.

Signed-off-by: York Sun <york.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 9 +++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index d16b9cc..4fa14db 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -749,6 +749,15 @@
 		};
 	};
 
+	edac-a53 {
+		compatible = "arm,cortex-a53-edac";
+		cpus = <&cpu0>,
+		       <&cpu1>,
+		       <&cpu2>,
+		       <&cpu3>;
+		interrupts = <0 108 0x4>;
+	};
+
 };
 
 #include "qoriq-qman-portals.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index c8ff0ba..9095d48 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -689,6 +689,15 @@
 			no-map;
 		};
 	};
+
+	edac-a57 {
+		compatible = "arm,cortex-a57-edac";
+		cpus = <&cpu0>,
+		       <&cpu1>,
+		       <&cpu2>,
+		       <&cpu3>;
+		interrupts = <0 108 0x4>;
+	};
 };
 
 #include "qoriq-qman-portals.dtsi"
-- 
2.7.4
