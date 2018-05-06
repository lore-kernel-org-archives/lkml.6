Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3852358-1525646968-5-3431602547260573096
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525646968; b=bZAwDepd9uG+G/pyglh7UjOFvLt2HSX2I8d3ddB5khbsxm8hk9
    AvawSne5jynrDlL+l7CypE8bEodFx8Cku78SvxeXa2qOjh6nQWpQO7cNRGdRMDO1
    sH3pLaPnodKnuSPasfNUo4lwtrJxgxl8DjD1wIrfPmWmjOJXuRBCdd4eESTpsT0Y
    JOCCjiJojCK3ipSiREabuiE0RsGYNMlW++Uk4GGXyktji/7Bn+D0Ahdp+BRNxc0J
    e3izDVhyKxpvztGsjvEOG4hDS2wgFRNSePxoyR+riezberWdVleuwIFxoH65MRQg
    k8Ge9d1IfmZ3ktUduieRC61u0wV7BmIk8+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525646968; bh=
    8/FLH3TQ3os4COHYOLOu/dw3YPo8jzJ1D2NjxNvJxpk=; b=TdD6wg7UMETQvS+g
    NbJSEd3Zkbo1YL6CFN5a5HPv/1Vc1ygIz/99ffHqMMwGNsmmNCyOGx+9RSlMqLmj
    1S7wfJu3TTRgq3hIIgeRJLyI+JQkjNrIxa75rppgteNzkvJI1UdDaWpp2sAiJZjf
    +e3lE4dul7AjiHTt+bjo3xOGXl7aw6gtM+f1ir0TYw64+f/Gi9e6R/RVmugmpu37
    Ye7MKl80XRaGUUOO4M0zE7quH1G6y3LxM7KJ7/7HOtCcaTQw5zbzAeVetbE5rJoG
    7aIOsH4LVa/qB+xb15q2xZ1VPoS86w0cMP2CnEVAxCOLgt2qIJOKVW10H3Ohyjk8
    kH1UAw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ubuntu.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=aQhVOejM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ubuntu.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ubuntu.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=aQhVOejM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ubuntu.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIV4tLDSg8EvZc0olsbIeFB5lHktXLr5bv/FCU9GowWMmk64V/ePhPcMaciedTcf3xSAqt1Ex4wMr6jg7yboVaPaeQR2hXMRDZVQ9pWDHr5Drf6hlj4C
    jpdj+pKACFM6VGE6MvtqKuq/wg2FRwJZyyUMLxEEPF2dD5c74hl18zgKulhFATFld40M7MAveYJI/vxCY+XlNWMRHOHGuenIN8XcllXNeIUEPS+pWiLEIpp3
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=fxJcL_dCAAAA:8 a=VwQbUJbxAAAA:8 a=5VoLgkW5MDAwbdDaw2UA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeEFWsw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 6 May 2018 18:48:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38359 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeEFWsM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 May 2018 18:48:12 -0400
X-Google-Smtp-Source: AB8JxZptn+ZHMy9dSdfTjOXe3MMUnH/MIWhvqHEBEPq0Uib30Z50QCzkuHbssASn+XLRic4IAnGGcg==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/6 v1] statfs: add ST_UNBINDABLE
Date: Mon,  7 May 2018 00:47:01 +0200
Message-Id: <20180506224704.14669-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180506224704.14669-1-christian.brauner@ubuntu.com>
References: <20180506224704.14669-1-christian.brauner@ubuntu.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently userspace can only determine whether a mountpoint is unbindable
by parsing /proc/<pid>/mountinfo. It would be convenient to simply retrieve
this property with a statvfs() call.
This let's userspace avoid costly parsing, supports cases where /proc is
not mounted, and supports usecases where file descriptors to mountpoints
are passed between processes that are inspected via fstatvfs().

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
v0->v1:
* non-functional changes: extend commit message
---
 fs/statfs.c            | 2 ++
 include/linux/statfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/statfs.c b/fs/statfs.c
index 5b2a24f0f263..61b3063d3921 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -29,6 +29,8 @@ static int flags_by_mnt(int mnt_flags)
 		flags |= ST_NODIRATIME;
 	if (mnt_flags & MNT_RELATIME)
 		flags |= ST_RELATIME;
+	if (mnt_flags & MNT_UNBINDABLE)
+		flags |= ST_UNBINDABLE;
 	return flags;
 }
 
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index b336c04e793c..e1b84d0388c1 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -40,5 +40,6 @@ struct kstatfs {
 #define ST_NOATIME	(1<<10) /* do not update access times */
 #define ST_NODIRATIME	(1<<11) /* do not update directory access times */
 #define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
+#define ST_UNBINDABLE	(1<<17)	/* change to unbindable */
 
 #endif
-- 
2.17.0

