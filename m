Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484397-2-17201595065481780345
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484396; b=nQPz4sYAxoxHC5iXEpe3mpbQRjSZ0nAqlS53SrjDIAEEX3A
    4YiOyPsMLcSLwjZ/men2doMOiH8cPArW0E6iH8MwhuZSCbo3Q78tEL3cb50N+NA1
    3aXGCE+qmWxf4mUf/ArEAzOezRRRWjtFSr/KGYj5eyUUO9z50Sk+wJVqfXYn9tIz
    knoE35t+t1FpnU45Tbe9dm6/4kX9aEwMhCPjX0/WLuv6ndTtl4dA5WX/85Mqw7CL
    R+Xy/0eOVA2zT+WFtQmX8U/WL4NyKRnLPb9ZFZqdin5So2t98ZnGvkA9ooFShxMI
    XwwzIST3xSqJYCNMxp02c6ykdD/lXO5y1DZ3Ufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484396; bh=QJ6VYFte9k0kNSXbR7ub+uhRD+
    /r/4p54RqKUImka5s=; b=umTw3qsikJS1J8B+cHSxCGkY8gMXSzVivhg62Vu8DG
    hrtfJu8gAQvzFbcXUOV+KyxOG/i40yMX7+NdUJBZwx8s2XzV8Vo28NuweNV4w1Qs
    YDct3v9bMKEjGSWK/s8fJ2dUnYZRxeV8c0BMi3iw8GRi7snb52gqAdNnF26yv0mG
    h6AitqS4y06lq+1mRzpHF6AA2cPz5mN8eTwRDJ9lSV7cKHQePWPfNQpH/tg/Lz1K
    INlzYra4lQzBo4/Dvj9wAOo4uJL48o+wOKUbSJOpNkjBVqN8MgUjqH9iW5AvLmWj
    cwdhBZqxi+1/Nx+ksgTMojA7ZVrylao3cT/ckIHpPJzg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefjeeigeenucevlhhushhtvghrufhiiigvpeefie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefjeeigeenucevlhhushhtvghrufhiiigvpeefie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031898AbeCSSdM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:33:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54172 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032179AbeCSSdK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:33:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        linux-rdma@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 28/52] RDMAVT: Fix synchronization around percpu_ref
Date: Mon, 19 Mar 2018 19:08:26 +0100
Message-Id: <20180319180736.648327623@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit 74b44bbe80b4c62113ac1501482ea1ee40eb9d67 upstream.

rvt_mregion uses percpu_ref for reference counting and RCU to protect
accesses from lkey_table.  When a rvt_mregion needs to be freed, it
first gets unregistered from lkey_table and then rvt_check_refs() is
called to wait for in-flight usages before the rvt_mregion is freed.

rvt_check_refs() seems to have a couple issues.

* It has a fast exit path which tests percpu_ref_is_zero().  However,
  a percpu_ref reading zero doesn't mean that the object can be
  released.  In fact, the ->release() callback might not even have
  started executing yet.  Proceeding with freeing can lead to
  use-after-free.

* lkey_table is RCU protected but there is no RCU grace period in the
  free path.  percpu_ref uses RCU internally but it's sched-RCU whose
  grace periods are different from regular RCU.  Also, it generally
  isn't a good idea to depend on internal behaviors like this.

To address the above issues, this patch removes the fast exit and adds
an explicit synchronize_rcu().

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: linux-rdma@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/rdmavt/mr.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -489,11 +489,13 @@ static int rvt_check_refs(struct rvt_mre
 	unsigned long timeout;
 	struct rvt_dev_info *rdi = ib_to_rvt(mr->pd->device);
 
-	if (percpu_ref_is_zero(&mr->refcount))
-		return 0;
-	/* avoid dma mr */
-	if (mr->lkey)
+	if (mr->lkey) {
+		/* avoid dma mr */
 		rvt_dereg_clean_qps(mr);
+		/* @mr was indexed on rcu protected @lkey_table */
+		synchronize_rcu();
+	}
+
 	timeout = wait_for_completion_timeout(&mr->comp, 5 * HZ);
 	if (!timeout) {
 		rvt_pr_err(rdi,
