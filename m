Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFB4C5CFC2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD44208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD44208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934518AbeFRKlH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:41:07 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:53852 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934187AbeFRKlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:41:04 -0400
Received: from faui49man5 (faui49man5.informatik.uni-erlangen.de [131.188.42.193])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 2ED6D58C53C;
        Mon, 18 Jun 2018 12:31:35 +0200 (CEST)
Received: by faui49man5 (sSMTP sendmail emulation); Mon, 18 Jun 2018 12:31:35 +0200
From:   Roman Sommer <roman.sommer@fau.de>
Cc:     Roman Sommer <roman.sommer@fau.de>, linux-kernel@i4.cs.fau.de,
        Daniel Graefe <daniel.graefe@fau.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        =?UTF-8?q?Hans=20P=2E=20M=C3=B6ller=20Ebner?= <hmoller@uc.cl>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Fabi=C3=A1n=20Inostroza?= <soulsonceonfire@gmail.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sound/line6: add newline after declarations
Date:   Mon, 18 Jun 2018 12:29:39 +0200
Message-Id: <1529317779-15908-4-git-send-email-roman.sommer@fau.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
References: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>
CC: "Hans P. Möller Ebner" <hmoller@uc.cl>
CC: Kees Cook <keescook@chromium.org>
CC: Kate Stewart <kstewart@linuxfoundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: "Fabián Inostroza" <soulsonceonfire@gmail.com>
CC: Bhumika Goyal <bhumirks@gmail.com>
CC: Philippe Ombredanne <pombredanne@nexb.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: alsa-devel@alsa-project.org
CC: linux-kernel@vger.kernel.org

This patch adds newlines after variable declarations in sound/usb/line6.

Signed-off-by: Roman Sommer <roman.sommer@fau.de>
Signed-off-by: Daniel Graefe <daniel.graefe@fau.de>
---
 sound/usb/line6/driver.h   | 1 +
 sound/usb/line6/playback.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 1dfb6de..4dff70c 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -174,6 +174,7 @@ struct usb_line6 {
 		struct mutex read_lock;
 		wait_queue_head_t wait_queue;
 		unsigned int active:1;
+
 		STRUCT_KFIFO_REC_2(LINE6_BUFSIZE_LISTEN * LINE6_RAW_MESSAGES_MAXCOUNT)
 			fifo;
 	} messages;
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 674502c..1e16a5c 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -39,6 +39,7 @@ static void change_volume(struct urb *urb_out, int volume[],
 		for (; p < buf_end; ++p) {
 			short pv = le16_to_cpu(*p);
 			int val = (pv * volume[chn & 1]) >> 8;
+
 			pv = clamp(val, -0x8000, 0x7fff);
 			*p = cpu_to_le16(pv);
 			++chn;
@@ -126,6 +127,7 @@ static void add_monitor_signal(struct urb *urb_out, unsigned char *signal,
 			short pov = le16_to_cpu(*po);
 			short piv = le16_to_cpu(*pi);
 			int val = pov + ((piv * volume) >> 8);
+
 			pov = clamp(val, -0x8000, 0x7fff);
 			*po = cpu_to_le16(pov);
 		}
-- 
2.7.4

