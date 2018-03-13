Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933727AbeCMQaG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:30:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58639 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933432AbeCMQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:30:04 -0400
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
Subject: [PATCH 0/3] ASoC: stm32: sai: add support of iec958 controls
Date: Tue, 13 Mar 2018 17:27:05 +0100
Message-ID: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support of iec958 controls to STM32 SAI driver.

The patch makes use of iec958 control status helpers previously proposed
and discussed through the following threads:
https://patchwork.kernel.org/patch/8062601/
https://patchwork.kernel.org/patch/8091551/ (v2)
https://patchwork.kernel.org/patch/8462961/ (v3)
https://patchwork.kernel.org/patch/8533731/ (v4)

Olivier Moysan (3):
  ALSA: pcm: add IEC958 channel status control helper
  ASoC: stm32: sai: add iec958 controls support
  ASoC: dmaengine_pcm: document process callback

 include/sound/dmaengine_pcm.h |   2 +
 include/sound/pcm_iec958.h    |  19 +++++++
 sound/core/pcm_iec958.c       | 114 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/stm/Kconfig         |   1 +
 sound/soc/stm/stm32_sai_sub.c | 101 ++++++++++++++++++++++++++++++++-----
 5 files changed, 225 insertions(+), 12 deletions(-)

-- 
1.9.1
