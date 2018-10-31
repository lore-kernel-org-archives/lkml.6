Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B579ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5D320664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5D320664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeKAHHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:07:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60477 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbeKAHHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:07:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VM78E72560864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:07:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VM773B2560861;
        Wed, 31 Oct 2018 15:07:07 -0700
Date:   Wed, 31 Oct 2018 15:07:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-76gsvs0w2g0x723ivqa2xua3@git.kernel.org>
Cc:     jolsa@kernel.org, o-takashi@sakamocchi.jp, tiwai@suse.de,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org, acme@redhat.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com,
          tglx@linutronix.de, mingo@kernel.org, jolsa@kernel.org,
          o-takashi@sakamocchi.jp, tiwai@suse.de, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools include uapi: Update asound.h copy
Git-Commit-ID: 89eb1f3b7f2a9156ce6f78713d7924c1bb2fab9f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  89eb1f3b7f2a9156ce6f78713d7924c1bb2fab9f
Gitweb:     https://git.kernel.org/tip/89eb1f3b7f2a9156ce6f78713d7924c1bb2fab9f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 30 Oct 2018 14:20:07 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 31 Oct 2018 09:57:52 -0300

tools include uapi: Update asound.h copy

To silence this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
  diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h

Due to this cset:

  a98401518def ("ALSA: timer: fix wrong comment to refer to 'SNDRV_TIMER_PSFLG_*'")

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>
Link: https://lkml.kernel.org/n/tip-76gsvs0w2g0x723ivqa2xua3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/sound/asound.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index ed0a120d4f08..404d4b9ffe76 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -752,7 +752,7 @@ struct snd_timer_info {
 #define SNDRV_TIMER_PSFLG_EARLY_EVENT	(1<<2)	/* write early event to the poll queue */
 
 struct snd_timer_params {
-	unsigned int flags;		/* flags - SNDRV_MIXER_PSFLG_* */
+	unsigned int flags;		/* flags - SNDRV_TIMER_PSFLG_* */
 	unsigned int ticks;		/* requested resolution in ticks */
 	unsigned int queue_size;	/* total size of queue (32-1024) */
 	unsigned int reserved0;		/* reserved, was: failure locations */
