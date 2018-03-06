Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933182AbeCFOol (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:44:41 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:49680 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932856AbeCFOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:44:35 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180306144432epoutp027ef6bb6c10c2c18ef0f2f0e47e8c552e~ZW-ippiAN1274112741epoutp02N
X-AuditID: b6c32a46-3a9ff70000001029-1b-5a9ea9506a8d
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 01/12] thermal: exynos: remove unused "type" field from
 struct exynos_tmu_platform_data
Date: Tue, 06 Mar 2018 15:43:44 +0100
Message-id: <1520347435-22970-2-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsWy7bCmuW7AynlRBl/6JSw2zljPajH/yDkg
        ceUaq0X/49fMFufPb2C32PQYyL28aw6bxefeI4wWM87vY7I4NHUvo8XS6xeZLFr3HmG3ePKw
        j82B12PNvDWMHpevXWT22DnrLrvH4j0vmTw2repk89i8pN6jb8sqRo/Pm+QCOKK4bFJSczLL
        Uov07RK4Ml6dXsJW0MhRcXX3D8YGxnNsXYycHBICJhIHv91m7GLk4hAS2MEosXrFEWYI5zuj
        xJazf1hgqhZ+XMUOkdjNKPGk+w8rhPMLqGX1ViaQKjYBK4mJ7asYQWwRgRKJaat6weYyC5xl
        ktix/R3QKA4OYYFMiefnuEFqWARUJT4/agG7g1fAQ2J34zVWiG1yEiePTQazOQU8JU50gNzK
        BRQ/wibxec06qMNdJH5MXAzVICzx6vgWdghbWuLZqo2MEA3NjBLfduxhhkhMYJTYs14IwraW
        OHz8IlgzswCfRMfhv+wgx0kI8Ep0tEGVeEic+7KOEcJ2lDhwbB0TxMdzGCWO7H7DNIFRagEj
        wypGsdSC4tz01GKjAiO94sTc4tK8dL3k/NxNjOCI13LbwbjknM8hRgEORiUe3g0ec6OEWBPL
        iitzDzFKcDArifBG6M+LEuJNSaysSi3Kjy8qzUktPsQozcGiJM7bGuASJSSQnliSmp2aWpBa
        BJNl4uCUamBc7/8t1EF27e+pv8/mBlnGlu9m33tF5PbKnrJ1BanPApU/7fxs8n7x7RZZ412K
        jqvU6/aukZWQNlAIeGRcfqDSca+OYiKnfc6RoB1G1wVDFKWjFirmL1rkbDHbf8EryzCpQ382
        /NP00TgXwOX70PlG0Cm3R2xVnFEfE+7fOv6hzt1tklLzVRYlluKMREMt5qLiRACadt1H9AIA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsVy+t9jAV3/lfOiDA60q1hsnLGe1WL+kXNA
        4so1Vov+x6+ZLc6f38BusekxkHt51xw2i8+9RxgtZpzfx2RxaOpeRoul1y8yWbTuPcJu8eRh
        H5sDr8eaeWsYPS5fu8jssXPWXXaPxXteMnlsWtXJ5rF5Sb1H35ZVjB6fN8kFcERx2aSk5mSW
        pRbp2yVwZbw6vYStoJGj4uruH4wNjOfYuhg5OSQETCQWflzF3sXIxSEksJNRYs7zI0wQzi9G
        iUtXfzOBVLEJWElMbF/FCGKLCJRIdE57zQxiMwucZZI4+J8DxBYWyJTYtHsPWJxFQFXi86MW
        sA28Ah4SuxuvsUJsk5M4eWwymM0p4ClxogPiCiGgmsXdv9kmMPIsYGRYxSiZWlCcm55bbFRg
        lJdarlecmFtcmpeul5yfu4kRGJ7bDmv172B8vCT+EKMAB6MSD+8Gj7lRQqyJZcWVuYcYJTiY
        lUR4I/TnRQnxpiRWVqUW5ccXleakFh9ilOZgURLn5c8/FikkkJ5YkpqdmlqQWgSTZeLglGpg
        VPlSlfGjqEFll7Dg8ef3pBaKCLlIO/St4i95F1vzV2O/f3x70+4/vP+9b96NUFp5gPPEh33T
        I8XWKC26+7Zxzxfxs+LfK8u/L+A8xx30sH1pZqNs75bFhroi5z5dEp57z+19lfCMQ5Guyu+X
        L3j5MdT52ZXgsuZ+mzrxRKVshfeJgb9k3W54KbEUZyQaajEXFScCANPuFOhLAgAA
X-CMS-MailID: 20180306144431epcas2p1fef7b2d8130decb08e023b4ff329e9ff
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180306144431epcas2p1fef7b2d8130decb08e023b4ff329e9ff
X-RootMTR: 20180306144431epcas2p1fef7b2d8130decb08e023b4ff329e9ff
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144431epcas2p1fef7b2d8130decb08e023b4ff329e9ff@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused "type" field from struct exynos_tmu_platform_data.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 5149c2a..8c468b6 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -47,7 +47,6 @@ enum soc_type {
  *	0 < reference_voltage <= 31
  * @noise_cancel_mode: noise cancellation mode
  *	000, 100, 101, 110 and 111 can be different modes
- * @type: determines the type of SOC
  * @efuse_value: platform defined fuse value
  * @min_efuse_value: minimum valid trimming data
  * @max_efuse_value: maximum valid trimming data
@@ -68,7 +67,6 @@ struct exynos_tmu_platform_data {
 	u8 second_point_trim;
 	u8 default_temp_offset;
 
-	enum soc_type type;
 	u32 cal_type;
 };
 
-- 
1.9.1
