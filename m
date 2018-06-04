Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeFDUpU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:45:20 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:38374 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeFDUpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:45:19 -0400
X-Google-Smtp-Source: ADUXVKLwkVGv7JQ+9hpNG3k54B0b7xeWXtW0QsxSGRa+Dh85HfVlyz4snKIyFhPk86Nuv6OWgSrHJA==
Date: Mon, 4 Jun 2018 15:45:08 -0500
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
To: alsa-devel@alsa-project.org
Cc: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel][PATCH 0/3] ASoC: TSCS42xx: Control Improvements
Message-ID: <cover.1528143829.git.steven.eckhoff.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Eckhoff (3):
  Add mic bias boost control
  Remove Playback/Capture from control names
  Add headphone auto switching controls

 sound/soc/codecs/tscs42xx.c | 37 +++++++++++++++++++++++--------------
 sound/soc/codecs/tscs42xx.h |  8 ++++++++
 2 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.17.0
