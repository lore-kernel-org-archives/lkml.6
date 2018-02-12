Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964992AbeBLQSa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:18:30 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:39294 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964887AbeBLQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:16:55 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180212161652epoutp043a3738da707bc5a2d68e9910c51e520f~SoD4NKXuO0569105691epoutp04a
X-AuditID: b6c32a37-44bff70000001029-78-5a81bdf48c2e
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 4/7] ASoC: samsung: i2s: Define the parameters list for
 SAMSUNG_I2S_OPCLK
Date: Mon, 12 Feb 2018 17:15:35 +0100
Message-id: <20180212161538.22669-5-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180212161538.22669-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRbUhTYRTHe+67o8ltmj1spDWIzGopBl3QomAfVvTBTxlD1Eu7TsnNsaum
        4YfZsqmVWhEuX3JEpZnRtCluoqOpTCG2lmJFviBEhrZMfEOLaNvNb7/znN//HA4PhUomMClV
        oC/mjHq2UE6IsL7hI4rja4OV6uTG2WhmMuBBmG7ra5x5OP+VYNpGfDgTdN9GGb/fTjIbk9UI
        M+FqIRirfwhhXo3MkEzV4AjJDP+w4EygYw05K1bZV28QKmfTDKnq6awhVHWOTqBa7YnPwNWi
        dA1XWFDKGU+cyRXlb7XPoYaBvWWLzz8RJrC5pxZEUZA+CYOzb/FaIKIkdD+A24ttSLghoTcB
        vBlQ7kgv1p2kIA0A+Nk2gwjFNoDv3a2RBEGnwLujdSDMsXQc/NJSg4YllH6HwMahrogUQ2fD
        b/OTZJgx+hB8Y1mJsJhOg1WOekRYlwCXbXORQVF0Orw/0R7ZBmkHAceaejFBUsLHy62kwDFw
        0esIMRViGfwwelrw6wFc8boxoXgJ4NKGCxcCaXDYG4gwSkfDn+t3cCEshtW3JIKigsv27//1
        c9DsHQTCyaGhwfYBtAFIbWBXJ4jjDLxOy/EphlQFz+r4Er1WcaVI1wMiX510qh/YfRc9gKaA
        fLe4urlSLcHZUr5c5wGQQuWx4j/m0JNYw5Zf54xFOcaSQo73ABmFyfeJMzKUagmtZYu5qxxn
        4Iw7XYSKkppAo/PYVgOLNn/saDkwveLPNye0jvVd63jyrMKtfFCB2FIfaTa5slxZtg9bV6tk
        eZ79mcmuysPS7NUsqmH8oD7T4vNpLlndpj7ddJ7nV690wRpvkYxHKwKJS4ldU0fTtDUXLo8/
        PV9kurdV9UzUJsrKcf11Ti2Yyd9NbHdwTo7x+WxKEmrk2X+gckR25gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVy+t9jAd3PexujDDpmaFtcuXiIyWLjjPWs
        FlMfPmGzmH/kHKvF2/3dzBbnz29gt/h2pYPJ4vKuOWwWM87vY7JYe+Quu0Xr3iPsFofftLNa
        XFzxhcmB12PD5yY2j52z7rJ7bFrVyebRt2UVo8fnTXIBrFFcNimpOZllqUX6dglcGT+X32cu
        2C1a8WrZDbYGxu+CXYycHBICJhIrv+5k72Lk4hAS2MkoceLtXijnF6PE/N5DrCBVbAKGEr1H
        +xhBbBEBMYnbczqZQYqYBc4wSXyZeIkdJCEsECfx7OEVMJtFQFVic/tHMJtXwFqidUs/E8Q6
        eYn3C+6DDeIUsJGYdHk5WFwIqObI8vXMExh5FjAyrGKUTC0ozk3PLTYqMMxLLdcrTswtLs1L
        10vOz93ECAzCbYe1+nYw3l8Sf4hRgINRiYe3Y3ZjlBBrYllxZe4hRgkOZiUR3j/NQCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8t/OORQoJpCeWpGanphakFsFkmTg4pRoYV15/3hJcKBeh/3bT
        XwtWuYvfg5gK40zc65f9lptpkL3wcQNniczxla1pBQdPqEz/5Ld214S1i+IM0rPm/LQt4717
        8r9P4PSYzKmzIxumMnU0Z3x9sjjvaVyyqRI3/4vY3jWS585Orj21JCTxtGXC89y7k61M/V89
        MNfY/lJ/c/PrKYFnOufPUGIpzkg01GIuKk4EAF7KMco+AgAA
