Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159885-2-11044920590027973855
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159884; b=i0rfaw77aC3TjCIisCotIEUrti0bdFITL+00GzOnFF0XVi326/
    pd/uWebi/QsDOS3UvXjPSJQs426nflIAdkqlLCodvaQ+14KMnVQ2oyGKlftUs65d
    on5SAt4B5EqXqO5udvRnGNmwlQFspO3YwXk2oNoJjgUgMXZ/l2s6SFH6LcpXMA5d
    gHErAIhOmRHAPrlVGqlb19HezYtQOc2tl53IVbifTgYP4RHf90wj9fcZ5X6dnhb5
    gEeRyLvPc+9xb2tasDvdRYjwUhzmjVzJKdLZzuY7O9rjm4OmJS+svAoykONH2lxu
    8YPhOqBymVsXokEJ58VP0OoytpRJnkA7vqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159884; bh=DUUOGNzSUweyFgZp64VfNdfW/Is5x4
    +sUj9/476A/QI=; b=CMRznL7g1HxJjWwBqah7Gh7VYdC85Oj/xxgQPU4n9qH80h
    Ec43Zkc+fGhJwaU6CGYOne2I4X7J+DSErQD/ow7KCz1XI94aln3ovtjeJnBACfRt
    6/1AmCBNZJpBgTR34PCJgaCrqV3Jjpd7tS6OCitJCT/gNHXtx+sxm6qZ9FDYcMqd
    Nsf+qlQCqN3KhJRPmflZPCHDcSCd+Zfu/TO7US2H6s2xttEmzLpYsQNoo9GmUF6R
    UKDsTc+NzgRQe+tPitRKK72mnYQNZ52xlVzCAh1QHAznB7eHempvMe6hwaj6Joh2
    p6ljjUZZMV6XhLHkAxyM40JsJLrRyMLfDLe9ICUg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=dgMp9Zde x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=dgMp9Zde x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMco86mycpDFoafCvz8txbN8FTb5a7ZT/ypgd6riz5yino3sENteYutm4fWS5lIYwQkapZ9LhZEDcESF6oraLg804md+wKljOWGTbtHIBYqx03xhSBP4
    H3X0E00rmSBhlRDAmcAbHXJGu4QKCQudv3YwLUi4qlzCcLPgPjUK6qr3+r/bASt52dh9L+PBq2s4aF0LZbo+p/3ImukvskeaMWRQU2a6dFbCCKPmktu0Ycpc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=zd2uoN0lAAAA:8 a=FNyBlpCuAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=T6WSELt1YKfGCVLqg8wA:9 a=QEXdDO2ut3YA:10 a=RlW-AWeGUCXs_Nkyno-6:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968348AbeEXJzY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968350AbeEXJzV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gary R Hook <gary.hook@amd.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 093/165] crypto: ccp - dont disable interrupts while setting up debugfs
Date: Thu, 24 May 2018 11:38:19 +0200
Message-Id: <20180524093625.785791316@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 79eb382b5e06a6dca5806465d7195d686a463ab0 ]

I don't why we need take a single write lock and disable interrupts
while setting up debugfs. This is what what happens when we try anyway:

|ccp 0000:03:00.2: enabling device (0000 -> 0002)
|BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:69
|in_atomic(): 1, irqs_disabled(): 1, pid: 3, name: kworker/0:0
|irq event stamp: 17150
|hardirqs last  enabled at (17149): [<0000000097a18c49>] restore_regs_and_return_to_kernel+0x0/0x23
|hardirqs last disabled at (17150): [<000000000773b3a9>] _raw_write_lock_irqsave+0x1b/0x50
|softirqs last  enabled at (17148): [<0000000064d56155>] __do_softirq+0x3b8/0x4c1
|softirqs last disabled at (17125): [<0000000092633c18>] irq_exit+0xb1/0xc0
|CPU: 0 PID: 3 Comm: kworker/0:0 Not tainted 4.16.0-rc2+ #30
|Workqueue: events work_for_cpu_fn
|Call Trace:
| dump_stack+0x7d/0xb6
| ___might_sleep+0x1eb/0x250
| down_write+0x17/0x60
| start_creating+0x4c/0xe0
| debugfs_create_dir+0x9/0x100
| ccp5_debugfs_setup+0x191/0x1b0
| ccp5_init+0x8a7/0x8c0
| ccp_dev_init+0xb8/0xe0
| sp_init+0x6c/0x90
| sp_pci_probe+0x26e/0x590
| local_pci_probe+0x3f/0x90
| work_for_cpu_fn+0x11/0x20
| process_one_work+0x1ff/0x650
| worker_thread+0x1d4/0x3a0
| kthread+0xfe/0x130
| ret_from_fork+0x27/0x50

If any locking is required, a simple mutex will do it.

Cc: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/ccp/ccp-debugfs.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/crypto/ccp/ccp-debugfs.c
+++ b/drivers/crypto/ccp/ccp-debugfs.c
@@ -278,7 +278,7 @@ static const struct file_operations ccp_
 };
 
 static struct dentry *ccp_debugfs_dir;
-static DEFINE_RWLOCK(ccp_debugfs_lock);
+static DEFINE_MUTEX(ccp_debugfs_lock);
 
 #define	MAX_NAME_LEN	20
 
@@ -290,16 +290,15 @@ void ccp5_debugfs_setup(struct ccp_devic
 	struct dentry *debugfs_stats;
 	struct dentry *debugfs_q_instance;
 	struct dentry *debugfs_q_stats;
-	unsigned long flags;
 	int i;
 
 	if (!debugfs_initialized())
 		return;
 
-	write_lock_irqsave(&ccp_debugfs_lock, flags);
+	mutex_lock(&ccp_debugfs_lock);
 	if (!ccp_debugfs_dir)
 		ccp_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
-	write_unlock_irqrestore(&ccp_debugfs_lock, flags);
+	mutex_unlock(&ccp_debugfs_lock);
 	if (!ccp_debugfs_dir)
 		return;
 
