Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3782484-1526037009-2-2562820623078720605
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526037009; b=bi7KrfmvMBXNn1A1UTVj+WWeJ8KxIfaI5a1cW+rSsk5f+Qp+fc
    C9sQosD5aU74wEpzOm4r2jIbqAy/oiEBKkW3Suue//cDaFZ5W4DSJXfscLq5NsV5
    2IBaGGENOduA87WaU1pY024kL/dQ1883eVIRY27ds6/1ktug/VxTY/Rgg9gD/4n2
    q33Md8xsuL5Qk/5kCem5W6DRVcyzwKY5mtXX6Yniqn7ryStrWQzhRlLlDXS4H3yw
    FgT1HHUm6NAc+03JX4HG352gvD6+Y/kArKthYNCmarGZYJCtoxr/hKCABWqoXxBB
    KhkndWkVWjS/VpvZ/oKJmOJ6L1JQJnwBzUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037009; bh=
    uJn/To6VYUDEjKcSYub3SdH98zvS9dNsSYgNjfzCeB0=; b=AaQ7Ke+F66Af2qRO
    dL4kPRg3VOdUZiXPdjWzBNhC0wA1HZuCOD8BrZp3h9TYQzjruwZymuxAn92i50G+
    sfGY+MoUZ6u9H5EGdcbgIygRCxnJ8Mw4hlQ+gxDqCya22HouU097anEOf1zmEbFF
    DaxLhzvksuBZvdfFlJteBQ/oPWTtR/xAzG5nzx+/EwkHdYfDgRe8XuBI41Y21jht
    Ml6pumAu3dOxldqBxlAFeHB15oUfjSz29ss9hxMAdgJhPN6xtXIIHCLqyOqjmeZK
    SFGd7PyXZq/xEYlF2J21KS9F5SEyzIsv9rqc5ltxIQuT0gqdPOKXLxSkjhbPVGHl
    Vd3O9A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=ZwxC6TLH
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
      header.d=infradead.org header.i=@infradead.org header.b=ZwxC6TLH
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
X-CM-Envelope: MS4wfFLFGXo5YEBlpDPoczARm4RgdMx7ksdySeUQVb7CNpYVADLbkFf72Ss+qCRvlKWDhPg9hpYAA8kLelh/rdAz80uyIWVRlgMHnboXxaGF9cQ1LSuWsniX
    HRgYwtHLNeydY9bANwf4rtBKKoNs5tcuYYuvpmLPpCGqDCh8lropiwxptnqkWIkuBA2zqYDvl8NDQsqtpjb4oHTYMDVQBOqYBcd4y2WiewTYxA1rlYS/jEOI
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8
    a=VwQbUJbxAAAA:8 a=dwbJVg4bI4FPQ6Sax70A:9 a=J8stc7JTyTpJgnB_:21
    a=cpt_DQMj--x9qBRp:21 a=x8gzFH9gYPwA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753504AbeEKLJs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:09:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752959AbeEKLJq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:09:46 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 32/32] random: convert to ->poll_mask
Date: Fri, 11 May 2018 13:08:03 +0200
Message-Id: <20180511110803.10910-33-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511110803.10910-1-hch@lst.de>
References: <20180511110803.10910-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The big change is that random_read_wait and random_write_wait are merged
into a single waitqueue that uses keyed wakeups.  Because wait_event_*
doesn't know about that this will lead to occassional spurious wakeups
in _random_read and add_hwgenerator_randomness, but wait_event_* is
designed to handle these and were are not in a a hot path there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/random.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index cd888d4ee605..a8fb0020ba5c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -402,8 +402,7 @@ static struct poolinfo {
 /*
  * Static global variables
  */
-static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
-static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
+static DECLARE_WAIT_QUEUE_HEAD(random_wait);
 static struct fasync_struct *fasync;
 
 static DEFINE_SPINLOCK(random_ready_list_lock);
@@ -722,8 +721,8 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 
 		/* should we wake readers? */
 		if (entropy_bits >= random_read_wakeup_bits &&
-		    wq_has_sleeper(&random_read_wait)) {
-			wake_up_interruptible(&random_read_wait);
+		    wq_has_sleeper(&random_wait)) {
+			wake_up_interruptible_poll(&random_wait, POLLIN);
 			kill_fasync(&fasync, SIGIO, POLL_IN);
 		}
 		/* If the input pool is getting full, send some
@@ -1397,7 +1396,7 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
 	trace_debit_entropy(r->name, 8 * ibytes);
 	if (ibytes &&
 	    (r->entropy_count >> ENTROPY_SHIFT) < random_write_wakeup_bits) {
-		wake_up_interruptible(&random_write_wait);
+		wake_up_interruptible_poll(&random_wait, POLLOUT);
 		kill_fasync(&fasync, SIGIO, POLL_OUT);
 	}
 
@@ -1839,7 +1838,7 @@ _random_read(int nonblock, char __user *buf, size_t nbytes)
 		if (nonblock)
 			return -EAGAIN;
 
-		wait_event_interruptible(random_read_wait,
+		wait_event_interruptible(random_wait,
 			ENTROPY_BITS(&input_pool) >=
 			random_read_wakeup_bits);
 		if (signal_pending(current))
@@ -1876,14 +1875,17 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	return ret;
 }
 
+static struct wait_queue_head *
+random_get_poll_head(struct file *file, __poll_t events)
+{
+	return &random_wait;
+}
+
 static __poll_t
-random_poll(struct file *file, poll_table * wait)
+random_poll_mask(struct file *file, __poll_t events)
 {
-	__poll_t mask;
+	__poll_t mask = 0;
 
-	poll_wait(file, &random_read_wait, wait);
-	poll_wait(file, &random_write_wait, wait);
-	mask = 0;
 	if (ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits)
 		mask |= EPOLLIN | EPOLLRDNORM;
 	if (ENTROPY_BITS(&input_pool) < random_write_wakeup_bits)
@@ -1990,7 +1992,8 @@ static int random_fasync(int fd, struct file *filp, int on)
 const struct file_operations random_fops = {
 	.read  = random_read,
 	.write = random_write,
-	.poll  = random_poll,
+	.get_poll_head  = random_get_poll_head,
+	.poll_mask  = random_poll_mask,
 	.unlocked_ioctl = random_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
@@ -2323,7 +2326,7 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 	 * We'll be woken up again once below random_write_wakeup_thresh,
 	 * or when the calling thread is about to terminate.
 	 */
-	wait_event_interruptible(random_write_wait, kthread_should_stop() ||
+	wait_event_interruptible(random_wait, kthread_should_stop() ||
 			ENTROPY_BITS(&input_pool) <= random_write_wakeup_bits);
 	mix_pool_bytes(poolp, buffer, count);
 	credit_entropy_bits(poolp, entropy);
-- 
2.17.0

