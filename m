Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeDDETP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 00:19:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53551 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeDDETO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 00:19:14 -0400
X-Google-Smtp-Source: AIpwx49vg3welxdpQaaHu4FTGbdKvlZDpy1MsA7h9RLXgdj1+BQFR9FyMjV5I6+Zth4y1H2NybXbVg==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH v4 0/3] ASoC: topology: Improve hw_configs
Date: Wed,  4 Apr 2018 06:19:36 +0200
Message-Id: <20180404041939.23317-1-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

This patch series waits since 20th of February, because it modifies UAPI headers
and should be done in sync with ALSA. I see that previously there was no clear
understanding, how to do this in sync.

Two days ago I discussed with Takashi, and he suggested the following steps:

Step 1. A person from Intel, who knows the topic (Pierre), adds his
"Reviewed-by" or "Acked-by" tags
Step 2. I clarify with you to apply the Linux part (this patch series)
Step 3. After that, I clarify with Takashi to apply the ALSA part (it is ready,
but not sent untill we apply the Linux part)

The step 1 is done. Old patches are reviewed by Pierre, so they have his
"Reviewed-by" tag. New patches are suggested by him, and we agreed on the
implementation, so they have his "Acked-by" tag.

Now we are on the step 2. If you don't have anything against this patch series,
please apply it to Linux.

Best Regards,
Kirill

Kirill Marinushkin (3):
  ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
  ASoC: topology: Add missing clock gating parameter when parsing
    hw_configs
  ASoC: topology: Add definitions for mclk_direction values

 include/uapi/sound/asoc.h | 29 +++++++++++++++++++++++++----
 sound/soc/soc-topology.c  | 19 ++++++++++++++-----
 2 files changed, 39 insertions(+), 9 deletions(-)

-- 
2.13.6
