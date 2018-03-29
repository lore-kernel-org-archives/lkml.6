Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeC2CIl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 22:08:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44528 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751908AbeC2CIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 22:08:40 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Akshu Agrawal" <akshu.agrawal@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Dylan Reid <dgreid@chromium.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: amd: acp-da7219-max98357: Make symbol da7219_dai_clk static
Date: Thu, 29 Mar 2018 02:14:03 +0000
Message-ID: <1522289643-61304-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warning:

sound/soc/amd/acp-da7219-max98357a.c:46:12: warning:
 symbol 'da7219_dai_clk' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index b205c78..f41560e 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -43,7 +43,7 @@
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
-struct clk *da7219_dai_clk;
+static struct clk *da7219_dai_clk;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
