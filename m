Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964959AbeBLQRS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:17:18 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:12913 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964927AbeBLQRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:17:14 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180212161712epoutp03086e28ebeb119656f11aa9aa3384cae7~SoEKZZe7R2297622976epoutp03E
X-AuditID: b6c32a39-47fff70000000fc5-ea-5a81be07a817
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 7/7] ASoC: samsung: Add missing #sound-dai-cells property
 documentation
Date: Mon, 12 Feb 2018 17:15:38 +0100
Message-id: <20180212161538.22669-8-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180212161538.22669-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCmni77vsYog+7dfBZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xeE37awW
        F1d8YXLg9djwuYnNY+esu+wem1Z1snn0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXxsI509kK
        rnFWXGn7z9rAOJGji5GTQ0LARKL5+T62LkYuDiGBHYwSZ9atZYZwvjNKPPzXwApTdfLESXaI
        xG5GiS9TzzBCOL8YJdq+/WQDqWITMJToPdrHCGKLCIhJ3J7TCTaKWeAMk8T0fWuYQBLCAjES
        9x+dBLNZBFQl1j/eDFTEwcErYC3xdnkdxDZ5ifcL7oPN4RSwkZh0eTkTyBwJgR1sEuf7l7FD
        FLlIzPuylhHCFpZ4dXwLO8gcCQFpiUtHbSHq+xklPh7fzwLhrGaUeP1tF9Q/1hKHj18Es5kF
        +CTefe1hhWjmlehoE4Io8ZCY+ugh1HxHib3bH0MDCWjozJdTWScwSi1gZFjFKJZaUJybnlps
        WGCqV5yYW1yal66XnJ+7iREc1VqWOxiPnfM5xCjAwajEw9sxuzFKiDWxrLgy9xCjBAezkgjv
        n2agEG9KYmVValF+fFFpTmrxIUZpDhYlcd6AAJcoIYH0xJLU7NTUgtQimCwTB6dUA6PqewXR
        qWlz5zNHPOG58bwu3M0vZ2u2bIzFLoWCr2L8xvukLnKr+MtcsTLaXcef9FCjTIVvqYnhNacT
        ZoeWtEy3vXXww3YJ3/Xpiy7cjmpLkb/4g+P8XoE4+0C+d+Z+PJH7jng1yuz2W717fmrKrymm
        nj+X+k2Z/Sgri2XBy7P6SUuUpmyWPKXEUpyRaKjFXFScCAC4exZN5gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t9jAV22fY1RBu8P2FhcuXiIyWLjjPWs
        FlMfPmGzmH/kHKvF2/3dzBbnz29gt/h2pYPJ4vKuOWwWM87vY7JYe+Quu0Xr3iPsFofftLNa
        XFzxhcmB12PD5yY2j52z7rJ7bFrVyebRt2UVo8fnTXIBrFFcNimpOZllqUX6dglcGQvnTGcr
        uMZZcaXtP2sD40SOLkZODgkBE4mTJ06ydzFycQgJ7GSUuHq3lRXC+cUosWfzU2aQKjYBQ4ne
        o32MILaIgJjE7TmdzCBFzAJnmCS+TLzEDpIQFoiRuP/oJBOIzSKgKrH+8WagIg4OXgFribfL
        6yC2yUu8X3AfbA6ngI3EpMvLwcqFgEqOLF/PPIGRZwEjwypGydSC4tz03GKjAsO81HK94sTc
        4tK8dL3k/NxNjMAQ3HZYq28H4/0l8YcYBTgYlXh4O2Y3RgmxJpYVV+YeYpTgYFYS4f3TDBTi
        TUmsrEotyo8vKs1JLT7EKM3BoiTOezvvWKSQQHpiSWp2ampBahFMlomDU6qBsemIWss7xejJ
        gp26c3W4X7x3Xav3cklRyAppqcMhlgUO/10LbLMVZY9EpWgqK4j8kTIKPJ0/get7pNZrZ+aS
        aTMiDq2asvM1y9rFzRnMNxfzdgtzitw53MP1SpLV7My3yQuvBzeIBInWqOad6NWf1quqdmvD
        dv613n1TMm32JGj7aTE6uHxQYinOSDTUYi4qTgQAMaiU2T0CAAA=
X-CMS-MailID: 20180212161711epcas1p2285c5a778cf12ab00211063b1b4a0fc3
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180212161711epcas1p2285c5a778cf12ab00211063b1b4a0fc3
X-RootMTR: 20180212161711epcas1p2285c5a778cf12ab00211063b1b4a0fc3
References: <20180212161538.22669-1-s.nawrocki@samsung.com>
        <CGME20180212161711epcas1p2285c5a778cf12ab00211063b1b4a0fc3@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The #sound-dai-cells property might be helpful in selecting primary
or secondary CPU DAI and it's already present in i2s nodes for some
exynos SoCs so let's add it to the DT binding documentation.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1:
 - the property moved to the "Optional SoC Specific Properties"
   paragraph.
---
 Documentation/devicetree/bindings/sound/samsung-i2s.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
index c1f508f18ac8..a88cb00fa096 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
@@ -60,6 +60,7 @@ Optional SoC Specific Properties:
   sub system(used in secondary sound source).
 - pinctrl-0: Should specify pin control groups used for this controller.
 - pinctrl-names: Should contain only one value - "default".
+- #sound-dai-cells: should be 1.
 
 
 Example:
@@ -79,4 +80,5 @@ i2s0: i2s@3830000 {
 	samsung,idma-addr = <0x03000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2s0_bus>;
+	#sound-dai-cells = <1>;
 };
-- 
2.14.2
