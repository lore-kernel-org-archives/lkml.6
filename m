Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeC0VAW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:00:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50918 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeC0VAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:00:21 -0400
X-Google-Smtp-Source: AIpwx48bOExVkFPJ5TdUr+XV5Tep7zElkdcmrEKOSPMu00JjPjN302RBJQ2OjbQC+bN7pNa+gYbUXA==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH, alsa-lib, v3 0/2] alsa-lib: ASoC: topology: Improve parsing hw_configs
Date: Tue, 27 Mar 2018 23:00:48 +0200
Message-Id: <20180327210050.3728-1-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180327205632.3677-1-k.marinushkin@gmail.com>
References: <20180327205632.3677-1-k.marinushkin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the alsa-lib part of the patch-series
"ASoC: topology: Improve parsing hw_configs"

Kirill Marinushkin (2):
  ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
  ASoC: topology: Add missing clock gating parameter when parsing
    hw_configs

 include/sound/asoc.h                       | 23 ++++++++++++++++---
 include/topology.h                         |  6 ++---
 src/conf/topology/broadwell/broadwell.conf |  4 ++--
 src/topology/pcm.c                         | 36 +++++++++++++++++++++++++-----
 4 files changed, 56 insertions(+), 13 deletions(-)

-- 
2.13.6
