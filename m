Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524672278-2-12072905854716923314
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
    1524672277; b=tjw+t4MJqATUy60KyNM0nvlZ5u39a1CGb6YANK9M9URFSY4yqr
    2uZR4UsCEzbpfrSAk0RSEww2f1XqRGaxnZjLrK/duVr329M5m4l7WUGVm4eogYhB
    V0mVZbyh560Gdd1qiC30IkxIMx4PxLt+zkImARS+wAEnktZlD6eJuf8G12+3LRzx
    opRlHYg/FRNHPqu7k+i5ACGHOkpuihf2vXlfdsVIdlP7ZXf+ouJZ4PTnWKTObfrb
    LPbOMbwTHvzu2GRd4kIkUKsAsAp0H+07bqY98IajJHkGx6EpjK11rWwyd6xhxPci
    vOKCSlrdH3MBv45/qUX89HsrJlivSMMlbjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672277; bh=
    vSwZBJKwJ+bVFrpimY3P5kJVpg9EDLF30TLfvtrMRs8=; b=H+j6ICOLCk64A9ms
    EzcxDYd4HDtiHgR1WQMl/IEi2uulmMxebnx7ajQpCEVSqf9A6cYvpEY0wfHfZhtL
    WEwN2LiRLWgOgcsk7CkStR5dPXNySLKtj+FByKi5xJ7mf116wW2eZOFY+/UUmQ2/
    3RvCuwCHrHCW/KusvZ7GUYGXLAdwqjvDBDyV/XgzFP1G7dRUrQe3l7WJGJ2Vyueb
    xWXvrJvvw11wxJQinaovIlG+POwqUak6ZjJybnUCeQMinOEx4Hfes1sTAvIvRpBo
    zVYuo3g1oJ1SUlPVwHUPxbzBF9wrISri3nSkRw8SF2q+pg79zEbH8dVYwpOS1q67
    UD7AAg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfKvG7KrsxjLlFJ0cCAixtRa9sGz+xPlmitfbZHIAdamM4Yl+hwuzHWWFsMNOsb+rvl8Vodi40HBqXeozBihGhxGljcS9/QhAHc81WdmrQj+/TGIFKCQH
    //MS85GxuLvSSWoE3TbIQOe/UhezxD9x4eL/IrwGqnb3Kvu8alenXzrCGQA2PsY/hQmcyw3TMv3JnjnVqdPlgEcgh8dmOKgV/U0Z6z+fk515mdzZMXQr+wEz
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755752AbeDYQEd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:04:33 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755687AbeDYQE0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:04:26 -0400
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
Subject: [PATCH 05/17] asm-generic: Remove empty asm/unistd.h
Date: Wed, 25 Apr 2018 18:02:59 +0200
Message-Id: <20180425160311.2718314-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:Iqhu6K5CFPzkxjpoVKOS/JYGU7MWmLrn22hfZ05QYUSkywuDiAR
 SSmoJVcI8IoJKA+EAgTkitYfloXSJyepaRXN1HBwbd2FhWxr/fMro8nkyzHGiHNfoMofZjc
 NHNDPAS6T2dipAbffSrB6GamA3/jvZkOtJ1nUB4H4JO0lAfzeP6XjU1xgAGXA7szGyTEBL7
 RT3+A6wrmeSs2FO1bjuBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cF4Rt6VqImo=:f3kBY75BnxBLFdMCi7joox
 Xno79JNaZnwmHHYiwVC1c3mOXlc0G+lh06h8jEK1q262qXk/n3CfiBg3darvN9+b5we4Rg5s8
 Fp/mZA1eRdAerXkaoO4onnsPifzfR4DIgu4WYti5r3679GodnYTr/QEIxw8P5/ZW5q6ecV+NK
 wgQwIBSpdcLeBFYjmS4EYZYBnIoDZQ/9ZyTcHAA3JHFnQrsB3F+/EVLBc+mo0E9nYe3O+92Rg
 bBRZgdfeBjplkQ8cHA3SPzM7rTO5oQfg3cwPqkHyZ0+6ib+UCPWqTZP5dOdEgZUGJcrrlFU3+
 d9KgIJ5cXM8Cco5WL06KImVKghavfRwKYEj8OGD0gZTyfJOhFBVOPzFIem2ioc/MMKqV2LelP
 7MienlBWF1u9LefrRZFHaY9G0P20Vr04DMimcoj3kJKsKlS5BdtvG16VqKKxnydMSICtl2C2L
 N3XbtWsXKSW6A7wTcKTyzTXj8meOXyFLEHWSr1eOoJoExWWemdbB3FnlEkVUkF8OrIlDJTJJq
 eLyiEiMCFSjJ4QqOfrf81q1Jqxe3fmNwpvuiD9aPMkc9pOlTVAp5VgcXe3Rj+2TudcuKxfr+C
 QcHuXYS0mHd81Ibit10duOpmbdcJk+DARRU+CfysM9lXg7C+tHRFE3ispwhhR2Z7C+q3qvmkb
 I3aoh8TbcK4QpDigmZU92oTJxeyum2nu8lePuxRUnuGNVQqslQxJmNYeO8EAU2ibroXw=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Nothing is left in asm/unistd.h except for the redirect to
uapi/asm/unistd.h, so removing the file simply leads to that one being
used directly.  The linux/export.h inclusion is a leftover from commit
e1b5bb6d1236 ("consolidate cond_syscall and SYSCALL_ALIAS declarations")
and should not be used anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/unistd.h | 3 ---
 1 file changed, 3 deletions(-)
 delete mode 100644 include/asm-generic/unistd.h

diff --git a/include/asm-generic/unistd.h b/include/asm-generic/unistd.h
deleted file mode 100644
index 71d2fcf9dbcd..000000000000
--- a/include/asm-generic/unistd.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <uapi/asm-generic/unistd.h>
-#include <linux/export.h>
-- 
2.9.0

