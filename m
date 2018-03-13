Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933559AbeCMQaf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:30:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:6400 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932397AbeCMQaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:30:05 -0400
From: Olivier Moysan <olivier.moysan@st.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <robh@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel@stlinux.com>, <linux-kernel@vger.kernel.org>,
        <olivier.moysan@st.com>
CC: <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>,
        <rmk@arm.linux.org.uk>, <jsarha@ti.com>
Subject: [PATCH 3/3] ASoC: dmaengine_pcm: document process callback
Date: Tue, 13 Mar 2018 17:27:08 +0100
Message-ID: <1520958428-10930-4-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing description of process callback.

Fixes: 78648092ef46 ("ASoC: dmaengine_pcm: add processing support")
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 include/sound/dmaengine_pcm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 47ef486852ed..e3481eebdd98 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -118,6 +118,8 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
  *   PCM substream. Will be called from the PCM drivers hwparams callback.
  * @compat_request_channel: Callback to request a DMA channel for platforms
  *   which do not use devicetree.
+ * @process: Callback used to apply processing on samples transferred from/to
+ *   user space.
  * @compat_filter_fn: Will be used as the filter function when requesting a
  *  channel for platforms which do not use devicetree. The filter parameter
  *  will be the DAI's DMA data.
-- 
1.9.1
