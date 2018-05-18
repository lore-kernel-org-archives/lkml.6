Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeERJNj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:13:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53978 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753098AbeERJNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:13:37 -0400
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm2200,wm5100: fix spelling mistake: "Coefficeints" -> "Coefficients"
Date: Fri, 18 May 2018 10:13:27 +0100
Message-Id: <20180518091327.17705-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes in SND_SOC_BYTES literal strings

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/wm2200.c | 4 ++--
 sound/soc/codecs/wm5100.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index d5f4bbf27182..3663b9fd4d65 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1155,8 +1155,8 @@ SOC_DOUBLE_R_TLV("IN3 Digital Volume", WM2200_ADC_DIGITAL_VOLUME_3L,
 SND_SOC_BYTES_MASK("EQL Coefficients", WM2200_EQL_1, 20, WM2200_EQL_ENA),
 SND_SOC_BYTES_MASK("EQR Coefficients", WM2200_EQR_1, 20, WM2200_EQR_ENA),
 
-SND_SOC_BYTES("LHPF1 Coefficeints", WM2200_HPLPF1_2, 1),
-SND_SOC_BYTES("LHPF2 Coefficeints", WM2200_HPLPF2_2, 1),
+SND_SOC_BYTES("LHPF1 Coefficients", WM2200_HPLPF1_2, 1),
+SND_SOC_BYTES("LHPF2 Coefficients", WM2200_HPLPF2_2, 1),
 
 SOC_SINGLE("OUT1 High Performance Switch", WM2200_DAC_DIGITAL_VOLUME_1L,
 	   WM2200_OUT1_OSR_SHIFT, 1, 0),
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 87f9a99ce978..ba89d9d711f7 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -573,10 +573,10 @@ SND_SOC_BYTES_MASK("EQ4 Coefficients", WM5100_EQ4_1, 20, WM5100_EQ4_ENA),
 SND_SOC_BYTES_MASK("DRC Coefficients", WM5100_DRC1_CTRL1, 5,
 		   WM5100_DRCL_ENA | WM5100_DRCR_ENA),
 
-SND_SOC_BYTES("LHPF1 Coefficeints", WM5100_HPLPF1_2, 1),
-SND_SOC_BYTES("LHPF2 Coefficeints", WM5100_HPLPF2_2, 1),
-SND_SOC_BYTES("LHPF3 Coefficeints", WM5100_HPLPF3_2, 1),
-SND_SOC_BYTES("LHPF4 Coefficeints", WM5100_HPLPF4_2, 1),
+SND_SOC_BYTES("LHPF1 Coefficients", WM5100_HPLPF1_2, 1),
+SND_SOC_BYTES("LHPF2 Coefficients", WM5100_HPLPF2_2, 1),
+SND_SOC_BYTES("LHPF3 Coefficients", WM5100_HPLPF3_2, 1),
+SND_SOC_BYTES("LHPF4 Coefficients", WM5100_HPLPF4_2, 1),
 
 SOC_SINGLE("HPOUT1 High Performance Switch", WM5100_OUT_VOLUME_1L,
 	   WM5100_OUT1_OSR_SHIFT, 1, 0),
-- 
2.17.0
