Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932383AbeE1JsE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:48:04 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40615 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754159AbeE1Jre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:47:34 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180528094732euoutp0228c054b4dea75c3312191944e7a5f97d~yxe6avIG31507715077euoutp02R
X-AuditID: cbfec7f5-f95739c0000028a9-12-5b0bd032721f
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 09/12] ARM: dts: exynos5250: add mipi-phy node
Date: Mon, 28 May 2018 11:47:13 +0200
Message-id: <1527500833-16005-10-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSayxbYRjH955Lz1G6nJTNO1skayITCXbL8opFfEDOB1nqK8ms5gyhZa3r
        lm1iQ6tjLhN1GbKxSccuJTUWnZnMDKVuM5lZYjaGuI24DGu1vv2e//N/bslD48Js0oWOkSVy
        cpkkTsTjE/qPm/2eZwfsw04XtQvR+AsjiXKN3RjKUC6Q6LXmJYmqOs3a8NoiDxVO5hNo5ruJ
        QA+m5nDU3/+KQn0Z8xRSFdRQSDc1SqKh1goe0vQbMFQ9O06ghs4JCtV+MWEos62TQpqiWR7a
        bK0k/I+w9ZX1gB3Ky8XYlrIJii1XlpKsTqvisc3rP0h2Ut2FsY01d9i8Ji1gV3WuYn4o/2Ik
        FxeTzMm9/a7wo9V/l7CEu7zU1ndPiHSwQeQAOxoy5+HzPZOZ+bSQqQMws2CDtAarABavz5AH
        rkrNI5vrKYD39buUJSFk9gD81CfKATTNYzxgfXa4xePEaAFsHFsAlgBnikk4UDW338mR8YNj
        +mXcwgTjBrPVqn1dwATCquEMyjrNFX41qvY9dmZ9qC2LZ2kEGTUFn3ZX2FYKgFsPTbYCR/in
        q8nGJ6BK+R6zcjzM/DVl01OhIbfHVusLP3SZ9hlnDsNCfQluuQAyAqjMElotLGxYWcWsF2sA
        LK1tw/PBsWpwSAucuSSFNIpTnJNxKV4KiVSRJIvyuhov1QHze/Tsdq29AYZ/ER2AoYHIQZC+
        zQ8TkpJkRZq0A0AaFzkJ+J5mSRApSbvByePD5UlxnKIDHKcJkbPgsvvtUCETJUnkYjkugZMf
        ZDHaziUdiH+Hed1627zoqjee9HG/1t5ZHeggXk4zlmNlKUv87a3Bdf1cUExVSvSO5HNDqHDi
        5rI0tvHx9Kkd75WkuF57ikkdSa8LDO4Vh8yPBvwcqSnbC+qdrr5+QXO05FuERjn6DKprBsUR
        l4JaRr3K3Nhg/63VlnsazxCoM/iup/i0iAhFtOSMBy5XSP4DwFvw4hoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xy7qGF7ijDXY91rK4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErozuLx+YCprZKnbtX8zSwPiDpYuRk0NCwERi3oy5QDYXh5DAEkaJTY/PQTmNTBJb
        px1k7GLk4GAT0JJY0x4PEhcRWMUoMfXvHXYQh1lgNqvEq0cTGEFGCQvYSdzY9pEZxGYRUJVo
        7+5kBbF5BVwl5l9pYodYJydx81wnWA0nUPzy3jY2EFtIwEVie+MslgmMPAsYGVYxiqSWFuem
        5xYb6hUn5haX5qXrJefnbmIEhv62Yz8372C8tDH4EKMAB6MSD2/Db65oIdbEsuLK3EOMEhzM
        SiK8XLpAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYzM
        fIJZ2VHGNnW/H2ddP8EuzLbK8U/rWpvvQXbJ87c+uRSxuU1Cn+m6736ucu3eGfNELvsL17de
        1y0siJ2zXCZ/X/lh1jP9dULlh8RrGvew3z84t5AnkfPDWzUVHzFWg/bToUnCTdOfsisES/1M
        bZJ8tkhkOc/2WY65R2XzMtseLAm0+nN9vxJLcUaioRZzUXEiAE7fMYB5AgAA
X-CMS-MailID: 20180528094729eucas1p1cc26ea191a4ee1ba9daa06fae93037bf
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528094729eucas1p1cc26ea191a4ee1ba9daa06fae93037bf
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
        <CGME20180528094729eucas1p1cc26ea191a4ee1ba9daa06fae93037bf@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds phy node, required by MIPI devices.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 2daf505..a63b655 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -733,6 +733,12 @@
 			#phy-cells = <0>;
 		};
 
+		mipi_phy: video-phy@10040710 {
+			compatible = "samsung,s5pv210-mipi-video-phy";
+			#phy-cells = <1>;
+			syscon = <&pmu_system_controller>;
+		};
+
 		adc: adc@12d10000 {
 			compatible = "samsung,exynos-adc-v1";
 			reg = <0x12D10000 0x100>;
-- 
2.7.4
