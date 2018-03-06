Return-Path: <keescook@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520377096; cv=none;
        d=google.com; s=arc-20160816;
        b=OtTWqCvt4sBvM6qhIEsr/uyYlflz8OAts4+11dwH7Rwy9wl1L+0Ghgs+PzDxas6F/q
         QM3AUwMvuhwqdCdYc7ebz2k0PRJD02UCU5Rx1VHtQkP52BuqWdQbtcYcO7Nn2LDLM9ot
         lH+cwyZypY2cq68/AHweFJ+wmGQPctGa/631Zx6wehCg909OL891X14Ad9A3B2YcWpA5
         b/Vs4L5z+mtb4D/rNW+UmNfMiUEfOfaFs28H/Wgz2QNhkRzkT3aOZ4V9OHEzjG9CY5qI
         dvnz1wKQmmVAq8sTX7nxjgfLJEA84os3qhXodkPNzIc7bpmcFzXo1++m9xRPnL7YdW3A
         aHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=w/7NltTPSaMBQVzS5M6F8X4o+QVdIrGuWtmnPKkQW1g=;
        b=gpbkjL5YBhNW7My2hcSQkk9sMIXkuGMgGelJngtmU1RqdyAu8L+2TfqFQsSp3DWeeA
         GJPis7Ka+Jb9S/wx4oye1WGn2mP0MZ2Kwb1gXEatHS9JlrAypsbrLuaYiSFY7H6rqLak
         CCZZAhBXKsQk86qp9V3S82IDWpUkcE34UB+lzcR4an4hZlESgBIlkfo8TxhAUhnUgdfZ
         4up6xfcOrIcPYVo1VVQwMyeVchP713c0CWBgfmX8TTMsEHbFtuXcFv5r4r8ZF0gIoWUp
         EHBBP1p1g65Cr48nvoYz4MvvadpN6jkqC04p4HxGmqyBD+zgGrJ9QccNETumZYprgxbI
         LobA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=oAAHn+Uk;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=oAAHn+Uk;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELtlFHXMGrrFQu9kcSdK+xMHFNGbe+KQq/oSVRQzfCUIsQwzKmc9Sk0Amt5nI2aldW8q2JMIeg==
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] lkdtm: Add missing SPDX-License-Identifier line
Date: Tue,  6 Mar 2018 14:58:10 -0800
Message-Id: <1520377090-6724-3-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520377090-6724-1-git-send-email-keescook@chromium.org>
References: <1520377090-6724-1-git-send-email-keescook@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594230933949319335?=
X-GMAIL-MSGID: =?utf-8?q?1594230933949319335?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The refcount.c file missed the mass-addition of the SPDX lines.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/refcount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lkdtm/refcount.c b/drivers/misc/lkdtm/refcount.c
index 2b99d448e7fd..0a146b32da13 100644
--- a/drivers/misc/lkdtm/refcount.c
+++ b/drivers/misc/lkdtm/refcount.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This is for all the tests related to refcount bugs (e.g. overflow,
  * underflow, reaching zero untested, etc).
-- 
2.7.4
