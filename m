Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524672486-2-124165725358877297
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672485; b=BJpwW6JIwSCf+p9XcBEL8ilacBIGu7Ne6q1O0f3+At0GTpucso
    PQcAww5KmWgWbGERR4ZSPCelry3qZm4j5B5b2KK4EHPEi4lsfGKPje/FvVoC6mm2
    azOEK+nLQNm4BG78hXhuOxZD/FcEHeoJd/dEfDuT2sKljUoVdgG+E720vaT213vd
    BK6cYz0mprtL5ph232jnZm9J4AkyKwIqafqsl08pwK8Wl1g3xzFFA5ucO9SN/P/Q
    qHnPK6pkWrFy8jvsgawzEXik0GG9YYQxMvRtnelBhY82KVjN7grXmSF3bKWet9oU
    fjCMqTgeWwlwVLXinzlsPdGjfkB9qNcXUVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672485; bh=
    FZk2mwsvemIwr9I6gaos0ju0M+SiOoIXhFpPj3hgrlM=; b=b0SEFdHUK0OW5wSp
    7b9v2Nc92O5sMMLuuvegDZ4ni8dnpZ3GcPwcIjl7RRmCUe2wVCy0zbqWoP7ecTDY
    FcUWhr6fDOM4EIANsvRJAJFLa1hhNLxfosdBcsonhU1jIWW8wmY5yxW7vAwAHzaV
    Yjmzs+fg+yyHlBXPAnKCXvQ9R6UuUrTMJyELMB1sozef9CHP4D9W+kuKnBoIEFOf
    MkyrVI7U/Zz7tnPoH9lFkFYYu+6oUhtZpechW6kiO0eWFdh6XCnZLRyXFZyHo5ky
    yBnvpWOnlnA4iLPHpmGVoSlEpFLOtXjDKb9DiRBjcW98MMcKoe2eX6cB7FWIMcab
    O3Hz1w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMuZbl/oVCB6ZYRji5tUCJxkgcWz4hLG/5a+05TSJeSq0HF/B8yDfi/qDp8GRYWjzu42hDUv4wPnNq8s5D5JdWT6sI5JDG/QrtBlKb/TwUWjiqvuV8PC
    Xl/DFyQZZO4toiNMZBfUVZXjFTtKHJBTcwJ03OuA4r3fFL1LLbh/wTiOCSRg9jczSdRe9PJRmX+6rs0Jy14y6jCudjmW/2sl2YLf1jyqYMRpHZ2+pHUWSWzx
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=VCx0LXix7ME5Neo_Bg0A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755501AbeDYQFS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:05:18 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52585 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755253AbeDYQFO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:05:14 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, netdev@vger.kernel.org, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, albert.aribaud@3adev.fr,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 12/17] y2038: aio: Prepare sys_io_getevents for __kernel_timespec
Date: Wed, 25 Apr 2018 18:03:06 +0200
Message-Id: <20180425160311.2718314-13-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:4GGlfMGZlOC11z6Bn22ipNGC4iDwHQ1nTxVWJPLi5JaLxEbhSKq
 KOB7JEmzwnPUCLpov7GluLo1Pt7CTxcZdqYPLRBmBgPV1kQSkxeMRL1+hc/eBqN4bDG6ocF
 eO1eomsjj9jAwluqw7YFkb4vCIt9efD1q/AcCGgWpn4l5ro8D2TIggbYHOpMDc0JiX2V5dF
 j8jBy0yb9bddnBJPQfMnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yEzicpM9y5s=:GpoynPZ0JPhbV/v2tedIep
 RiZj6qO2l+Et5w68oHl5mFXevFj9/TjsCD7dmdq/rKHrb1HtR5/0DjIVh+OaJfZZ2Bxg2r0r5
 1zoiObLi9Ihs9Hdt6crf8uu3J3Sdvbdi3CJgfFAXkMZ3ANZf2ZkmpSL3J17cMyCJs5hhzPO42
 dW0ZlYzgZ6ScUPYBh028Y0DOwyy/heMkeOOmZBciQowcgWWRP/QDUTJszPPIzeZrllsTcu+um
 AqBtduKuUtO4OhkdjeaYBuQPe1vMXrcdbOVDiTwiIWH0bJV/ISGG3eRhJY4F1XTe1Rz0+eA95
 UngF8AQvtdMihJwto5lwH8Acbykl8/KzM3hns5QYwTmDkfTTjyCVuHVm58oDN8BF10/nImNxq
 yh7BNLZQWJtoj6kUlb+2agKcHp9DbP1H+CBiTv4aoQ5Y185wziuuOiblh70MG03wespO5DCeQ
 M1eb+1NIZHSYimOiK9imrz7M6cWX7QKX0mkXqoL4NpwmRqCgSBsFPFsB9pO7BOLV11zpvgfEq
 r6D4CdH4kEZ3+T0Vk2mApvJonmrxHCme3Ld4ghN4lbOrjOopHPavbIasna5/JirWwXp0ZLmFN
 TGNvAHT/tXUTZep4yLrwG2L533CWDluYCTkERN6BUYMPZWHjh4a2fPWjyEE4YeOIlHIZMgJEc
 /eC9Mjs5KEwc6BUL63kr3ARnpxXHPBqcxUmyBIcqvZCsTwPA4C+0yZg033UK9oUOWK7s=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a preparation patch for converting sys_io_getevents to
work with 64-bit time_t on 32-bit architectures. The 'timeout' argument
is changed to struct __kernel_timespec, which will be redefined using
64-bit time_t in the future. The compat version of the system call in
turn is enabled for compilation with CONFIG_COMPAT_32BIT_TIME so
the individual 32-bit architectures can share the handling of the
traditional argument with 64-bit architectures providing it for their
compat mode.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/aio.c                 | 4 ++--
 include/linux/syscalls.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 88d7927ffbc6..64fea8c27b16 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1858,7 +1858,7 @@ SYSCALL_DEFINE5(io_getevents, aio_context_t, ctx_id,
 		long, min_nr,
 		long, nr,
 		struct io_event __user *, events,
-		struct timespec __user *, timeout)
+		struct __kernel_timespec __user *, timeout)
 {
 	struct timespec64	ts;
 
@@ -1870,7 +1870,7 @@ SYSCALL_DEFINE5(io_getevents, aio_context_t, ctx_id,
 	return do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE5(io_getevents, compat_aio_context_t, ctx_id,
 		       compat_long_t, min_nr,
 		       compat_long_t, nr,
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2619678359ee..ffd8674e9df7 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -289,7 +289,7 @@ asmlinkage long sys_io_getevents(aio_context_t ctx_id,
 				long min_nr,
 				long nr,
 				struct io_event __user *events,
-				struct timespec __user *timeout);
+				struct __kernel_timespec __user *timeout);
 
 /* fs/xattr.c */
 asmlinkage long sys_setxattr(const char __user *path, const char __user *name,
-- 
2.9.0

