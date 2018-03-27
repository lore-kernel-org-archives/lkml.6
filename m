Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeC0U4P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 16:56:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54435 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbeC0U4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 16:56:13 -0400
X-Google-Smtp-Source: AIpwx4/i1bSDzLGUqPI+KSzKLCZ0P2MO7Niti0OIUty/t7e2mB8yqlaNicH45cV8lu8K0Rh8fmKUCw==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH v3 0/2] ASoC: topology: Improve parsing hw_configs
Date: Tue, 27 Mar 2018 22:56:30 +0200
Message-Id: <20180327205632.3677-1-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jaroslav, Takashi, Mark,

This patch series is a resend of [1] and [2], rebased on top of the latest
head. It was logical to resend them together.

It includes 2 patches for linux + 2 patches for alsa-lib.

Please have a look.

Best Regards,
Kirill

[1] https://patchwork.kernel.org/patch/10250485/
[2] https://patchwork.kernel.org/patch/10230611/

Kirill Marinushkin (2):
  ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
  ASoC: topology: Add missing clock gating parameter when parsing
    hw_configs

 include/uapi/sound/asoc.h | 23 ++++++++++++++++++++---
 sound/soc/soc-topology.c  | 19 ++++++++++++++-----
 2 files changed, 34 insertions(+), 8 deletions(-)

-- 
2.13.6
