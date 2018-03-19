Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521483254-2-14025244207184871862
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483253; b=fXP9BGz8x676vfB7ILxFixr+IauJJ4Y1ujkRjUBZ+7hp2Ax
    RGLMSrPGdr+UxqlLe7Z7A0h0v3QRTVNSgRgxZNwmNKy4AZfOoi8gKS/3hrf1k+r7
    feKQtZQp/n8Watf9F3TtYj1qKfdA5L3Rwz8xsXe31hFpJiZl7bJZqm2/pwcWcZpI
    jgz5j859p9/Io7DxNnk9wTotJgN1rrkHBudURWe6vC0/ER5Ny0rhuXnm27Covk7N
    UiKah10lEQmZ5t3BdPiYu5kTJhnDfVNHfzy8kcv+KX6FWUHEBAsJuq2IXhbSz46L
    zDFsCZsKydRnU+cN9Oz0b6Bp0Q5kjG4flATCSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483253; bh=IdSLSPiUU3RCgpuYapAHXw+qYr
    sfwJwMZs6bzc4Ood8=; b=sULokK9mNvAGGyTjciBppVOH5H7i0FGkNQcZq8M5OY
    Uftozv248MBI9LGERQRX6QeqyW2eDIH2Ph80H1htkkJPaVM3XtvAIQigDZoBzF0h
    FMwBsMFltqgec2SenEhWjM+Jadlro6++mTFFV0KpB4LZ0Movhwfk+OymqbMh1gCx
    8UNyBURRq0WzdBJtPv+APh7CYrImHm2tzB40ra2MhB0fUfhlDNss3DR2j36yYb/q
    CkxWW7pA5u0Fu4drI57BMWo6103pt/qyoXXLQHhcl1hCmSQM3l1LR1hP9PYG3DDc
    PgIMpGYHsYXDDMotq3DcVo84JRo7Vb8jdsHMT60De+2A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehtdegheenucevlhhushhtvghrufhiiigvpeduvdej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehtdegheenucevlhhushhtvghrufhiiigvpeduvdej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968711AbeCSSOE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:14:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43978 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030637AbeCSSOC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:14:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 052/134] reiserfs: Make cancel_old_flush() reliable
Date: Mon, 19 Mar 2018 19:05:35 +0100
Message-Id: <20180319171856.867401254@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>


[ Upstream commit 71b0576bdb862e964a82c73327cdd1a249c53e67 ]

Currently canceling of delayed work that flushes old data using
cancel_old_flush() does not prevent work from being requeued. Thus
in theory new work can be queued after cancel_old_flush() from
reiserfs_freeze() has run. This will become larger problem once
flush_old_commits() can requeue the work itself.

Fix the problem by recording in sbi->work_queue that flushing work is
canceled and should not be requeued.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/reiserfs/journal.c  |    2 +-
 fs/reiserfs/reiserfs.h |    1 +
 fs/reiserfs/super.c    |   21 +++++++++++++++------
 3 files changed, 17 insertions(+), 7 deletions(-)

--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -1961,7 +1961,7 @@ static int do_journal_release(struct rei
 	 * will be requeued because superblock is being shutdown and doesn't
 	 * have MS_ACTIVE set.
 	 */
-	cancel_delayed_work_sync(&REISERFS_SB(sb)->old_work);
+	reiserfs_cancel_old_flush(sb);
 	/* wait for all commits to finish */
 	cancel_delayed_work_sync(&SB_JOURNAL(sb)->j_work);
 
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -2948,6 +2948,7 @@ int reiserfs_allocate_list_bitmaps(struc
 				   struct reiserfs_list_bitmap *, unsigned int);
 
 void reiserfs_schedule_old_flush(struct super_block *s);
+void reiserfs_cancel_old_flush(struct super_block *s);
 void add_save_link(struct reiserfs_transaction_handle *th,
 		   struct inode *inode, int truncate);
 int remove_save_link(struct inode *inode, int truncate);
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -90,7 +90,9 @@ static void flush_old_commits(struct wor
 	s = sbi->s_journal->j_work_sb;
 
 	spin_lock(&sbi->old_work_lock);
-	sbi->work_queued = 0;
+	/* Avoid clobbering the cancel state... */
+	if (sbi->work_queued == 1)
+		sbi->work_queued = 0;
 	spin_unlock(&sbi->old_work_lock);
 
 	reiserfs_sync_fs(s, 1);
@@ -117,21 +119,22 @@ void reiserfs_schedule_old_flush(struct
 	spin_unlock(&sbi->old_work_lock);
 }
 
-static void cancel_old_flush(struct super_block *s)
+void reiserfs_cancel_old_flush(struct super_block *s)
 {
 	struct reiserfs_sb_info *sbi = REISERFS_SB(s);
 
-	cancel_delayed_work_sync(&REISERFS_SB(s)->old_work);
 	spin_lock(&sbi->old_work_lock);
-	sbi->work_queued = 0;
+	/* Make sure no new flushes will be queued */
+	sbi->work_queued = 2;
 	spin_unlock(&sbi->old_work_lock);
+	cancel_delayed_work_sync(&REISERFS_SB(s)->old_work);
 }
 
 static int reiserfs_freeze(struct super_block *s)
 {
 	struct reiserfs_transaction_handle th;
 
-	cancel_old_flush(s);
+	reiserfs_cancel_old_flush(s);
 
 	reiserfs_write_lock(s);
 	if (!(s->s_flags & MS_RDONLY)) {
@@ -152,7 +155,13 @@ static int reiserfs_freeze(struct super_
 
 static int reiserfs_unfreeze(struct super_block *s)
 {
+	struct reiserfs_sb_info *sbi = REISERFS_SB(s);
+
 	reiserfs_allow_writes(s);
+	spin_lock(&sbi->old_work_lock);
+	/* Allow old_work to run again */
+	sbi->work_queued = 0;
+	spin_unlock(&sbi->old_work_lock);
 	return 0;
 }
 
@@ -2187,7 +2196,7 @@ error_unlocked:
 	if (sbi->commit_wq)
 		destroy_workqueue(sbi->commit_wq);
 
-	cancel_delayed_work_sync(&REISERFS_SB(s)->old_work);
+	reiserfs_cancel_old_flush(s);
 
 	reiserfs_free_bitmap_cache(s);
 	if (SB_BUFFER_WITH_SB(s))
