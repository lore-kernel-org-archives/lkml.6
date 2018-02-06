Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AH8x2256XO+3WwZr6p5m7ADgNWyvfBbrznNJxqGQNtuMxySt9N4j/aBs7z9Z1Q1AXnmLeEm85GZH
ARC-Seal: i=1; a=rsa-sha256; t=1517957703; cv=none;
        d=google.com; s=arc-20160816;
        b=Po2FZdlkL/OBkojlvNOefMYThtVHEu3Edyye2JlNAc+vQQ32/wvl09ZMuauUV0eBlD
         hERkk95PLTz7kSeN5nqkaiFjPwZ3kupkl11AgCYkcZhWO3oTElJaNSbjeBnUVxiND5VN
         B2Vw2/2sAFoZ/5F6LipzzXZ/ZImsJrD9jS7Tf7uxaTs7uwS3Mh14Z/AheR0/l0QNxYaf
         DHdqRKvVFdEsltmbpazb6APgbhkMsZkfrmHhKCaV8B3GyIn2rZfP12UyZLuJuECPzC8b
         PmVRlL9UAwXDlI/whDA982fK6gJh4tYwHpwd0LD5dKv+BC8SPw9b1MfJw+fK0N2PQhbD
         X+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=9Tj3mfAGlWlD3ATWIoow8xXHFFAKn6vcqJrP6n3uu5s=;
        b=BMqE9N9SEXHOu5r/ec2Lr9ekFouLeXZ7zVz8Lh4s+PyZfckIXqYVmhI4rGx9bOX6E7
         SnUtkx/IxbU4PzthYB0XteRwwUeCugZJAa4iWcXy8MhfGSGlvTSt6IRM9z0YFlgFLiVT
         SyNe5CakKA5twxSJ9tgkGWEEBhJHVkV8lmUv/QSXa8x0pWSf5s5ZOzblqUraVAeL/LQ/
         Rk44FFWsz0wCUATLRqx9it+2frBjh4A0yLn1VsTrI+ijtwQjG+7S9kx7XqRF9XLxNOPf
         9ltBjdIlxXuRxJORU8wTMKYTW8BNipKwlmLdHYL/3CMTCZIgn/wi4eZA1z7UOXgHIr19
         uAAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=Cv9qwzp/;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.40.43 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=Cv9qwzp/;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.40.43 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
	<gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
	<sudeep.holla@arm.com>, <hkallweit1@gmail.com>, <keescook@chromium.org>,
	<dmitry.torokhov@gmail.com>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>, Rajan Vaja
	<rajanv@xilinx.com>
