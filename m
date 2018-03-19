Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484096-2-5784584594389481003
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
    t=1521484096; b=MS0F5V97PxzuypzycfsQUTvHPMUN5F3ipOfQ7IF/Dt/Tf8T
    3Og4OU1jsxEit2B2FM6fBwLFKc9WaUmrAYPF/4gO5DnwINQ2POHQVwX4mwBVa/sN
    Q+DXHr6Ygtxd3ZXGynz/VKp3v7d+qty+iGm7dsANvi7UsURw5RNmh58TOY1jIIWF
    5CMm5f3CNuFZKizHgiLt3tYLcgMP2qrxI4Yu6K8t3BDmMUehJqT73QTcKHNCMUk6
    Iw68YssWeGDhFc/S1EmDwSwcaRGLWSa8LNdypDZG+Guihmtvy1O2Dq10ggbr+vSU
    O0DJJhzOIdbgeymbc4XQIxwAp2/kasBVAM4h6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484096; bh=3PBwZxUWfXZB+lcNJQn1OddHiO
    PSO8breKmQo+NxhzQ=; b=Lp2JkxacldYAm6+CxSVLb0V/qS/FHMxivIUQ7MduGm
    jCXA5df+mapi7h6MnBNuHpaSPZyFpqHKSMAx8evbsNrX9K3NNQQ2cDh6vVSsOyPz
    1clG0At28bUNsClxfJAWPOCL7G0aEpULRTQVvKTrP4VLRuySXD1tvI9Yzzh7KJZZ
    l3toeAAIrNHFBcd2UhzeUB3+R6csBgC1KnVBM9BRVeC/CRs4dQeMDVMwYGkva4rl
    ihtcbzfKZBCJWarJ/xiLAaaiAkG/OMmLxa4V2pWy/3P3rknF89T/ABovZZ/hBcCv
    bnkZIWlv7wEw12hFa/y5qdlcxT9SRJAHCuz/cSiSX8ow==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvleegtdenucevlhhushhtvghrufhiiigvpeehge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvleegtdenucevlhhushhtvghrufhiiigvpeehge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970106AbeCSS2N (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:28:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51536 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970098AbeCSS2L (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:28:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 229/241] lock_parent() needs to recheck if dentry got __dentry_killed under it
Date: Mon, 19 Mar 2018 19:08:14 +0100
Message-Id: <20180319180800.652668687@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 3b821409632ab778d46e807516b457dfa72736ed upstream.

In case when dentry passed to lock_parent() is protected from freeing only
by the fact that it's on a shrink list and trylock of parent fails, we
could get hit by __dentry_kill() (and subsequent dentry_kill(parent))
between unlocking dentry and locking presumed parent.  We need to recheck
that dentry is alive once we lock both it and parent *and* postpone
rcu_read_unlock() until after that point.  Otherwise we could return
a pointer to struct dentry that already is rcu-scheduled for freeing, with
->d_lock held on it; caller's subsequent attempt to unlock it can end
up with memory corruption.

Cc: stable@vger.kernel.org # 3.12+, counting backports
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dcache.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -637,11 +637,16 @@ again:
 		spin_unlock(&parent->d_lock);
 		goto again;
 	}
-	rcu_read_unlock();
-	if (parent != dentry)
+	if (parent != dentry) {
 		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-	else
+		if (unlikely(dentry->d_lockref.count < 0)) {
+			spin_unlock(&parent->d_lock);
+			parent = NULL;
+		}
+	} else {
 		parent = NULL;
+	}
+	rcu_read_unlock();
 	return parent;
 }
 
