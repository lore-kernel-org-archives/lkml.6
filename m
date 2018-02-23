Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbeBWGmc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 01:42:32 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:32950 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeBWGln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 01:41:43 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180223064141epoutp01a15a038b38bf564bf565d41b720f5362~V4Tz-8rVm3189731897epoutp01U
X-AuditID: b6c32a46-3c1ff70000001029-40-5a8fb7a4541e
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        manabian@gmail.com, dinguyen@kernel.org, will.deacon@arm.com,
        xuwei5@hisilicon.com, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 6/6] arm64: dts: hi3660: remove 'num-slots' property for
 dwmmc
Date: Fri, 23 Feb 2018 15:41:38 +0900
Message-id: <20180223064138.18401-6-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.15.1
In-reply-to: <20180223064138.18401-1-jh80.chung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7bCmue7S7f1RBu/SLeYfOcdqcfT8biaL
        G7/aWC0u75rDZnHkfz+jxe7r5xgtll6/yGTRuvcIu8XxteEWLz+eYLF4cnQKswO3x5p5axg9
        ds66y+7xeO5Gdo9NqzrZPO5c28Pm0bdlFaPH501yAexRqTYZqYkpqUUKqXnJ+SmZeem2St7B
        8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QCcqKZQl5pQChQISi4uV9O1sivJLS1IVMvKL
        S2yVog0NjfQMDcz1jIyM9EyMY62MTIFKElIzpr78zVpwl72iefVGlgbGFWxdjJwcEgImEg/m
        97F0MXJxCAnsYJQ4PXcKG4TznVHifP8puKol3bOhqjYwSrw9fQCq6gejxKyL65hAqtgEdCS2
        fzsOZosIRErMX3WYGaSIWeAIo8Tlh7eZQRLCAgESc7a1gtksAqoSS/Y0MoLYvALWEqt2PGKE
        WCcvMWFLEwuIzSlgIzHhzwuw1RICO9gk5jfsYYEocpF4u6iDFcIWlnh1fAs7hC0t8WzVRqhB
        7YwSZ2cLQzRPYZRYMaObCSJhLPFsYReYzSzAJ9Fx+C9QMwdQnFeio00IosRDYnLfGqhdjhIr
        e18zQrzczyhxpfUC4wRGqQWMDKsYxVILinPTU4uNCoz0ihNzi0vz0vWS83M3MYITkZbbDsYl
        53wOMQpwMCrx8EaU9EYJsSaWFVfmHmKU4GBWEuF1WNUfJcSbklhZlVqUH19UmpNafIjRFBg4
        E5mlRJPzgUkyryTe0MTSwMTMzMjczAKYIMR5WwNcooQE0hNLUrNTUwtSi2D6mDg4pRoY5/9w
        5zm34tNyloevpszMz43+oVil2jf5ztyMgjmysiLKreefZr3/k9rwOVv2196XtjO+snJs0HF3
        8Z53RHnFmUsbVx+Ti/ybMX9Lwe4Ypj8Ja+t5Zq6sOnrc7MHshpsPt679UrnzUrlnycmgFQtk
        69d6n35bz9yq9bqjJkOx/Mmh73fz7kd3ZCmxFGckGmoxFxUnAgBiXl2oWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t9jQd0l2/ujDM6+ULWYf+Qcq8XR87uZ
        LG78amO1uLxrDpvFkf/9jBa7r59jtFh6/SKTReveI+wWx9eGW7z8eILF4snRKcwO3B5r5q1h
        9Ng56y67x+O5G9k9Nq3qZPO4c20Pm0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBlTH35m7Xg
        LntF8+qNLA2MK9i6GDk5JARMJJZ0z2bpYuTiEBJYxyhx+k0bO4Tzg1FiR08jO0gVm4COxPZv
        x5lAbBGBSIkDv6cwgRQxCxxhlNi5YSpYQljAT+LV7nVgDSwCqhJL9jQygti8AtYSq3Y8YoRY
        Jy8xYUsTC4jNKWAjMeHPCzBbCKjm3fnfLBMYeRYwMqxilEwtKM5Nzy02KjDKSy3XK07MLS7N
        S9dLzs/dxAgMwW2Htfp3MD5eEn+IUYCDUYmHN6KkN0qINbGsuDL3EKMEB7OSCK/Dqv4oId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rz8+ccihQTSE0tSs1NTC1KLYLJMHJxSDYwcrov5d2X+fWl8
        8lXO/mnLI9RaWNPWXDwmem/bpHX2kyZNPLgx4v2HD9f2LN/Yd43dYy5r+iwmzX+nepQ0FvFV
        LnqsmiDxzPzgx9e6e3lnTg1b7szT3v8n52apnkWA8Tpjz7enLont1eWZv/eqn0KnTmxZzlb/
        +7+exb/JKTY1qTW5pFqccP2+EktxRqKhFnNRcSIAPFpxDz0CAAA=
X-CMS-MailID: 20180223064140epcas2p1fcfb5920453f965d16f717931155fa2f
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180223064140epcas2p1fcfb5920453f965d16f717931155fa2f
X-RootMTR: 20180223064140epcas2p1fcfb5920453f965d16f717931155fa2f
References: <20180223064138.18401-1-jh80.chung@samsung.com>
        <CGME20180223064140epcas2p1fcfb5920453f965d16f717931155fa2f@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 'num-slots' had already deprecated, remove the property in
device-tree file.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index ab0b95ba5ae5..d6638b1f09ca 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -910,7 +910,6 @@
 			#size-cells = <0>;
 			cd-inverted;
 			compatible = "hisilicon,hi3660-dw-mshc";
-			num-slots = <1>;
 			bus-width = <0x4>;
 			disable-wp;
 			cap-sd-highspeed;
@@ -948,7 +947,6 @@
 			compatible = "hisilicon,hi3660-dw-mshc";
 			reg = <0x0 0xff3ff000 0x0 0x1000>;
 			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
-			num-slots = <1>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_SDIO0>,
 				 <&crg_ctrl HI3660_HCLK_GATE_SDIO0>;
 			clock-names = "ciu", "biu";
-- 
2.15.1
