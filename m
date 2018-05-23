Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604614-1527103958-2-14508885564019540779
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527103957; b=gae9aLvihjaXC3fXyoipmK4t2cxvarQAgbg6Qy/t8uJFl5veAm
    zvKoVFT5Rw5PX/N5dwEuJ0MrNvOOIXJCTr7shkyyyNMaef+OOwgViEPceT0QlVBr
    OBfE4mRU9fsV29OAYTOBhOWWEBM90cjpv56FaweEjVi66OBEHewNjIL3eQ05Ngzm
    ac4Bc+NM4fwv0L6oB/G1Gr10csOEUjnYeqmb56klIMxhBU/eKgSEotFz3MhQsVyE
    tYOFDELb+COS/arS4TxaTwlwHwMostT5iA5w+/S+klfSapFDJzQrbWdbnRpaRysL
    M3+Qs/kxaHFstVgRK6DI4Sul48WWMgfHjopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527103957; bh=
    SZiybqDorOBdOoHbWEJfjxKykUtWm2yCickMYUsVb8w=; b=RhMWZ6gA86u1wYsm
    PIJbfttwYtRB9TlavDJF8y7AICLySF75AIxkL6oGV5cBN/0FumXknLhpB0zaMiwA
    Q6GP7dSjgsbagpTIH2dNWi/OPAbkxtiA+Y15vW9F1pgAy4EGuKVJ6IEdTTLOrDyF
    Qr3IB94I5rMlmRO6NNoI8Dtfv65QLf6wVT4Sm4/GrONQUavztVk1NYnAtAR/aAAl
    oSHJLP6Tbi2rMXY0D9KMH1X2l12JMOXTkK0w0z5+xjAxkClCeiEICUZ5cwCaPNGV
    q4Mk2rPT2r9I1JDZ+dw5l6mNHBz0JSgxWzFyXXBJPpyyderILAHsHj7VbCrHp84E
    OJAXCg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=YyTAHrj9
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=YyTAHrj9
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
X-CM-Envelope: MS4wfK6fkhCHZExjUTedclMFhh35wTdXZoAKVntYdP4XHCn4JJ5kArFLkGsMOuai674jdKjG9r1HUThYIh2veSkFEqFGcrr5aD+AGSFjK+Oo/47Dmo8qaM5m
    IJ/cWrzmvVDj7hUXSZHspheP00k+VyZZlpDW4PCvmrnQLWL8WLJUIMRNrHGDxgZQlQCe5ueLh3G7oN1qz5Q9iRYeDahosmf6l90ApjmL3IqC1zu9p2R6udCP
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=JnQtrk894sWXMCzT-YUA:9 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934362AbeEWTcS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:32:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934368AbeEWTUq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:20:46 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/33] fs: introduce new ->get_poll_head and ->poll_mask methods
Date: Wed, 23 May 2018 21:19:56 +0200
Message-Id: <20180523192022.1703-8-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523192022.1703-1-hch@lst.de>
References: <20180523192022.1703-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

->get_poll_head returns the waitqueue that the poll operation is going
to sleep on.  Note that this means we can only use a single waitqueue
for the poll, unlike some current drivers that use two waitqueues for
different events.  But now that we have keyed wakeups and heavily use
those for poll there aren't that many good reason left to keep the
multiple waitqueues, and if there are any ->poll is still around, the
driver just won't support aio poll.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 Documentation/filesystems/Locking |  7 ++++++-
 Documentation/filesystems/vfs.txt | 13 +++++++++++++
 fs/select.c                       | 23 +++++++++++++++++++++++
 include/linux/fs.h                |  2 ++
 include/linux/poll.h              | 12 ++++++------
 5 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 220bba28f72b..6d227f9d7bd9 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -440,6 +440,8 @@ prototypes:
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
 	int (*iterate) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
+	struct wait_queue_head * (*get_poll_head)(struct file *, __poll_t);
+	__poll_t (*poll_mask) (struct file *, __poll_t);
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
@@ -470,7 +472,7 @@ prototypes:
 };
 
 locking rules:
