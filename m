Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbeAaSD3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:03:29 -0500
Received: from serv1.kernkonzept.com ([88.99.87.17]:51888 "EHLO
        mx.kernkonzept.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbeAaSDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:03:20 -0500
From: Matthias Lange <matthias.lange@kernkonzept.com>
To: perex@perex.cz, tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
        Matthias Lange <matthias.lange@kernkonzept.com>
Subject: [PATCH] Fix copy and paste typo in documentation
Date: Wed, 31 Jan 2018 18:39:12 +0100
Message-Id: <1517420352-7939-1-git-send-email-matthias.lange@kernkonzept.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's 'optional' instead of 'optinal'.

Signed-off-by: Matthias Lange <matthias.lange@kernkonzept.com>
---
 include/sound/ac97/regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/ac97/regs.h b/include/sound/ac97/regs.h
index 4bb86d3..9a4fa0c 100644
--- a/include/sound/ac97/regs.h
+++ b/include/sound/ac97/regs.h
@@ -31,7 +31,7 @@
 #define AC97_HEADPHONE		0x04	/* Headphone Volume (optional) */
 #define AC97_MASTER_MONO	0x06	/* Master Volume Mono (optional) */
 #define AC97_MASTER_TONE	0x08	/* Master Tone (Bass & Treble) (optional) */
-#define AC97_PC_BEEP		0x0a	/* PC Beep Volume (optinal) */
+#define AC97_PC_BEEP		0x0a	/* PC Beep Volume (optional) */
 #define AC97_PHONE		0x0c	/* Phone Volume (optional) */
 #define AC97_MIC		0x0e	/* MIC Volume */
 #define AC97_LINE		0x10	/* Line In Volume */
-- 
2.7.4