Subject: [PATCH v4 1/4] dt-bindings: firmware: Add bindings for ZynqMP firmware
Date: Tue, 6 Feb 2018 14:54:20 -0800
Message-ID: <1517957663-16668-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517957663-16668-1-git-send-email-jollys@xilinx.com>
References: <1517957663-16668-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(77096007)(39060400002)(76176011)(26005)(5660300001)(54906003)(110136005)(107886003)(316002)(186003)(7696005)(51416003)(81166006)(336011)(7416002)(8936002)(81156014)(356003)(8676002)(4326008)(47776003)(9786002)(16586007)(106466001)(2201001)(2950100002)(6666003)(50226002)(305945005)(63266004)(48376002)(50466002)(36386004)(36756003)(106002)(2906002)(72206003)(478600001)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB3378;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT027;1:psYAuDywfxkqQQbh9XqSJ8aT8YrJf7pNLWAQ9SiWta7D/AfTEupClsNwKEg9hAUlGYnJXsM7MDuB3nMUKkLvTyy6e6/VoxVBQdu3DmZyQH7JyXOe0Xy7yTfUd//7wXwO
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1084e839-d309-484f-b457-08d56db4a738
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060);SRVR:BN6PR02MB3378;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3378;3:A2t+5CzA3Uv6o1uLDFiXGAaEdtx1M5aEaHmgDSZoob/FPhgIh72YChXZNcjz0Qt+iel/ohq4LBk8Q9/oMMBWXv2vjvzfp/MjFSc8p5XsUsl5uNyD72o4Jg6D1CKLLL6FCRiPhPdXNYia3rhvw8HzWA/JXCsA27QK7rlJ73sR/7xLbfdJpGFYjg4jSLAAS5MRbug7isisj+1nySuMigpYoxGq4Daxmk0X4SqDMbIB0+8rayPM4SUM/RHvBz+HFXKnjT+egq4CV4fYkUbc9zlm1KhZVpxJ4abJcKz9yduWN/43g2BAa/ZNLZph0VTQKWwCr0zxEWz4ax9DsyS0qkPgv4dJjMzCvBvWoZzGBGE+u7s=;25:k4EloALezjuCxbIA++9pR0G+wZTtUgBHG/Hd6T/cYaOo2GPPE3r1Cia10YfGJ7q/bLjCEEI75WEf1zS/D0STzbipd3gK7BouzwcHIymJw9Sg0APl9hxM7/h+lEVNtRXXEcPVyIjoebCvmJlO3So/tWqmhk3axeCN62aqeyQ+bbtMBV1WSZ/L2kmxvIUqmixig4Y6L5mPk+5hL3vd89dpW/MfQlo9XJrO+MYvXFTX38zN/WmHFT+V1TNLj8RTU9svPc7KkyA12qmWRyToNjjXr+SvrBOoin+g7yNEaUrYR5mQayRBKZeyE1Y5+UFLL8i8UZd3xTQbbpHjdpvumkjzCA==
X-MS-TrafficTypeDiagnostic: BN6PR02MB3378:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3378;31:LPfZDzO6mYncXdH7xRKrcmXgu/a97U6Qiujh+LkONszcPIDNbXQ/AY7XFTlm6fE7MeQgQbf0iZcD34uXN3/G945H33U0MF/sIIQ6VFhF8YyJaIfVI2n1dVbFHOIsLIldp31zQPf6tmUqaNzAbfwGLI6cWhUvwel2jde3UPzdHHQ4cVtxd6C8uzlZTtCJOGtCjplhrRP49cfoaobm/AGeKG4oQEwDQlXWJyNiOjW0xak=;20:8Rr2vr5UiTF+sG+aX4tHjo8qK5ZVO6kYB4ItXLVOwRB8oDTqZZfBt0XUWsW6X8vIsKG6H+9Rz8LNA8Rs1tR53G5CzssikXIpAvkVZBq/3qf5awnY6mkGVqU11ALgm39DVaUH9Kxlidqr2HE53h6kY6j/GvyZ38ejusLxufINEruO1hA/bIw/wyaS7LCXRS34/ilM0XIoml1M8gIGkZW5sZN6NaSX04YmNW6hN7U67WJ6CPrvfcMs7vEOhLvmfELwg3JXm7I+fNtd2Sy3KQX0lahvVv8NEBQR0eGP4+AUibtcpF35kvQIQtbF+tqGooc8rEX4SMQc7KsWOpaz+8Un3i2DOPruJj1Bpvw1Axvmka73GSEEuYWM67s51g4nk33iqtvdE+9FB+iPfrFDT6rbjKiNHhg+MQ9stPYQm9MNcYcVb92fAzsBBIovuIiCM9lraWe9y4hFGD+8tKN7DweTi1dvIYwO5yC5hn0zuhMM0Xuyet/IpyBC2rRJnzx510mP
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB3378D49731BB6B4185A4874DB8FD0@BN6PR02MB3378.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR02MB3378;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB3378;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3378;4:do93WthtdPrbJMZkAXH6QuqD5f6dOE4DNr9XSKYk3d9NzdSEe2rCzqLYepdMhf8pK3Ha3odpyfiLwufln3E4ouWmeJtlhGtFN6Dr9YPHlQZA5oxEt+I7IU54MauYTaYl5WkkMxz53JxgEexssoyerX3TQSUCIGGrmF9K48/1CG6BfwEhiywkqGd+fPlYHqM+Ur2a0U2TWfHDAAnYX5HMx2Kd+rE/263OZUb7mdKt1l9oX9pyBjlRyErZcwyhbdfkdipbCrd3aBdVvVU3dOa1mcBti+8iJlLOBf5eNQPH0jkDPYAeACLbRIFpwdaw5jB4
X-Forefront-PRVS: 0575F81B58
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB3378;23:qyPyFbUJ8zb/qadTN7W1T4vPp5198h+hDpH/yiDFQ?=
 =?us-ascii?Q?Wlw17HT+eDr83c4ZMFRWr+5wi+kJiK/pY73DfE1ATfKpCezKjxiSZqa19uGc?=
 =?us-ascii?Q?+LgMQe/sTBUOeawA3kq1LW8vM5dBtXVluJ2rtEcfMIble7UxdRzVh0bJbcO0?=
 =?us-ascii?Q?AqcTC5Urtl/U4jhb9ahsqCz7MdCafkFjQ6zGjSdWdOBco96t3syPDw9vPVfX?=
 =?us-ascii?Q?bM1a0/U38EdQRppZ11p7OBp06NgCgU78joHjwKr9b1NwkrgjOnhhBoJ7gknB?=
 =?us-ascii?Q?ZmEakO9A9LySRjbQL6f/o/YRnjEEgblPeL2Q+wE9tN5DSBGSjklHndkbkcr2?=
 =?us-ascii?Q?FSqmPl391Vy67p5wTpBQ6ECAUi5JkA7uJZeRebSohsIjs/hDRMekePU28ChU?=
 =?us-ascii?Q?xvNiZRT5AK2ZnTN3Zr/BKnkvWqm1Qbs6BpUT6Ej3nlRfIh72JRsbLwGrOwCu?=
 =?us-ascii?Q?PFsQoCEDMXTXLH0fCsTkML58aoaCKJlXp4iN5YQUnLu0OJ02b0A9CfIbOJsV?=
 =?us-ascii?Q?dbyvP8D088vbYSHFVQ7KDrNqkbn5jXGT8Q9RzDDri3EaKBpUbfni3ZMP0Hgt?=
 =?us-ascii?Q?lYmcF6DCk2zGURcuQppE6jaqJ0ybNXa1gEEVW5rhuwcnYQJrDLoscX+wzL/C?=
 =?us-ascii?Q?9FmVG5kuaYyET2BBI1UF4E21HoBnxsqJGKANZtvVdZ97v2knCNa+vBFCR5Rt?=
 =?us-ascii?Q?4VlLJzdNKlpTz+ZXNCevjTUu7RdzfAjZKvOOfD8+fwvrekWQukzDKI84Nlfw?=
 =?us-ascii?Q?XQFZp3lYBV/NFKpn4pV75dLAcIsZ/1Uwa7QtOsGvzkca/EIhPRFBPo1Hgbvx?=
 =?us-ascii?Q?JZloSK7/ogkQsWdIlTuiDG0eyC74+zxoePW+1MchwBbkwvT7HbilGZXXBsKL?=
 =?us-ascii?Q?VM2Mi4uerkNjKad34zQ/EkK8nRWXZr8vfy/NT0bBnqvHIgAFDNiP3QT3vCrf?=
 =?us-ascii?Q?CSVOXpfzi44Y2xroaAyS4UO6NatZjAx1q2PTVUhP7+CojqCvkTb45jJHIk+q?=
 =?us-ascii?Q?MQy4HxBGohVYWbRjC/C0hmQB3MFzCqH/fALHRtiPP1kc3F5bnD4j27V8iYMl?=
 =?us-ascii?Q?sthfock78tbNtSw022XS+axRnlUll7g16IHlnDYge/XZ2vPnZfMvSf/Hs8fs?=
 =?us-ascii?Q?N6ls1rvDVPO6lIAkzM7F7YeGXaLycSU?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3378;6:S6gvDnleZFV8aah3cbzqlt+EF+BPqXU5o7gbhPP0HPQyFvD74gchyadaajrWwqbjjH5Ru8BEvzgMU+E4gBf4Qw4HLc6cid1ARkNaTfsTp6ftcCNBpL2yUKTAezBr8c9prptGxnPMTdl31Y0WN26TCkRWfRcjErkEFDDNEEss2QSPgKKDYc+4WoeNEbswnqlXLOFC96XIsAseUVNrpej1/pCGqO6JagM+rHai2XTTgHl6hSxKfpyq6MMXLvSFmI+oP2N+mna77+kX294B5N26pPc88zQsqLvNniAtVqnPvTC22ZrqymAHOOIjT30j8OmlJ8G/6fpfw00nJ8YCXq903ox9uX/UHlpAOeYgl3uyME0=;5:BUErBaqoT+SiE7A3wEP8HSgE1hEe2H+5+NAUo/wu4Hf4iSepV91meQAOi5v1Pmda78BMl4rm18TmcDIU6K1SnbLw964k5+spfUZIEedchYQsp/E+5st64JtfNP7r3T9HsXOVETLZz1POgLHgUSqh2N5h2f80rEr7Y79mgOn/9BY=;24:D459TVQiIoG4fArX8onFTjDblADjuYQzVXGvcqTwyJ6q8sQByN6uO1TVzJOSqap4e9mY4PaOzgYgZTkiWrMVgojdnk5Bo8ec3749mseQ/oQ=;7:Jy5C2aLlf5ESUu6xhzKF3oH0guTjctLWPuchpzqb5YokPJdtCAtebKsNA/f7ub+GMtsqGguiQgKlC915Y1+Lrp/s8HxvBWLOgeamdHVpX14H7s9FbDJr+XI6MxYfL7s+J1IYqPsZz6XJusOTCbU4TyU8R6dLAoI21mHyl3uxebsx4bXD1BqHZ9CTW8Kpi46Uffwcw1JHWLs4OO8qTAUIUbtgocyLJsq/+b8qzXaxodSrEEjiKnstu8ijZQf+lta9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2018 22:55:00.7970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1084e839-d309-484f-b457-08d56db4a738
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3378
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591694016774801162?=
X-GMAIL-MSGID: =?utf-8?q?1591694016774801162?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add documentation to describe Xilinx ZynqMP firmware driver
bindings. Firmware driver provides an interface to firmware
APIs. Interface APIs can be used by any driver to communicate
to PMUFW (Platform Management Unit).

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
new file mode 100644
index 0000000..99434ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -0,0 +1,24 @@
+Xilinx Zynq MPSoC Firmware Device Tree Bindings
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
+ - compatible:	Must contain:  "xlnx,zynqmp-firmware"
+ - method:	The method of calling the PM-API firmware layer.
+		Permitted values are:
+		  - "smc" : SMC #0, following the SMCCC
+		  - "hvc" : HVC #0, following the SMCCC
+
+Examples:
+	firmware {
+		zynqmp_firmware: zynqmp-firmware {
+			compatible = "xlnx,zynqmp-firmware";
+			method = "smc";
+		};
+	};
-- 
2.7.4
