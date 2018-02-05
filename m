Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeBEPp6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:45:58 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:35746 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbeBEPpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:45:32 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180205154530epoutp046997131e5ab9998faeb3df3f8f4a46d6~QeHfs_Dyd3104731047epoutp04T
X-AuditID: b6c32a45-3ebff70000001023-ce-5a787c1a1f57
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 6/8] ASoC: samsung: i2s: Update clock-output-names property
 documentation
Date: Mon, 05 Feb 2018 16:44:01 +0100
Message-id: <20180205154403.13520-7-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180205154403.13520-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7bCmua5UTUWUwYG1QhZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xeE37awW
        F1d8YXLg9djwuYnNY+esu+wem1Z1snn0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXxpqJH9gK
        FkhX7Dzewt7AuESsi5GTQ0LARGLOjSlsILaQwA5GiZZrtV2MXED2d0aJ2deOMcMUzT3/kRki
        sZtRom/RLTYI5xejxOKZF5lAqtgEDCV6j/YxgtgiAmISt+d0gnUwC5xhkpi+bw1YkbBAtMTT
        fzNZQGwWAVWJE22dYCt4BawlFt74wwixTl7i/YL7YDangI3EnnvLGEEGSQjsYJN4eWIKK0SR
        i0R39wkmCFtY4tXxLewQtrTEs1UboRr6GSVOrGmGcmYwStxpnwDVYS1x+PhFsEnMAnwSHYf/
        AnVzAMV5JTrahCBMD4mju3Ihqh0ltmzcCA0koJlnT0ZPYJRawMiwilEstaA4Nz212KjAUK84
        Mbe4NC9dLzk/dxMjOKa1XHcwzjjnc4hRgINRiYdXIKMiSog1say4MvcQowQHs5IIr9P18igh
        3pTEyqrUovz4otKc1OJDjNIcLErivG0BLlFCAumJJanZqakFqUUwWSYOTqkGxooMx8Dc+sVt
        zl/2zGKf3rQ8NCHAUnLGcjd70cbgiY0srlZiRxau2f/Xb/nBh1Em3muYz89UbrFSk1vyLNBk
        15Qlskv8D554KlHzd4V9lubKZaxz2eUqWpo2XjpmmKfnZT7732yVSToeBVtj75sJPLbPfHBi
        46Ij+24sDlh+u27BoT0PTipK8yixFGckGmoxFxUnAgBjOU0z5QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t9jAV3Jmooog/ML2S2uXDzEZLFxxnpW
        i6kPn7BZzD9yjtXi7f5uZovz5zewW3y70sFkcXnXHDaLGef3MVmsPXKX3aJ17xF2i8Nv2lkt
        Lq74wuTA67HhcxObx85Zd9k9Nq3qZPPo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujDUTP7AV
        LJCu2Hm8hb2BcYlYFyMnh4SAicTc8x+Zuxi5OIQEdjJKPHp/mA3C+cUo8XdSCxNIFZuAoUTv
        0T5GEFtEQEzi9pxOsA5mgTNMEl8mXmIHSQgLREs8/TeTBcRmEVCVONEGUsTJwStgLbHwxh9G
        iHXyEu8X3AezOQVsJPbcWwZkcwBts5ZouikwgZFnASPDKkbJ1ILi3PTcYqMCo7zUcr3ixNzi
        0rx0veT83E2MwBDcdlirfwfj4yXxhxgFOBiVeHgFMiqihFgTy4orcw8xSnAwK4nwOl0vjxLi
        TUmsrEotyo8vKs1JLT7EKM3BoiTOy59/LFJIID2xJDU7NbUgtQgmy8TBKdXAmLBt8u7lx9Kf
        z2f8Vid9MCnooWbr3kdfVNRvGdvNCl0pObNBdJOqy2b91mtiQWtmXuN7wXbPJpJjCd8Bd2up
        9zwFOwtz/ip7mF089uQWq//yv6lzLKa8Vn3st0OuYZ5+3Kw3E3XyuJXa/h7eefVpb1e1eYDL
        Up0WhmttK6dOi9hdyXO087onnxJLcUaioRZzUXEiAGkYFU09AgAA
X-CMS-MailID: 20180205154529epcas2p3478546ef61294ac06cd9d8ed3d7e12c9
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180205154529epcas2p3478546ef61294ac06cd9d8ed3d7e12c9
X-RootMTR: 20180205154529epcas2p3478546ef61294ac06cd9d8ed3d7e12c9
References: <20180205154403.13520-1-s.nawrocki@samsung.com>
        <CGME20180205154529epcas2p3478546ef61294ac06cd9d8ed3d7e12c9@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock-output-names property is marked as deprecated. While at it,
#clock-cells property's value is corrected in the example snippet
and few typos are fixed.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 .../devicetree/bindings/sound/samsung-i2s.txt          | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
index bf100cd0d0f7..5d7bb2735824 100644
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
@@ -36,8 +36,8 @@ Required SoC Specific Properties:
 - #clock-cells: should be 1, this property must be present if the I2S device
   is a clock provider in terms of the common clock bindings, described in
   ../clock/clock-bindings.txt.
-- clock-output-names: from the common clock bindings, names of the CDCLK
-  I2S output clocks, suggested values are "i2s_cdclk0", "i2s_cdclk1",
+- clock-output-names (deprecated): from the common clock bindings, names of
+  the CDCLK I2S output clocks, suggested values are "i2s_cdclk0", "i2s_cdclk1",
   "i2s_cdclk3" for the I2S0, I2S1, I2S2 devices recpectively.
 
 There are following clocks available at the I2S device nodes:
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
