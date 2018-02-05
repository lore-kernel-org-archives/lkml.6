Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeBEPpv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:45:51 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:35725 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753296AbeBEPpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:45:25 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180205154522epoutp04e2a3eabbd366d8b23345243be638a8ce~QeHYTSrf53104731047epoutp04S
X-AuditID: b6c32a36-c91ff70000001028-bb-5a787c112fb8
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 4/8] ASoC: samsung: i2s: Define the parameters list for
 SAMSUNG_I2S_OPCLK
Date: Mon, 05 Feb 2018 16:43:59 +0100
Message-id: <20180205154403.13520-5-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180205154403.13520-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCmrq5gTUWUwZ8j+hZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xeE37awW
        F1d8YXLg9djwuYnNY+esu+wem1Z1snn0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXxt295QWd
        ohX/Vt5nbWA8LdjFyMkhIWAi8XPWW/YuRi4OIYEdjBITvs9ngnC+M0p8bl/C3MXIAVb145Qf
        RHw3o0Tbvf2MEM4vRonWlVeYQUaxCRhK9B7tYwSxRQTEJG7P6WQGKWIWOMMkMX3fGiaQhLBA
        tETD/JUsIDaLgKrEpRW3WEE28ApYS7xaJAtxkrzE+wX3weZwCthI7Lm3DGyZhMAeNom1Hy6y
        QxS5SEw+f5QRwhaWeHV8CzvEpdISl47aQtT3M0qcWNMM1TyDUeJO+wQmiAZricPHL7KC2MwC
        fBLvvvawQjTzSnS0CUGYHhIz+0wgqh0llh/6DvajEMjMQ1+CJzBKLWBkWMUollpQnJueWmxY
        YKRXnJhbXJqXrpecn7uJERzNWmY7GBed8znEKMDBqMTDK5BRESXEmlhWXJl7iFGCg1lJhNfp
        enmUEG9KYmVValF+fFFpTmrxIUZpDhYlcd6AAJcoIYH0xJLU7NTUgtQimCwTB6dUA+NMTie2
        6tPt27bOtjnMbbY002dX7m3XeN7YyX99/fN14w/NWrDbYO+f5ZW3Zf6+Pbcg75fi8vR0g88X
        3k+90LDxWUm6+yGm+Ozlt+zfP+D07pKsWMVyOSnma9qh2Tc974ZNDtrBfOJ5Klfh5coTp77y
        72c2+cN2u3zekcZ7Xn8nn3n3/vDv4EMaSizFGYmGWsxFxYkAwRzFXuICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsVy+t9jAV2BmooogyXLRC2uXDzEZLFxxnpW
        i6kPn7BZzD9yjtXi7f5uZovz5zewW3y70sFkcXnXHDaLGef3MVmsPXKX3aJ17xF2i8Nv2lkt
        Lq74wuTA67HhcxObx85Zd9k9Nq3qZPPo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujLt7yws6
        RSv+rbzP2sB4WrCLkYNDQsBE4scpvy5GLg4hgZ2MEi8W72SDcH4xSrz8/Zu1i5GTg03AUKL3
        aB8jiC0iICZxe04nM0gRs8AZJokvEy+xgySEBaIlGuavZAGxWQRUJS6tuMUKsoFXwFri1SJZ
        kLCEgLzE+wX3weZwCthI7Lm3jBGkRAiopOmmwARGngWMDKsYJVMLinPTc4uNCgzzUsv1ihNz
        i0vz0vWS83M3MQKDb9thrb4djPeXxB9iFOBgVOLhzciqiBJiTSwrrsw9xCjBwawkwut0vTxK
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBsbZyrvkPz2Z
        tE+uIfr9jN9nmWcX/1Lym+YovvH3+4/ce92nVxrMLJp5cfO+jPjs/0t+/lvN7rExYuZNjQnO
        FZIXU0/Ya16y9f5/8FKHuIX96tzJmjbuChu3XOCcZOnppZHfev6eoBa/Uad9o/nXSN5vrR+W
        /UuNyr+nERuT8kqp/JRYtLC6b7QSS3FGoqEWc1FxIgC5SN91OgIAAA==
X-CMS-MailID: 20180205154520epcas1p4132421a187a4d767a2f75badfef5eec4
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205154520epcas1p4132421a187a4d767a2f75badfef5eec4
X-RootMTR: 20180205154520epcas1p4132421a187a4d767a2f75badfef5eec4
References: <20180205154403.13520-1-s.nawrocki@samsung.com>
        <CGME20180205154520epcas1p4132421a187a4d767a2f75badfef5eec4@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SAMSUNG_I2S_OPCLK is not currently used by any card driver thus we can
safely change semantics of 'dir' argument of the I2S set_sysclk() callback.
Now an anumeration is exported instead of directly using register bitfield
values.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
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
index 1c05170e4999..6d768cdb4326 100644
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
