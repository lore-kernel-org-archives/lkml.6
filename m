Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3352333-1524148893-2-14268765383695451465
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
    1524148892; b=LEPVRzL6J0hVrhUd5GeDnyv+no2sXifASOKjBzB8X/1JuQx8F8
    mbVOWCPFa05nEu+/NIPxM+cpgZ+klHYxng4PkHdkcihvAYtjRI6+xubaSeDiA4Qm
    p5KwjiWVp/y6kz332UENWNd1OBpaKGz+OnExRsNK2ID8qg4BZU9SrnAS5kZzOh58
    tNmZ/mutez0s/ls0GsJdjXElTEEhHkT3MVPbFaXXgyzIELZLrohd7Z8l5JQLLHlS
    qKw4xb0WULFemaB2Gl8qtDXjJcZ+1XGHuv2ckofH+OLxK6YRYDyoYLwwHVzvV59r
    sF8N2QodgNzqUFvqjqV8XtaP27DI84y89W0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524148892; bh=
    dD9ilnbSt7ngRxD4OQwY+h9xAMs7la8MYipbcP4yibQ=; b=u9msRbRz1eIFhW9o
    HZG3FHhfKzo8/X0IGu1Aya5byY2oRHCbXJWzuae8FUIpuelzEDnEbbITPbs7Br6m
    INUJDiZm5isk7CtaytCF1VTUB7Qu9T1AvSfqzgfCoXSU2g/q8HkjE9ttixpTpWRX
    orA/VKWBers+WQFu0gdHhfDF9y1HhagbrtVNKXWQxv53YORc1oDPoijT9VIkgavH
    by4LwuMiTwZve4SHvmJS1e7K6fHUYMsODrMq0KHW575TdhoS5begZP4THrVCNfme
    XpTKs3+HRpdgQVSlUqf4NxUP5k6aDOtduJrqhwfNZzfyeOMPghhauStUJREAGaK1
    yaPzlw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAVXRNAqFUrGEUdVB0GN5SturoAxX1rYpDXvFKrDkQ6nmtTi0XYDq5WEFP+uHYQqk+yGXT/ytfhxqOF/7R7wVXbvq9kKv82+C1JeLXDCE0j+zJziJRNT
    3Sn88l3XtOXxeHOhKUsNMLcNkRaeUjW9JEpUWIE6ZJLm6ZSC/HW53m36oajfq2bOozNlZ1jEHcPpJXTsfvjY9TdlzutSi7lRrktynL5xscVEXNRpowbwiWVV
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=nfMvwj1s_EtHegV2GFMA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeDSOiz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:38:55 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50375 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753359AbeDSOix (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 10:38:53 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        albert.aribaud@3adev.fr, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, x86@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v3 16/17] y2038: ipc: Redirect ipc(SEMTIMEDOP, ...) to compat_ksys_semtimedop
Date: Thu, 19 Apr 2018 16:37:36 +0200
Message-Id: <20180419143737.606138-17-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:taoylyHn9hPzLr8FvCdtoSclzmM7wtpNeibvAXK4GS65SL861VQ
 GVWSy7pErm1JOGiMO0VOzhm9fNOISb9xqito4CfsTGt3DzOCBp6R/kK0uODsoMyEV4y2VDf
 jBp3PyV98WDwgoZGFYXP7HUNuMJAGGiG3XyQpFUCHs0S0TESX0JweLqM8+ejD010uTrK9fL
 yCTQgNsVmi/xIwMSkzJTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wQXGZSTpe0U=:a/xBmS8XT/fFtn9/F9/ipp
 Y6bU55DSx34IJD2DR9vhY8W4gBLt1pQBF4swNmKRid5DyoGpkQkSSBuq3clFURdvSdreXTHPd
 o5cp4UrAdU8UHRZa4ePr04Igj1dJodu1ZjeIyfdREmGyTw66ND8BTVcEDQETzxEdn5ro8nIn1
 urhbE7cqq1GADF5lprGO1TV6azwqVdKM9Vtt6+A38DWb1jGMGx3baOHN+qsJaP4r2L6xqAPcd
 rJ6BaIhL1mzeg7nmWfzcyghexZB0H6+XAEuH3AMu9jqEjnLql9HCBGi1+YUnBKj1jzQYPObFp
 EJV2ERi/VPG+uB3/Mw/deLcTw/+wFdb+QFs8NnJTamZSeBa25aVEf8jfHoW7Lg51QBUQ1Eu+S
 rUrkiQJnrC8TVvrORGJFg/IdRu1LaYVQ2vcbrYy9f33278zFJ2/VGSWwg+koCfW+jRL2JiO7Q
 7weOL93sEVrqIZKYKxQ4QLTovcEfPT8P+Yh6yVqQnhguSKpPmQ2VPgNkEqHHzrvD2Ob7QbilG
 0uUK91A3w24KSn+Z9kAviq+nMVKe+2JXfhg7p42OqZY/utJ1OBuwrpxglMNYYiPmN6rjc4jiY
 pZ6JKIRt/BiMOpTA+ggj6mQKha71uNHr+zBMh8vBa6/vQ08oHxAsnyEnk+ozKocaL2RbGBuvF
 aQskQF2J3Kb0E3/esu5wGPlYsSAezYR29Wkc7Gy1WjESEzub8U8lx1qqZzu9wRvanhw5B/Fae
 DHMfIVamC4m3HSXx9c+8SZeh+uq64aLi7u3E8g==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

32-bit architectures implementing 64BIT_TIME and COMPAT_32BIT_TIME
need to have the traditional semtimedop() behavior with 32-bit timestamps
for sys_ipc() by calling compat_ksys_semtimedop(), while those that
are not yet converted need to keep using ksys_semtimedop() like
64-bit architectures do.

Note that I chose to not implement a new SEMTIMEDOP64 function that
corresponds to the new sys_semtimedop() with 64-bit timeouts. The reason
here is that sys_ipc() should no longer be used for new system calls,
and libc should just call the semtimedop syscall directly.

One open question remain to whether we want to completely avoid the
sys_ipc() system call for architectures that do not yet have all the
individual calls as they get converted to 64-bit time_t. Doing that
would require adding several extra system calls on m68k, mips, powerpc,
s390, sh, sparc, and x86-32.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 ipc/syscall.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/ipc/syscall.c b/ipc/syscall.c
index 77a883ef2eca..65d405f1ba0c 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -30,9 +30,14 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 		return ksys_semtimedop(first, (struct sembuf __user *)ptr,
 				       second, NULL);
 	case SEMTIMEDOP:
-		return ksys_semtimedop(first, (struct sembuf __user *)ptr,
-				       second,
-				       (const struct timespec __user *)fifth);
+		if (IS_ENABLED(CONFIG_64BIT) || !IS_ENABLED(CONFIG_64BIT_TIME))
+			return ksys_semtimedop(first, ptr, second,
+			        (const struct __kernel_timespec __user *)fifth);
+		else if (IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
+			return compat_ksys_semtimedop(first, ptr, second,
+			        (const struct compat_timespec __user *)fifth);
+		else
+			return -ENOSYS;
 
 	case SEMGET:
 		return ksys_semget(first, second, third);
@@ -130,6 +135,8 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 		/* struct sembuf is the same on 32 and 64bit :)) */
 		return ksys_semtimedop(first, compat_ptr(ptr), second, NULL);
 	case SEMTIMEDOP:
+		if (!IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
+			return -ENOSYS;
 		return compat_ksys_semtimedop(first, compat_ptr(ptr), second,
 						compat_ptr(fifth));
 	case SEMGET:
-- 
2.9.0