X-CMS-MailID: 20180212161651epcas1p4a8d293d6b9e2af10037159c717de1be2
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180212161651epcas1p4a8d293d6b9e2af10037159c717de1be2
X-RootMTR: 20180212161651epcas1p4a8d293d6b9e2af10037159c717de1be2
References: <20180212161538.22669-1-s.nawrocki@samsung.com>
        <CGME20180212161651epcas1p4a8d293d6b9e2af10037159c717de1be2@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SAMSUNG_I2S_OPCLK is not currently used by any card driver thus we can
safely change semantics of 'dir' argument of the I2S set_sysclk() callback.
Now an enumeration is exported instead of directly using register bit field
values.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s-regs.h | 11 ++++++-----
 sound/soc/samsung/i2s.c      |  2 +-
 sound/soc/samsung/i2s.h      | 11 ++++++++---
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/sound/soc/samsung/i2s-regs.h b/sound/soc/samsung/i2s-regs.h
index fe6914005494..964985ea2e80 100644
--- a/sound/soc/samsung/i2s-regs.h
+++ b/sound/soc/samsung/i2s-regs.h
@@ -65,11 +65,12 @@
 #define CON_RXDMA_ACTIVE	(1 << 1)
 #define CON_ACTIVE		(1 << 0)
 
-#define MOD_OPCLK_CDCLK_OUT	(0 << 30)
-#define MOD_OPCLK_CDCLK_IN	(1 << 30)
-#define MOD_OPCLK_BCLK_OUT	(2 << 30)
-#define MOD_OPCLK_PCLK		(3 << 30)
-#define MOD_OPCLK_MASK		(3 << 30)
+#define MOD_OPCLK_SHIFT		30
+#define MOD_OPCLK_CDCLK_OUT	(0 << MOD_OPCLK_SHIFT)
+#define MOD_OPCLK_CDCLK_IN	(1 << MOD_OPCLK_SHIFT)
+#define MOD_OPCLK_BCLK_OUT	(2 << MOD_OPCLK_SHIFT)
+#define MOD_OPCLK_PCLK		(3 << MOD_OPCLK_SHIFT)
+#define MOD_OPCLK_MASK		(3 << MOD_OPCLK_SHIFT)
 #define MOD_TXS_IDMA		(1 << 28) /* Sec_TXFIFO use I-DMA */
 
 #define MOD_BLCS_SHIFT		26
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 7b57ad11ca15..b6407fbabdd1 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -489,7 +489,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 	switch (clk_id) {
 	case SAMSUNG_I2S_OPCLK:
 		mask = MOD_OPCLK_MASK;
-		val = dir;
+		val = (dir << MOD_OPCLK_SHIFT) & MOD_OPCLK_MASK;
 		break;
 	case SAMSUNG_I2S_CDCLK:
 		mask = 1 << i2s_regs->cdclkcon_off;
diff --git a/sound/soc/samsung/i2s.h b/sound/soc/samsung/i2s.h
index 79781de2f247..a9832a9555cb 100644
--- a/sound/soc/samsung/i2s.h
+++ b/sound/soc/samsung/i2s.h
@@ -16,11 +16,16 @@
 #define SAMSUNG_I2S_DAI        "samsung-i2s"
 #define SAMSUNG_I2S_DAI_SEC    "samsung-i2s-sec"
 
-#define SAMSUNG_I2S_DIV_BCLK	1
+#define SAMSUNG_I2S_DIV_BCLK		1
 
-#define SAMSUNG_I2S_RCLKSRC_0	0
-#define SAMSUNG_I2S_RCLKSRC_1	1
+#define SAMSUNG_I2S_RCLKSRC_0		0
+#define SAMSUNG_I2S_RCLKSRC_1		1
 #define SAMSUNG_I2S_CDCLK		2
+/* Operation clock for IIS logic */
 #define SAMSUNG_I2S_OPCLK		3
+#define  SAMSUNG_I2S_OPCLK_CDCLK_OUT	0	/* CODEC clock out */
+#define  SAMSUNG_I2S_OPCLK_CDCLK_IN	1	/* CODEC clock in */
+#define  SAMSUNG_I2S_OPCLK_BCLK_OUT	2	/* Bit clock out */
+#define  SAMSUNG_I2S_OPCLK_PCLK		3	/* Audio bus clock */
 
 #endif /* __SND_SOC_SAMSUNG_I2S_H */
-- 
2.14.2
