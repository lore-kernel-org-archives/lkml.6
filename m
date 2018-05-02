Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeEBN7v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:59:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52416 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeEBN7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:59:47 -0400
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: sc6000: fix spelling mistake: "iomaped" -> "iomapped"
Date: Wed,  2 May 2018 14:59:40 +0100
Message-Id: <20180502135940.30915-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in KERN_ERR error messages

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/sc6000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index c09d9b914efe..a985e9183be9 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -592,7 +592,7 @@ static int snd_sc6000_probe(struct device *devptr, unsigned int dev)
 	*vport = devm_ioport_map(devptr, port[dev], 0x10);
 	if (*vport == NULL) {
 		snd_printk(KERN_ERR PFX
-			   "I/O port cannot be iomaped.\n");
+			   "I/O port cannot be iomapped.\n");
 		err = -EBUSY;
 		goto err_unmap1;
 	}
@@ -607,7 +607,7 @@ static int snd_sc6000_probe(struct device *devptr, unsigned int dev)
 	vmss_port = devm_ioport_map(devptr, mss_port[dev], 4);
 	if (!vmss_port) {
 		snd_printk(KERN_ERR PFX
-			   "MSS port I/O cannot be iomaped.\n");
+			   "MSS port I/O cannot be iomapped.\n");
 		err = -EBUSY;
 		goto err_unmap2;
 	}
-- 
2.17.0
