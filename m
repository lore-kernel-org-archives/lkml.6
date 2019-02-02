Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8507BC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EC120870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="tBnSixkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfBBGXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:23:55 -0500
Received: from tomli.me ([153.92.126.73]:45102 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfBBGXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:23:55 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Feb 2019 01:23:43 EST
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 97bcb32a;
        Sat, 2 Feb 2019 06:17:12 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:7b76:77ab)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 02 Feb 2019 06:17:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=qZXfYEYENCjnA/DvVJIMJSg9s4XjKAKMh812pgU//KU=; b=tBnSixkHgWdKXJtGZUOR0Y01acepItcjmfEu2bBwtFs3+XFZpDD/5eEezyYRZiLfkIrtEQR55ZoD/wXi0QJOovdbYN4PviJO8tixw5smBemY2+oN6B3sczijtKz0T9bcHV33Z6YGOOspYi4Dt3fciTegQkDSUOB2719LSJFjmcHWo2cnLu6uq4R+q1pTrZjqfh2jWUD0DYFuRK8OIsKu+nIvby4e7XthlJ2hZUXqXInLe8dyvG6KPoO4NrBfr3KVVrwKNmadWKRN6uO+oCmgw/8x4JGZoOckYwRXHTg4cs0A/NBVRVrkhjxgAMmUZuH2FMLW+ycJvsMA5p7bQov/ew==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/8] fbdev: sm712fb: update copyright headers.
Date:   Sat,  2 Feb 2019 14:16:41 +0800
Message-Id: <20190202061648.30374-2-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202061648.30374-1-tomli@tomli.me>
References: <20190202061648.30374-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My implementation of 2D acceleration used the original buggy code
in the staging tree (which had been removed due to a critical bug
soon after its submission), also, OpenBSD's smfb.c driver written
by Miodrag Vallat was another important source of reference, a
hunk of hardware register definitions are taken verbatim.

This commit appends my name to the list of authors, and included
Miodrag Vallat's name and the ISC license of the original smfb.c
driver.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/video/fbdev/sm712.h   | 20 ++++++++++++++++++++
 drivers/video/fbdev/sm712fb.c | 20 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/video/fbdev/sm712.h b/drivers/video/fbdev/sm712.h
index aad1cc4be34a..99077e91ae10 100644
--- a/drivers/video/fbdev/sm712.h
+++ b/drivers/video/fbdev/sm712.h
@@ -8,9 +8,29 @@
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
+ * Copyright (C) 2014, 2019 Yifeng Li.
+ * Author:   Yifeng Li <tomli@tomli.me>
+ *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for
  *  more details.
+ *
+ *  This file incorporates work covered by the following copyright and
+ *  permission notice:
+ *
+ *    Copyright (c) 2009, 2010 Miodrag Vallat.
+ *
+ *    Permission to use, copy, modify, and distribute this software for any
+ *    purpose with or without fee is hereby granted, provided that the above
+ *    copyright notice and this permission notice appear in all copies.
+ *
+ *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #define FB_ACCEL_SMI_LYNX 88
diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 502d0de2feec..8d63bbfef9ea 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -11,11 +11,31 @@
  * Copyright (C) 2011 Igalia, S.L.
  * Author:   Javier M. Mellid <jmunhoz@igalia.com>
  *
+ * Copyright (C) 2014, 2019 Yifeng Li.
+ * Author:   Yifeng Li <tomli@tomli.me>
+ *
  * This file is subject to the terms and conditions of the GNU General Public
  * License. See the file COPYING in the main directory of this archive for
  * more details.
  *
  * Framebuffer driver for Silicon Motion SM710, SM712, SM721 and SM722 chips
+ *
+ * This file incorporates work covered by the following copyright and
+ * permission notice:
+ *
+ *    Copyright (c) 2009, 2010 Miodrag Vallat.
+ *
+ *    Permission to use, copy, modify, and distribute this software for any
+ *    purpose with or without fee is hereby granted, provided that the above
+ *    copyright notice and this permission notice appear in all copies.
+ *
+ *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/io.h>
-- 
2.20.1

