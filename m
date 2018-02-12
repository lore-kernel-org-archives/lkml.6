Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964910AbeBLQQ7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:16:59 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:19768 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935338AbeBLQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:16:41 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180212161638epoutp022bfaa4469be553fa684e05549e42f93c~SoDrGpIve1552315523epoutp02n
X-AuditID: b6c32a45-403ff70000001023-87-5a81bde547b9
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 1/7] ASoC: samsung: i2s: Update clock-output-names
 property documentation
Date: Mon, 12 Feb 2018 17:15:32 +0100
Message-id: <20180212161538.22669-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180212161538.22669-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsWy7bCmue7TvY1RBks+m1hcuXiIyWLjjPWs
        FlMfPmGzmH/kHKvF2/3dzBbnz29gt/h2pYPJ4vKuOWwWM87vY7JYe+Quu0Xr3iPsFofftLNa
        XFzxhcmB12PD5yY2j52z7rJ7bFrVyebRt2UVo8fnTXIBrFFcNimpOZllqUX6dglcGTv3LWYt
        2CxT0fCjla2BcZF4FyMnh4SAicTFPROZQGwhgR2MErvP5XYxcgHZ3xkl9m9oZ4EpaphxjB0i
        sZtRomf7bTYI5xejRN/SK8wgVWwChhK9R/sYQWwRATGJ23M6mUGKmAXOMElM37cGbIewQJzE
        1VPdYA0sAqoSk1tvgMV5Bawlun+cZYVYJy/xfsF9sEGcAjYSky4vZwIZJCGwg03ixok3UDe5
        SKzbfJUJwhaWeHV8CzuELS3xbNVGRoiGfkaJj8f3s0A4qxklXn/bBbXCWuLw8YtgNrMAn0TH
        4b9A3RxAcV6JjjYhiBIPid+v7rBB2I4S9y4+gPoZaOjlUw/ZJzBKLWBkWMUollpQnJueWmxU
        YKhXnJhbXJqXrpecn7uJERzXWq47GGec8znEKMDBqMTD+2BuY5QQa2JZcWXuIUYJDmYlEd4/
        zUAh3pTEyqrUovz4otKc1OJDjNIcLErivG0BLlFCAumJJanZqakFqUUwWSYOTqkGxr7T8yyW
        KLUvP1x6Q/S64b0pP9Qdd+YYrFu48n+xhUJqtbDY1Kg6lezn91O//O1b1rqJgTu76eISx+Qq
        kzcykyaLxzZ/sgs0tA1fF85z59tJ56xlF+WEtSo5i0InZIpNWauUt2RTwpWljVo70zxKjn46
        b2vEJW+neP74tabUlEe/z6otMK/6osRSnJFoqMVcVJwIAOdnkBjnAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t9jAd0nexujDL4u1bW4cvEQk8XGGetZ
        LaY+fMJmMf/IOVaLt/u7mS3On9/AbvHtSgeTxeVdc9gsZpzfx2Sx9shddovWvUfYLQ6/aWe1
        uLjiC5MDr8eGz01sHjtn3WX32LSqk82jb8sqRo/Pm+QCWKO4bFJSczLLUov07RK4MnbuW8xa
        sFmmouFHK1sD4yLxLkZODgkBE4mGGcfYuxi5OIQEdjJKfDh5mgUkISTwi1Hi4bMKEJtNwFCi
        92gfI4gtIiAmcXtOJzNIA7PAGSaJLxMvsYMkhAXiJCau3AdWxCKgKjG59QYTiM0rYC3R/eMs
        K8Q2eYn3C+6D1XAK2EhMurycCWKZtcSR5euZJzDyLGBkWMUomVpQnJueW2xUYJSXWq5XnJhb
        XJqXrpecn7uJERiC2w5r9e9gfLwk/hCjAAejEg9vx+zGKCHWxLLiytxDjBIczEoivH+agUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5+fOPRQoJpCeWpGanphakFsFkmTg4pRoYFd99+j/7koy3
        fFO95Z4Cxsqd9dw/jFv/NH7qVltb4NnbEGjyTkFbYma0cmlpzeSqaSzf3grXvpjYfmK3ohYf
        4z6WHq7JG3duzSmtitSbYa4zw+XlrdSbbxz8pz6ut25t3fP3qMT1jdknmNplUr9v6zqdUcfM
        +vD4r9wrTzSmtmc52t9dFsGsxFKckWioxVxUnAgA6Gzgqj0CAAA=
