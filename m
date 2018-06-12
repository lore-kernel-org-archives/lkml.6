Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 322F7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6424208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6424208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932524AbeFLHS2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:18:28 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:35954 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932416AbeFLHS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:18:27 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id xjJR1x00P3XaVaC01jJR9k; Tue, 12 Jun 2018 09:18:25 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fSdZR-0005wI-EL; Tue, 12 Jun 2018 09:18:25 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fScRV-0000x9-Cc; Tue, 12 Jun 2018 08:06:09 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>
Cc:     autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] autofs: Fix typo s/thenew new/the new/ in AUTOFS4_FS description
Date:   Tue, 12 Jun 2018 08:05:55 +0200
Message-Id: <1528783555-19275-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: a2225d931f75ddd3 ("autofs: remove left-over autofs4 stubs")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 fs/autofs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs/Kconfig b/fs/autofs/Kconfig
index 55c3930a907b395e..eaebcd430cc3d404 100644
--- a/fs/autofs/Kconfig
+++ b/fs/autofs/Kconfig
@@ -4,7 +4,7 @@ config AUTOFS4_FS
 	help
 	   This name exists for people to just automatically pick up the
 	   new name of the autofs Kconfig option. All it does is select
-	   thenew new option name.
+	   the new option name.
 
 	   It will go away in a release or two as people have
 	   transitioned to just plain AUTOFS_FS.
-- 
2.7.4

