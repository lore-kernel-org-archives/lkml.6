Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935654AbeCHQ0R (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:26:17 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:28856 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933513AbeCHQ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:26:13 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180308162611epoutp01a3d1e6375ea20cb9debb9558857ee8c0~Z-q2xlt2F0108101081epoutp01V
X-AuditID: b6c32a39-47fff70000000fc5-b5-5aa164220bb5
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: kgene@kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 4/4] ARM: dts: Enable HDMI audio on Snow Chromebook
Date: Thu, 08 Mar 2018 17:25:59 +0100
Message-id: <20180308162559.391-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180307172711.15697-4-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCmvq5SysIog933uC02zljPajH/yDlW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JYu2Ru+wWh9+0szpwemxa1cnmsXlJvUffllWM
        Hp83yQWwRHHZpKTmZJalFunbJXBlbGjezViwnLfi6vxutgbGKdxdjJwcEgImEtuWn2HsYuTi
        EBLYwShx8/wvKOc7o8SdX43MMFXfD/WwQiR2M0r0XD3ABOH8YpS4vK2NDaSKTcBQovdoHyOI
        LSIgLHFv6XJ2kCJmgX+MEsdvTQMbJSzgJjHxQAM7iM0ioCrR2vkNrJlXwFJi+ZczjBDr5CXe
        L7gPZHNwcArYSEy/KAcyR0JgApvExHWNLBA1LhJzjvxggrCFJV4d38IOUi8hIC1x6agtRLha
        orOtix2it4VR4s+0S2wQCWuJw8cvsoLYzAJ8Eu++grwG0ssr0dEmBGF6SExYbAJR7Shxb9Mn
        Noh/+xkl3s9awTiBUWoBI8MqRrHUguLc9NRiwwJTveLE3OLSvHS95PzcTYzg6NSy3MF47JzP
        IUYBDkYlHt4HjgujhFgTy4orcw8xSnAwK4nwBugDhXhTEiurUovy44tKc1KLDzFKc7AoifMG
        BLhECQmkJ5akZqemFqQWwWSZODilGhg5Za2ZSo5PuXXUvV7V5cmyyY9N7Pu1AipE/3+xZ3/9
        6e7zM+vSLuz+JJVdZ/5+/8WEVXkvrx4UEsw4wa67Si30uvKtXp/WNrkHhgdfXf7zPSZ3ZlXu
        33nJV67N9Jp33SfuweNzEYFGjsxx6Y/OMkzwX7Zl0e78uKbTZ3ldshfXhFlePzo9je2NEktx
        RqKhFnNRcSIA3KXJBsoCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42I5/e+xgK5iysIog1fnDC02zljPajH/yDlW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JYu2Ru+wWh9+0szpwemxa1cnmsXlJvUffllWM
        Hp83yQWwRHHZpKTmZJalFunbJXBlbGjezViwnLfi6vxutgbGKdxdjJwcEgImEt8P9bB2MXJx
        CAnsZJQ439fKDJIQEvjFKDHnqw6IzSZgKNF7tI8RxBYREJa4t3Q5O4jNLPCPUeLDVn0QW1jA
        TWLigQawOIuAqkRr5zc2EJtXwFJi+ZczjBDL5CXeL7gPZHNwcArYSEy/KAexylri0+vP7BMY
        eRYwMqxilEwtKM5Nzy02KjDMSy3XK07MLS7NS9dLzs/dxAgMpW2Htfp2MN5fEn+IUYCDUYmH
        18JlYZQQa2JZcWXuIUYJDmYlEd4AfaAQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5xyKFBNIT
        S1KzU1MLUotgskwcnFINjO58EtcyPUR1lYRfzWc836Pa6CaVWW2ScHTlPMOAK9UZwo9k3B+t
        fDHxRpVbQueO9xNTVlesnv7zl4rBAzsHxxtrDJ7rFbdN7Q1jDlHzPyG21+Ci9xrVlgXhrwUW
        m38I2S+rembxbw7jQu+oG4d5v+qyXCpKU7q89ecuC9a19eGdOS43P892VGIpzkg01GIuKk4E
        AJXaSa0hAgAA
X-CMS-MailID: 20180308162609epcas1p45458c1671c38b389e047f17804690eb9
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180308162609epcas1p45458c1671c38b389e047f17804690eb9
X-RootMTR: 20180308162609epcas1p45458c1671c38b389e047f17804690eb9
References: <20180307172711.15697-4-s.nawrocki@samsung.com>
        <CGME20180308162609epcas1p45458c1671c38b389e047f17804690eb9@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new cpu, codec subnodes according to the updated
"google,snow-audio-max98095" DT bindings and the I2S clock tree
configuration so sound on the HDMI interface can also be supported.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v2:
 - changed order of codec phandles in codec/cpu-dai property
   to match the DT bindings documentation.
---
 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 4 ++++
 arch/arm/boot/dts/exynos5250-snow.dts         | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index bdf59dd3654b..932a00cfd716 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/maxim,max77686.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5250.dtsi"

 / {
@@ -523,6 +524,9 @@
 };

 &i2s0 {
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_I2S_BUS>;
+	#clock-cells = <1>;
 	status = "okay";
 };

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 16e37c337a3f..75fdc5e6d423 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -18,6 +18,14 @@

 		samsung,model = "Snow-I2S-MAX98095";
 		samsung,audio-codec = <&max98095>;
+
+		cpu {
+			sound-dai = <&i2s0 0>;
+		};
+
+		codec {
+			sound-dai = <&max98095 0>, <&hdmi>;
+		};
 	};
 };

--
2.14.2
