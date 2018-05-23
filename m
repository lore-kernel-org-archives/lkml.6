Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-639720-1527104099-3-14589316088809673609
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527104098; b=JCEiKD4LQywP9/ng7kMl2gZTsPXyOFn64EjMIO+AnquYvf3Fuz
    f0dERP8P86Cwg2tew77P62OqzQaz/WihZmYjJ04xkjzmktNv0HU3Vb+NAoZphBzH
    n8hM6RUrGfrE7U5vQwaApCL3kNbjIsh3DRVl0591dER4oPhagm9dBBx+VgMYTaDP
    BzdV91Tnv9PlwJBXU7UM7LOOoQViCg80bzucJoHdhHbcaXWvmS63VyEdDk3dOu/X
    roEtjbQLlZdU783VNlMFtRhUkod0Se386hVSJ2yZNwGHjnU7Vtqg7AmRJEG6vyqe
    2GfY8TuGc54BotdyWpnMqbBQSWHb1FLJrqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527104098; bh=
    OHSs6cba2aXI5p6vrTO/kooD0u1SzY5p0PglyfX7dtM=; b=kigQM5dhuWs3e2b5
    jQICF27LJlp9JJ1/5ANzkSYng7QPlCyBsem5QJtT3STKbbXg3M8mXx1ygVB+0HGH
    pnFmVzAfcuK+W2EMN3yM41pwLKywD/i0v8A1SfmTF2N8QHlEOJ099YI29S9W8AWU
    Jr4rkK4qtDi4vJRBYHFqmdQX4HjkcYnbw+rAOftkcvUK9fLKDq+Mq20QqyKL5MZ8
    qI8fk71+76Q5YFWuUh9ECkbranIbE2AHMs/B04lNWdkzv9iDFoQ3+cjvE57JPivU
    IkjCzvXoJqCxianCzRRdlO3nuwzdJkI8cHlhDOrcpOjqzKBdQuDCL0AjrdoNdD5d
    +kpi0w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=mHKVbQZx
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=mHKVbQZx
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO6CSBLEqaA89XH6TOOlXvbFMtDIujXbyg1c7ucru21rvU/ptypW63A+8LMBDlan3U6u65o+2qSnzjditK0zgPLA7mFvM7aGKB5sNTPO5luZs5A4JgWA
    DL4Vu/mITgGqzf2bHymlb8q7RBqPGf9CNdPzqLPhtbmMkdU91VOVD5Qk33XiEyWfkZA50xeajzOB8o7JDSeju3yeax8ltw30CYb37WZjA8ZZWVfD7UuaiQ+c
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=HZieObWGZi2sKBCXc30A:9
    a=0BbEcRPqd4U_uuMe:21 a=Na2JX_2fIBq9m8En:21 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934294AbeEWTed (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:34:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934304AbeEWTUf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:20:35 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/33] fs: unexport poll_schedule_timeout
Date: Wed, 23 May 2018 21:19:52 +0200
Message-Id: <20180523192022.1703-4-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523192022.1703-1-hch@lst.de>
References: <20180523192022.1703-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

No users outside of select.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/select.c          | 3 +--
 include/linux/poll.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index ba879c51288f..a87f396f0313 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -233,7 +233,7 @@ static void __pollwait(struct file *filp, wait_queue_head_t *wait_address,
 	add_wait_queue(wait_address, &entry->wait);
 }
 
-int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
+static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
 			  ktime_t *expires, unsigned long slack)
 {
 	int rc = -EINTR;
@@ -258,7 +258,6 @@ int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
 
 	return rc;
 }
-EXPORT_SYMBOL(poll_schedule_timeout);
 
 /**
  * poll_select_set_timeout - helper function to setup the timeout value
diff --git a/include/linux/poll.h b/include/linux/poll.h
index f45ebd017eaa..a3576da63377 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -96,8 +96,6 @@ struct poll_wqueues {
 
 extern void poll_initwait(struct poll_wqueues *pwq);
 extern void poll_freewait(struct poll_wqueues *pwq);
-extern int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
-				 ktime_t *expires, unsigned long slack);
 extern u64 select_estimate_accuracy(struct timespec64 *tv);
 
 #define MAX_INT64_SECONDS (((s64)(~((u64)0)>>1)/HZ)-1)
-- 
2.17.0

