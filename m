Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBTRom (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:44:42 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42253 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeBTRok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:44:40 -0500
X-Google-Smtp-Source: AH8x225Eo7ZKU7NzS28vqSKw8NYzmAxuRkKdt+NtqjBsKtqc+URTVyomRsTBUr7dnVYrnMvViV6LSg==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
Subject: [RESEND PATCH v2 0/2] ASoC: topology: Add parsing clock gating
Date: Tue, 20 Feb 2018 18:44:44 +0100
Message-Id: <20180220174446.7784-1-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds parsing the topology clock gating parameter, which
is currently can be set by alsa-lib, but ignored by kernel.

The patch 1/2 modifies the UAPI header. If it is applied, the corresponded
patch should be applied in alsa-lib [2].

Related, but not required alsa-lib patch: [1].

[1]. [alsa-lib,v2,1/2] topology: Fix parsing config with multiple
  hw_configs
[2]. [alsa-lib,v2,2/2] ASoC: topology: Add defines for
  snd_soc_tplg_hw_config.clock_gated

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org

Kirill Marinushkin (2):
  ASoC: topology: Add defines for snd_soc_tplg_hw_config.clock_gated
  ASoC: topology: Add missing clock gating parameter when parsing
    hw_configs

 include/uapi/sound/asoc.h | 7 ++++++-
 sound/soc/soc-topology.c  | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.13.6
