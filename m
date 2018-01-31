Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753840AbeAaQuW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:50:22 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33728 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752826AbeAaQuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:50:19 -0500
From: Olivier Moysan <olivier.moysan@st.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@stlinux.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
CC: <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [PATCH 1/2] ASoC: stm32: spdifrx: fix typo in function name.
Date: Wed, 31 Jan 2018 17:47:02 +0100
Message-ID: <1517417223-21899-2-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517417223-21899-1-git-send-email-olivier.moysan@st.com>
References: <1517417223-21899-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-31_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix function name prefix for naming consistency.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_spdifrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index b9bdefc..42ad2ae 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -858,8 +858,8 @@ static void stm32_spdifrx_shutdown(struct snd_pcm_substream *substream,
 	{}
 };
 
-static int stm_spdifrx_parse_of(struct platform_device *pdev,
-				struct stm32_spdifrx_data *spdifrx)
+static int stm32_spdifrx_parse_of(struct platform_device *pdev,
+				  struct stm32_spdifrx_data *spdifrx)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id;
@@ -914,7 +914,7 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spdifrx);
 
-	ret = stm_spdifrx_parse_of(pdev, spdifrx);
+	ret = stm32_spdifrx_parse_of(pdev, spdifrx);
 	if (ret)
 		return ret;
 
-- 
1.9.1
