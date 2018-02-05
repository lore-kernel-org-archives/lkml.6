Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbeBEPqJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:46:09 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:35755 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbeBEPph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:45:37 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180205154535epoutp0442b1a601b5e173bcf64233cc85be0943~QeHkG93SS3167331673epoutp04_
X-AuditID: b6c32a45-403ff70000001023-d7-5a787c1d8353
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 7/8] ASoC: samsung: Add missing #sound-dai-cells property
 documentation
Date: Mon, 05 Feb 2018 16:44:02 +0100
Message-id: <20180205154403.13520-8-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180205154403.13520-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCmma5sTUWUwcJrphZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xeE37awW
        F1d8YXLg9djwuYnNY+esu+wem1Z1snn0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXxpqt85kL
        ujgr1i5cyNTAeIG9i5GTQ0LAROL/yS1ANheHkMAORokPjROYQRJCAt8ZJbY/k4UpWvrwBStE
        0W5GieMHJrJAOL8YJd42dbOBVLEJGEr0Hu1jBLFFBMQkbs/pZAYpYhY4wyQxfd8aJpCEsECk
        xIQNR4BGcXCwCKhKfO3QBAnzClhLtLxYygaxTV7i/YL7YHM4BWwk9txbxggyR0JgB5vEwZmv
        mCGKXCReXb/IBGELS7w6vgXqH2mJZ6s2QjX0M0qcWNMM5cxglLjTPgGqw1ri8PGLrCA2swCf
        RMfhv+wgF0kI8Ep0tAlBlHhITN77BWqoI9D/fUwQLwMNPbNkH+MERqkFjAyrGMVSC4pz01OL
        jQoM9YoTc4tL89L1kvNzNzGCo1rLdQfjjHM+hxgFOBiVeHgFMiqihFgTy4orcw8xSnAwK4nw
        Ol0vjxLiTUmsrEotyo8vKs1JLT7EKM3BoiTO2xbgEiUkkJ5YkpqdmlqQWgSTZeLglGpgjOUS
        r4xV/7tWLUM7JMd25XmVfxUX1NRznmTfqAie5xk91zY98BavcLbbNzMfLu9E56MJ+vEHl6yM
        +159LImfZUG1Vcpsy1dzK/bNLknmuZbTrZOz+sGce6qX+Auedt39J1kxY9qdNdKZjaxpm+MM
        An6/2fiPW0V63wG9q7Yy5mXXlr/7cHqqEktxRqKhFnNRcSIAZ7rLJuYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsVy+t9jAV3Zmooog7fvZS2uXDzEZLFxxnpW
        i6kPn7BZzD9yjtXi7f5uZovz5zewW3y70sFkcXnXHDaLGef3MVmsPXKX3aJ17xF2i8Nv2lkt
        Lq74wuTA67HhcxObx85Zd9k9Nq3qZPPo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujDVb5zMX
        dHFWrF24kKmB8QJ7FyMnh4SAicTShy9Yuxi5OIQEdjJK7P3ziBHC+cUo0bnkOhtIFZuAoUTv
        0T5GEFtEQEzi9pxOZpAiZoEzTBJfJl4CGyUsECkxYcMRoFEcHCwCqhJfOzRBwrwC1hItL5ay
        QWyTl3i/4D7YHE4BG4k995YxgpQLAdU03RSYwMizgJFhFaNkakFxbnpusVGBUV5quV5xYm5x
        aV66XnJ+7iZGYABuO6zVv4Px8ZL4Q4wCHIxKPLwCGRVRQqyJZcWVuYcYJTiYlUR4na6XRwnx
        piRWVqUW5ccXleakFh9ilOZgURLn5c8/FikkkJ5YkpqdmlqQWgSTZeLglGpgLJ1zf+sLhpKC
        CZMyxGM9Wo7Isbx9cOTc7sLwzw7rjwSdDVcqniHVzZR5Q9v99dW0r2uUl/mvZOhZs1XyvH7d
        Ehet61vjDSqPSzRZ+AgpLGPi2bItsDH2sd4j0zUsM4vvd9/cuWrH18Qb262nsZosTzx6r4z7
        ooPfisKfMcv6FG4sLI3Z5TWDS4mlOCPRUIu5qDgRAKWUtCQ8AgAA
X-CMS-MailID: 20180205154533epcas2p2d0ed58188cf7f29751c08cd804f6fb0d
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180205154533epcas2p2d0ed58188cf7f29751c08cd804f6fb0d
X-RootMTR: 20180205154533epcas2p2d0ed58188cf7f29751c08cd804f6fb0d
References: <20180205154403.13520-1-s.nawrocki@samsung.com>
        <CGME20180205154533epcas2p2d0ed58188cf7f29751c08cd804f6fb0d@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The #sound-dai-cells property might be helpful in selecting primary
or secondary CPU DAI and it's already present in i2s nodes for some
exynos SoCs so let's add it to the DT binding documentation.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 Documentation/devicetree/bindings/sound/samsung-i2s.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
index 5d7bb2735824..dd1b6e329941 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
@@ -54,6 +54,9 @@ in the IIS Multi Audio Interface.
 Note: Old DTs may not have the #clock-cells property and then not use the I2S
 node as a clock supplier.
 
+ - #sound-dai-cells: should be 1.
+
+
 Optional SoC Specific Properties:
 
 - samsung,idma-addr: Internal DMA register base address of the audio
@@ -79,4 +82,5 @@ i2s0: i2s@3830000 {
 	samsung,idma-addr = <0x03000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2s0_bus>;
+	#sound-dai-cells = <1>;
 };
-- 
2.14.2
