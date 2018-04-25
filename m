Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524672477-2-3215073717690325504
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
    1524672477; b=mFkLKaVqoDtCLcRgEcgFKneFkMv2hGmF/EF6A5+IHvVTu6Xoa3
    FcLWs81I9cPXiXSH/wlXpImUz9fdLQQBdvhvuhXUu06z6p217wxTre/TfhTo8rUH
    rvkp7sV1UqYF5Ce9uoekMiTuh+FW/L03CYA5GBrNmm7HD8OTHOWLZCpKmLjT79be
    FnhS0gYLOBhskjoW6uWXSxztwBNX4ZZf0y2KOvFsnDgjtgKeek9FsCoBGcxWkHrB
    AprnKQrAcrfSc5NosfEjB82jvrNRC/xoWbGPaLaImC9k1xZy/0sFNxOqehgYMxyG
    lSlSp+3LhJi036Hs/+jNXHFcZrZHSPmnNpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672477; bh=
    ix1qg6aaj9tpMNww100rW0ntODb3Ot9Ax1KaYr/QGbw=; b=kLvXGb2hpvKZdU5V
    ynMl3nhPUTVYpnFnPRiyOzjlZiCLB8ATBwTnFyGWhxzClXQfkLnuUzx11ZGWGVhK
    6PMZ0cuan4dHptzR4WWM60J8HaH4GNrvZ/pz8ZT8CRm0K+DvFDHsNDnpxgnVWq9f
    N8HsLbHuCs4ZR6oOfF8AUktPMl/6jSfv/FAC4VJKHiVO3YJgYuLWPruawcsi+PuH
    viqdURgX3JkqCORFkQISvBxm//JYekT5Il6sSbCvkRVqxYKQk9A5p29SUjMbFf4L
    6FXxmdbfN7nbQxJ93KWgQDZp2yOONZAHsmb58fs4GuqoWXoMBI/hdvzo6KaTc9Y6
    9HgSgA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfERYfuyXNTAN6rCXSre+0+JKRkFILVYzYqKHhdK46GBfhJ+vSAbetsHoo4Svtvp7j6ETVa7sz6bjybQM2q5961VnUc6SO5OOvKkrengePWEFxxySRgLh
    7cFQk3yTri6uvutMkenG3nHwtsLAhCSZcBVqMJoA93l/v6RWpcbOvKGavJs5Xd6mO6V6RzIymNlmvRE6uTiW0K67qJAvInHBLQh8AorbfpDRnYvFHCQ5iKBk
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=wz9XmjxeAwFrORu178sA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755698AbeDYQFT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:05:19 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33469 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755156AbeDYQFQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:05:16 -0400
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
Subject: [PATCH 16/17] y2038: Make compat_sys_rt_sigtimedwait usable on 32-bit
Date: Wed, 25 Apr 2018 18:03:10 +0200
Message-Id: <20180425160311.2718314-17-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:aYuytPY9ZxuY2n95IiT46hqOMd4w2WVT4T3/vU3FunrNWAx6sgi
 9glSg5Px0nJMoKgRir6IVo7LLENiyWtav5papzV4OdHi/NztYQMDOYJxGTS4BQJtrbUM0J/
 +c6dN1cccrq2elFQL6bY2rE4X7bngj855m8S2B21QKwzOB5EQU8ObCfoZq4mkjlvrf6KmRt
 nS/7OgRQTKZ+kMseQwg3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Oosdo68u2U4=:YgtEXDoXI5qJ6H7G2PvusM
 zIdSwc9AXiAlDF1nCmGGc96+LmtoSED9ItFomRSi9kelrWEktjQ8H6J5ZE+L+3kbeiAo0oBeW
 BUVQXpAkVA91FVuXpHZEYpNjvDqUl2oEQ/gScSkHwUc408RjWGqR4/0fw/TdhCQyEOHzt5oE0
 QPy6eFTXhlB5ZzErWnDyqgJKq8SlEWtIu1o8kQEhObS6uWr+afe+3/dnbjZu+nboiE61wzu0V
 6rdRvGZHFF4W1soGVrYynkr1Nit6lfBtWgIOuo1rNvZQI7nfFuZam6uoQPX+h9/kzPVcJcZLI
 MuDsfnOU+7Ctn1fX/k+qTLj0VpGSqdt+TVmkFVrjpg9DU0DzAE/0ky86dJ1NG2CfuZ26ZaOIM
 DEHLwf3s1FG2ji3Qbv0Io2Va0f3B+oMz8Lduw8p+7qY0WVqR6lWxF0GDHQt3uxn7SMYsqXgra
 hW1tbuWjj+dOxuuvezPAitiKDNqLfxogBt6O+58woFhcHS9sxJB0z7VkCZ37LKOSf6DySKaQ9
 +goiy2827IoUnEA/gXcLC/3SDOCKlf6tEnA7zCxuD2WXTtBjDjPdgtNGUhqazlI3gtC0DT6eN
 rqLjL78uEml+wDejJRCqxZnJ3gPLKU5MmqT/1NCx3YeH+524gede1sflP6TGtLjRgI5Lkzdu/
 2fNVhnF22Kzyn3IpZGz/IVAOPzbeIknYUeVVLkV3JYMKhaSbDzMCcEVCo9XDEmn67FjA=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Once sys_rt_sigtimedwait() gets changed to a 64-bit time_t, we have
to provide compatibility support for existing binaries.  Using the
compat_sys_rt_sigtimedwait() entry point is convenient because it allows
to share the implementation with 64-bit architectures.

Unfortunately, the get_compat_sigset() and copy_siginfo_to_user32()
functions are used in that function, but we can replace them with
trivial helpers that do the same thing as before.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/signal.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index d8d68a9556ae..72609c6835fd 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3104,7 +3104,22 @@ int copy_siginfo_from_user32(struct siginfo *to,
 	}
 	return 0;
 }
-#endif /* CONFIG_COMPAT */
+
+#else /* !CONFIG_COMPAT */
+
+/* 32-bit architectures only need to convert compat_time_t, not siginfo or sigset_t */
+
+#define compat_siginfo siginfo
+#define compat_sigset_t sigset_t
+#define copy_siginfo_to_user32 copy_siginfo_to_user
+static inline int get_compat_sigset(sigset_t *set, const sigset_t __user *compat)
+{
+	if (copy_from_user(set, compat, sizeof *set))
+		return -EFAULT;
+
+	return 0;
+}
+#endif /* !CONFIG_COMPAT */
 
 /**
  *  do_sigtimedwait - wait for queued signals specified in @which
@@ -3202,7 +3217,7 @@ SYSCALL_DEFINE4(rt_sigtimedwait, const sigset_t __user *, uthese,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
 		struct compat_siginfo __user *, uinfo,
 		struct compat_timespec __user *, uts, compat_size_t, sigsetsize)
-- 
2.9.0

