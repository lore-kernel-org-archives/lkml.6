Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeCTMdW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:33:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37836 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753160AbeCTMdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:33:15 -0400
X-Google-Smtp-Source: AG47ELvf2NmrvhMTdPF1LuH7iajxot91NwwtPwdBI7MhOJqS3GCfK8w7d+Y7Kg04J/rz5zGy6weAtg==
From: Masanari Iida <standby24x7@gmail.com>
To: broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] linux-next: ASoC: mediatek: mt2701: Fix a typo in printk
Date: Tue, 20 Mar 2018 21:33:09 +0900
Message-Id: <20180320123309.12333-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.16.2.520.gd0db9edba005
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo in printk

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index f7e0702d92f8..f2eb4c7f94e8 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -343,7 +343,7 @@ static int mt2701_btmrg_hw_params(struct snd_pcm_substream *substream,
 	stream_fs = params_rate(params);
 
 	if ((stream_fs != 8000) && (stream_fs != 16000)) {
-		dev_err(afe->dev, "%s() btmgr not supprt this stream_fs %d\n",
+		dev_err(afe->dev, "%s() btmgr not support this stream_fs %d\n",
 			__func__, stream_fs);
 		return -EINVAL;
 	}
-- 
2.16.2.520.gd0db9edba005