-	All may block.
+	All except for ->poll_mask may block.
 
 ->llseek() locking has moved from llseek to the individual llseek
 implementations.  If your fs is not using generic_file_llseek, you
@@ -498,6 +500,9 @@ in sys_read() and friends.
 the lease within the individual filesystem to record the result of the
 operation
 
+->poll_mask can be called with or without the waitqueue lock for the waitqueue
+returned from ->get_poll_head.
+
 --------------------------- dquot_operations -------------------------------
 prototypes:
 	int (*write_dquot) (struct dquot *);
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index f608180ad59d..829a7b7857a4 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -857,6 +857,8 @@ struct file_operations {
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
 	int (*iterate) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
+	struct wait_queue_head * (*get_poll_head)(struct file *, __poll_t);
+	__poll_t (*poll_mask) (struct file *, __poll_t);
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
@@ -901,6 +903,17 @@ otherwise noted.
 	activity on this file and (optionally) go to sleep until there
 	is activity. Called by the select(2) and poll(2) system calls
 
+  get_poll_head: Returns the struct wait_queue_head that callers can
+  wait on.  Callers need to check the returned events using ->poll_mask
+  once woken.  Can return NULL to indicate polling is not supported,
+  or any error code using the ERR_PTR convention to indicate that a
+  grave error occured and ->poll_mask shall not be called.
+
+  poll_mask: return the mask of EPOLL* values describing the file descriptor
+  state.  Called either before going to sleep on the waitqueue returned by
+  get_poll_head, or after it has been woken.  If ->get_poll_head and
+  ->poll_mask are implemented ->poll does not need to be implement.
+
   unlocked_ioctl: called by the ioctl(2) system call.
 
   compat_ioctl: called by the ioctl(2) system call when 32 bit system calls
diff --git a/fs/select.c b/fs/select.c
index e30def680b2e..bc3cc0f98896 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -34,6 +34,29 @@
 
 #include <linux/uaccess.h>
 
+__poll_t vfs_poll(struct file *file, struct poll_table_struct *pt)
+{
+	if (file->f_op->poll) {
+		return file->f_op->poll(file, pt);
+	} else if (file_has_poll_mask(file)) {
+		unsigned int events = poll_requested_events(pt);
+		struct wait_queue_head *head;
+
+		if (pt && pt->_qproc) {
+			head = file->f_op->get_poll_head(file, events);
+			if (!head)
+				return DEFAULT_POLLMASK;
+			if (IS_ERR(head))
+				return EPOLLERR;
+			pt->_qproc(file, head, pt);
+		}
+
+		return file->f_op->poll_mask(file, events);
+	} else {
+		return DEFAULT_POLLMASK;
+	}
+}
+EXPORT_SYMBOL_GPL(vfs_poll);
 
 /*
  * Estimate expected accuracy in ns from a timeval.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7f07977bdfd7..d467bd7b35b7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1711,6 +1711,8 @@ struct file_operations {
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
+	struct wait_queue_head * (*get_poll_head)(struct file *, __poll_t);
+	__poll_t (*poll_mask) (struct file *, __poll_t);
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
diff --git a/include/linux/poll.h b/include/linux/poll.h
index 7e0fdcf905d2..fdf86b4cbc71 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -74,18 +74,18 @@ static inline void init_poll_funcptr(poll_table *pt, poll_queue_proc qproc)
 	pt->_key   = ~(__poll_t)0; /* all events enabled */
 }
 
-static inline bool file_can_poll(struct file *file)
+static inline bool file_has_poll_mask(struct file *file)
 {
-	return file->f_op->poll;
+	return file->f_op->get_poll_head && file->f_op->poll_mask;
 }
 
-static inline __poll_t vfs_poll(struct file *file, struct poll_table_struct *pt)
+static inline bool file_can_poll(struct file *file)
 {
-	if (unlikely(!file->f_op->poll))
-		return DEFAULT_POLLMASK;
-	return file->f_op->poll(file, pt);
+	return file->f_op->poll || file_has_poll_mask(file);
 }
 
+__poll_t vfs_poll(struct file *file, struct poll_table_struct *pt);
+
 struct poll_table_entry {
 	struct file *filp;
 	__poll_t key;
-- 
2.17.0

