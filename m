Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbeBWMlq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:41:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50006 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeBWMlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:41:44 -0500
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Barry Song <baohua@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: sirf: remove duplicated bit-wise or of USP_RXFIFO_THD_INT
Date: Fri, 23 Feb 2018 12:41:17 +0000
Message-Id: <20180223124117.24686-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Bit pattern USP_RXFIFO_THD_INT is being bit-wise or'd twice;
remove the redundant 2nd USP_RXFIFO_THD_INT

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/sirf/sirf-usp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sirf/sirf-usp.h b/sound/soc/sirf/sirf-usp.h
index bf0201cb15bc..e22e13a619e8 100644
--- a/sound/soc/sirf/sirf-usp.h
+++ b/sound/soc/sirf/sirf-usp.h
@@ -154,7 +154,7 @@
 					USP_RX_IO_DMA_INT|\
 					USP_RXFIFO_FULL_INT|\
 					USP_RXFIFO_THD_INT|\
-					USP_RXFIFO_THD_INT|USP_RX_TIMEOUT_INT)
+					USP_RX_TIMEOUT_INT)
 
 #define USP_INT_ALL        0x1FFF
 
-- 
2.15.1
