Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeFDUpv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:45:51 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35139 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeFDUpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:45:49 -0400
X-Google-Smtp-Source: ADUXVKIdn75wN/rXoGSdO5Acu7uV/RHeOXaPbasHUhsCJA2p8cLMjLe8wrnuyx8rKjRJS1Si5SE42Q==
Date: Mon, 4 Jun 2018 15:45:40 -0500
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
To: alsa-devel@alsa-project.org
Cc: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel][PATCH 1/3] ASoC: TSCS42xx: Add mic bias boost control
Message-ID: <91e206cbabd7c7a7c8d7715b5e51ffef384ac6ec.1528143829.git.steven.eckhoff.opensource@gmail.com>
References: <cover.1528143829.git.steven.eckhoff.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1528143829.git.steven.eckhoff.opensource@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mic bias boost control

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
---
 sound/soc/codecs/tscs42xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index bbfc73a79b18..15505c3c9ed4 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -638,6 +638,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 	/* Input Channel Map */
 	SOC_ENUM("Input Channel Map", ch_map_select_enum),
 
+	/* Mic Bias */
+	SOC_SINGLE("Mic Bias Boost Switch", 0x71, 0x07, 1, 0),
+
 	/* Coefficient Ram */
 	COEFF_RAM_CTL("Cascade1L BiQuad1", BIQUAD_SIZE, 0x00),
 	COEFF_RAM_CTL("Cascade1L BiQuad2", BIQUAD_SIZE, 0x05),
-- 
2.17.0
