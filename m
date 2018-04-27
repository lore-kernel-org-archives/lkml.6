Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932295AbeD0HZW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:25:22 -0400
Received: from mail-ve1eur01on0064.outbound.protection.outlook.com ([104.47.1.64]:24544
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757469AbeD0HZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:25:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, haibo.chen@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6sx-sabreauto: add egalax touch screen support
Date: Fri, 27 Apr 2018 15:20:50 +0800
Message-Id: <1524813650-19241-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TYAPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:404:28::33) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:0vPDyi5lrTzqieZRCjogusREvHclGWqWhERqr5+Wji12P18umLc8pQaPIZ/yQRl7OdTPaTzw9/KyexglKd10bgp3yicjTUOttRwPjLTJd02XQW6Xh/AaEeqYaR9OvQnNGvOwmqb/klfT+xox89eSvwTejBLkU8w9P3GrWa7MPYA4P0RyFvGHdU09Co2SqoeyzdygBpViw/yo3HjDMOeiUEwwzVmvB1F1EfCbzcTEG4ywCv74skfN7g+Bg2fL4S93;25:PBzFQEoIRG4edDy0QlcJsPtg2g0FDlSoNrVU/s2bguHh637v8EHCEK6Un3qxcH/MzYaIeQV/CZGHtJbk0eLIZR2HfbJVHF4sc/x2IMQeVNwLtt7IUBuZOFspR4TCDmkHLO/MrxX75IwmajnLMvjTRpQsncfpvnt3JC52i4uPM2gKzDGFoznT92Vt4SkegwjTZkrP78IRVnMETUd0pDWCR+7c8yoziSwJzLocAYrMvVRgAOYO7Fgr9W4FiKKSqutZI5F9NqHmFa9fZ06nFvz4ZCmmOwgVRJgljnd0ynv3AHKrg96taa1QQf6Rg57bDUgzcfjBuqOa2+pchKb2JNLmGg==;31:BuUzQYIhkrkrFCpZLo1GMfIpaoUgDB/JqmLnDh/ElcMZdSJJKkQoi8e21xz4ULNG5uq3VGCD5klMjyG6JQFkhweeqdd/nMmDm1HZki+RoMRI6RyUvrByo2O9enty/ufglLjcvqDS1QPSYiS890Hcp0dqeW8FQW7FncXNKXzcvQD/H+ED6iKZ2nXpaRXXqqq2XGM3zidRHLrJGvzAwpVLW19rBYjHsmGoD6mmDFjCGAI=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:XDqWo4I2K5H4eFWP+Z8FSJ+d8qnyp8C/zfN78KGmWiPDdwZ36JS72nk7ygR0MmWVK/mmrKLbZuwtvBPMO7THD44FQuF1xBLcJffJ3xJqwQzrGzeo6I2d8zGSoN3eEclWQn7UFoExhuLlzGnZnDlWvTicC6cRFXN0ikUoIF2sF3D2VbvbB7rbHe+1PI0L9Xvf52fn8rctIvTxYOUXr7xk+8gB+d0sJrB9y0UgVv6nIBFyGHpgh1KCMJMKxzjiaZM+9XxlKG/I6wKbnA3I+vQMMc58Z1PmQASiZBdZ6h4C26EFbrdEdmjR2jKyuNSiHygkHTTD5ZQvwiGrhrA6W3WjmOOboqNHfOzSgkTqNLul/uiEXZjojsK5ZgZ/9e08QbNVwP7zaOFPGdGjoXalk+NE/HuW2XRtxh7VP4iAf0h4DPco82leHsWNSA6ANX9VXuXgewEhWWJL2gLHUD3b3hAd7jzWlSzeLZcF6VbAptUf1hJtFQWlr0UYCRSaq2CUqpkA;4:E+B62wQgUoeSA4K03+9voeDlmjSw44dXC43z0ME4lF1RvLaJspEmEKJVPrKPs0GOsUGZQg/+bzDac8ecCkU9XhbL8uKFum3BFn90Oeh1sxE8bymE1kybrY2DOPjwucP7qm12G8dhPA6g0nmaJ2eQNJ4TxZvsn1XcOEyh6d6pXgegXbe2wZ86qL1AnIvP5tPSApR3Xpg1bYIaxFlsxzQWYkoAHbsBiiiyDa1rgqhwU76o4DHr9j49RX6hOQL3QmmJ9wL1judsyzw7tgqiGU5FLz4SdngVwU9vBbo8cohfkBlujg/o5BHZwFpbFxF9yWAJB305xIvrz9ugGRFsFE6CmlaMKYgnQu14dMn7Y3Wr4E4=
X-Microsoft-Antispam-PRVS: <HE1PR04MB132404F92112ED2F5A82E602F58D0@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39380400002)(346002)(39860400002)(396003)(199004)(189003)(305945005)(6512007)(6666003)(4326008)(53936002)(16526019)(6506007)(2906002)(386003)(3846002)(6116002)(7736002)(6636002)(26005)(86362001)(50466002)(68736007)(186003)(36756003)(47776003)(81166006)(81156014)(51416003)(8676002)(52116002)(97736004)(66066001)(16586007)(8936002)(1857600001)(316002)(48376002)(2616005)(486006)(6486002)(956004)(476003)(105586002)(5660300001)(106356001)(50226002)(25786009)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:UJfdUDh/wZXl9dPoYpteLjmPWnYkG2Wi2xjWwiqGv?=
 =?us-ascii?Q?eGOo1CJSb4xZX08DZ5I00WCdeAasgDJpp0VTUwjGz1Yyrm+X1hD4dxrO7D51?=
 =?us-ascii?Q?qqCVTN7ion82jArv6lE3ZTYqhaOFpcZ2vsvSmGkzAEJVU5O7pE9NNBWp4AsD?=
 =?us-ascii?Q?2UxsEVINNg5aKKG+EWvxujxD2ct6ZG8yCCJqDNXqZ8/QD74m7ducApb6OwOg?=
 =?us-ascii?Q?8/aTitXQF45eskatBWl6o1Ks+U2wC9OyxBsy3eA8bQFlme2rZeZAseJDjL+Q?=
 =?us-ascii?Q?RZdMvBdAzwdgU/xbpdgHyK4DOsxGfe0GP58prXXKjXjTpSWj7gBjv04op6+t?=
 =?us-ascii?Q?lxPYFpnsFnhTRMId2j9elOdCq5Nxcf2cbcTtekuKEW4MTgzQmvQ0gWDOsm6L?=
 =?us-ascii?Q?e0gLJBEJOjd32buXoEr6bLT5CYvL1tOpQzIE7E8LauOHR7JUtPgz8qNIqix6?=
 =?us-ascii?Q?9yh/mcFyCbPluqNvQhJyfbGJ0SXSiJupxWV64zV8SbuHuAygx4CkBpJRjgKT?=
 =?us-ascii?Q?z7balpqdTmCjQ7mBnsMYMVuzNbWGxIzEeDFSsv8z10kp4h6i+kh7KS8spZA3?=
 =?us-ascii?Q?MsjT2t8vxxPcrpRa6CB4VrcMLF1e5++Z0jzPEw0B3oH8/S1LjScRBdOQS/Lr?=
 =?us-ascii?Q?bTzwiVmsUARCXG4enLNu+aoIQYcl6xzfjkO9Sn7VeoVu5ALwZJWxsd9ETLrl?=
 =?us-ascii?Q?XRmnyIVJ+sZRTyoMQkYD6oraqoS5yT4PIqO9w5lh3gP0wUcY8SiOmnBF6/LY?=
 =?us-ascii?Q?sQ5fbCBFfcsdu/xEe3oHf5xLLP9/t4/QlPpa1XhLbxdCBsGtg+cNyo9fEqD0?=
 =?us-ascii?Q?dEoAwLHTdG7exOIKcPmFkdnGgt2GseYp1TedcSOj7ab6Ude2kcKDWmChgBXV?=
 =?us-ascii?Q?RS+s6isV3uIkkCOAn+RuSynMDmqa1Pl1rU+4CxWXeKRWAJlkAfcPYzdLNmat?=
 =?us-ascii?Q?B8NAj/fgSigKcE2JdgsnxfOT4dAiTRGXljWWwTv0JU/3yBGDPnRMKP3E+nZm?=
 =?us-ascii?Q?hpBFwQE6j8ceY5rdHPlsCpwC7nK3ePPFt9o6ts7L19pYk8DvnnorCsjDn2Wj?=
 =?us-ascii?Q?FvLu7vmr2AuMS8jLnsqNvcnI6j+zR1WNxUfacm9SIDXZrlWUvnGJbhNmmIbv?=
 =?us-ascii?Q?ya+vfw2jnz1Q5AAz+YC+qMYw4ps2t6dOYrBBUNd0+O3EA0EDYzwmQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: u5mPc6YU6Z7AVXahQ368kbVfeVHd+xkhxUM0cUfeClZ35/vDguKpUqT8aZ8QTclhbuNEFBs0SQi+QbURnw1QS3P5C/yi5oQBgwhOOuD3G3vkIckUOnHJO/yA/kUWFPiioP2qJYqy3gjBRzGzRxIJtZ4aMKfZ8fAVjTnzq17S/lOgelqAtuLxc8zzV2G/49fb
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:e1j3P4qCgOK4crw0nPFPLghNC+dvGLbxPrb4cJcc22gLH6z1jLYzudTgNkjZPO3vTenKtkbhOKcqbv7o09BSnxVZqqz795ck9QLu4zp1SP3VxkcT2cNczOVtrc9X/l7s7dRpPfp79rXCz0Tlu8UBbMRLets/YNdJpZ07BAn65WIBUnSjIMxgmR8/U7mCofFjM5AnIzsAq2pqJ9EOXHmcbTQVk7NabePGB3pMrG0H2z+dicbq6YpUTKSk0fW3WRwMZVkd9sazIyTv6B+LFPD6lFnV0A03re5v6J1tKIgWu+zONp97z949SvFWyYE54k4vu6hpoCFxj2iaQiNa/jtOm8bHPaM5nktokI5VW8M85FmhX9C25H1yoLwig7ot/zZ1Gr+PrFoI7RZcBB3kLH3V5IwCL1jMdikqeuiva6uJSk+y2Tih1Q6dnjqmbKam0IXkVr0GrrOL8v4jLZWbHzfE9g==;5:Xs3XwPUpaAKyKLzdzmSmvyB1nN6bqlS/PkAY1uG7GFT+WH3n6w9fIYztR4qKGFmxhv1VGm5kDrl04CFgRopk0e9WHRnDAzRD8nr3a4ZBWkvHnyhucRHCHnpec0Q1OE8V1TUP5ClW9vCBECEumyz4vzKjILMZu+Pv4hKsDWfd960=;24:eamI+W7VdbrJQgSEPTomg4VqYaLH5F+q1slhyH00Dy9rkpcZhqby2li9KHQnj9JUmbTQjC0e1rii1uWZQBqmzzDgPx098EjhayPHCz/88+Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:b8Z9vWgXR4eehgMlXVIJaH1wMviNCDaCcFbXFZbGVU94l4mGsc+BfuxHrCD0xs+gd6lMDPQUj38ckUEbhvGposTH1+fLuWBE4FHWe/xPARRghaE+6LJqzd8f6iP2mzZ3DDlfiVvQBsvNL/UHaZD2ZFYVGUsAdSXcHoKwiFvhYSFNN/GMEwt/m1zGWz1bnFnk8t+ltqBCnk717HYqK4zU8dPLh1rFd/0hAh4rWIuZ7Cz5C4Xx1unfaoJkYh3n8K0g
X-MS-Office365-Filtering-Correlation-Id: 340c5168-6e5c-4f09-96df-08d5ac1005ca
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 07:25:11.4877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 340c5168-6e5c-4f09-96df-08d5ac1005ca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Add egalax touch screen support on i2c2 bus.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
this patch is based on patch (ARM: dts: imx6sx-sabreauto: add debug LED support) I sent out for review.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 6b94f24..2f6e474 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -131,6 +131,12 @@
 &iomuxc {
 	imx6x-sabreauto {
 
+		pinctrl_egalax_int: egalax_intgrp {
+			fsl,pins = <
+				MX6SX_PAD_SD4_RESET_B__GPIO6_IO_22      0x80000000
+			>;
+		};
+
 		pinctrl_led: ledgrp {
 			fsl,pins = <
 				MX6SX_PAD_CSI_PIXCLK__GPIO1_IO_24 0x17059
@@ -274,6 +280,16 @@
 	pinctrl-0 = <&pinctrl_i2c2_1>;
 	status = "okay";
 
+	egalax_ts@04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_egalax_int>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-gpios = <&gpio6 22 GPIO_ACTIVE_HIGH>;
+	};
+
 	max7322: gpio@68 {
 		compatible = "maxim,max7322";
 		reg = <0x68>;
-- 
2.7.4