X-CMS-MailID: 20180212161636epcas2p25f894b22e938ea8f3371196e7e90c169
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180212161636epcas2p25f894b22e938ea8f3371196e7e90c169
X-RootMTR: 20180212161636epcas2p25f894b22e938ea8f3371196e7e90c169
References: <20180212161538.22669-1-s.nawrocki@samsung.com>
        <CGME20180212161636epcas2p25f894b22e938ea8f3371196e7e90c169@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock-output-names property is marked as deprecated. While at it,
and few typos are fixed.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/samsung-i2s.txt        | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
index bf100cd0d0f7..c1f508f18ac8 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
@@ -7,7 +7,7 @@ Required SoC Specific Properties:
    - samsung,s5pv210-i2s: for 8/16/24bit multichannel(5.1) I2S with
      secondary fifo, s/w reset control and internal mux for root clk src.
    - samsung,exynos5420-i2s: for 8/16/24bit multichannel(5.1) I2S for
-     playback, sterio channel capture, secondary fifo using internal
+     playback, stereo channel capture, secondary fifo using internal
      or external dma, s/w reset control, internal mux for root clk src
      and 7.1 channel TDM support for playback. TDM (Time division multiplexing)
      is to allow transfer of multiple channel audio data on single data line.
@@ -25,7 +25,7 @@ Required SoC Specific Properties:
   These strings correspond 1:1 with the ordered pairs in dmas.
 - clocks: Handle to iis clock and RCLK source clk.
 - clock-names:
-  i2s0 uses some base clks from CMU and some are from audio subsystem internal
+  i2s0 uses some base clocks from CMU and some are from audio subsystem internal
   clock controller. The clock names for i2s0 should be "iis", "i2s_opclk0" and
   "i2s_opclk1" as shown in the example below.
   i2s1 and i2s2 uses clocks from CMU. The clock names for i2s1 and i2s2 should
@@ -36,9 +36,9 @@ Required SoC Specific Properties:
 - #clock-cells: should be 1, this property must be present if the I2S device
   is a clock provider in terms of the common clock bindings, described in
   ../clock/clock-bindings.txt.
-- clock-output-names: from the common clock bindings, names of the CDCLK
-  I2S output clocks, suggested values are "i2s_cdclk0", "i2s_cdclk1",
-  "i2s_cdclk3" for the I2S0, I2S1, I2S2 devices recpectively.
+- clock-output-names (deprecated): from the common clock bindings, names of
+  the CDCLK I2S output clocks, suggested values are "i2s_cdclk0", "i2s_cdclk1",
+  "i2s_cdclk3" for the I2S0, I2S1, I2S2 devices respectively.
 
 There are following clocks available at the I2S device nodes:
  CLK_I2S_CDCLK    - the CDCLK (CODECLKO) gate clock,
@@ -49,9 +49,10 @@ There are following clocks available at the I2S device nodes:
 
 Refer to the SoC datasheet for availability of the above clocks.
 The CLK_I2S_RCLK_PSR and CLK_I2S_RCLK_SRC clocks are usually only available
-in the IIS Multi Audio Interface (I2S0).
-Note: Old DTs may not have the #clock-cells, clock-output-names properties
-and then not use the I2S node as a clock supplier.
+in the IIS Multi Audio Interface.
+
+Note: Old DTs may not have the #clock-cells property and then not use the I2S
+node as a clock supplier.
 
 Optional SoC Specific Properties:
 
@@ -74,8 +75,7 @@ i2s0: i2s@3830000 {
 		<&clock_audss EXYNOS_I2S_BUS>,
 		<&clock_audss EXYNOS_SCLK_I2S>;
 	clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
-	#clock-cells;
-	clock-output-names = "i2s_cdclk0";
+	#clock-cells = <1>;
 	samsung,idma-addr = <0x03000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2s0_bus>;
-- 
2.14.2
