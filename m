Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758426AbeD0TCx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:02:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33384 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758043AbeD0TCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:02:52 -0400
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: cs46xx: fix spelling mistake: "amplifer" -> "amplifier"
Date: Fri, 27 Apr 2018 20:02:45 +0100
Message-Id: <20180427190245.16861-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in module parameter description text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/cs46xx/cs46xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/cs46xx/cs46xx.c b/sound/pci/cs46xx/cs46xx.c
index 655fbea1692c..4910d3f46d4b 100644
--- a/sound/pci/cs46xx/cs46xx.c
+++ b/sound/pci/cs46xx/cs46xx.c
@@ -58,7 +58,7 @@ MODULE_PARM_DESC(id, "ID string for the CS46xx soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable CS46xx soundcard.");
 module_param_array(external_amp, bool, NULL, 0444);
-MODULE_PARM_DESC(external_amp, "Force to enable external amplifer.");
+MODULE_PARM_DESC(external_amp, "Force to enable external amplifier.");
 module_param_array(thinkpad, bool, NULL, 0444);
 MODULE_PARM_DESC(thinkpad, "Force to enable Thinkpad's CLKRUN control.");
 module_param_array(mmap_valid, bool, NULL, 0444);
-- 
2.17.0
