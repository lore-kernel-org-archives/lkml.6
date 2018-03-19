Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484239-2-13744064486274809083
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
    t=1521484239; b=l4aRJ8/QxJH1gQTyKtIyB+/7rEv1iJe7YDx8P6o+TuJ3qxp
    i1S1gOEkH4z0SjSW5w0zm7im1cW9eFZ5xfFylJ0K6sFga2XHwLE5u8JVaW4qxvnN
    IRv3kOb4u1Gps8+fXYmWlF0saebcs8tI4CRiI7ZKUqpXThYkVLNG6ZsMNReLkrhr
    QkmhLK8AcXUaeEpxc8424xUmJSU1y3rhz9Fdc7LVknpuXiPm6FrEi1rvqgb05Dom
    udWXDBfe664wr9tl4MErAvo9BUQgKzGlARVU5S7sI6/wjVH7FxY0nO4Zdm0gISuS
    AgnT0l9fTh7nuYqMCHVejfQpiOm5qSz24b1oXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484239; bh=SgCzP1h+8Ly5gHkGYzHriEZF4g
    ghFm0gInELuoWMiGU=; b=S4gfD8i0+Bo3Px/pWenR+VZIj5zZM4siSxqs/OhfCz
    y1ms1n5cNVHJ+BVFhkbBTUtR+vFkl6DE1kAuC6EKriOiRp447JbWaaeOUxgHsq6o
    SfkFCwVzdu48LKQndpePCAdvHTHv8/vhmSYqJmSULHDX2XIxFJmTy3tMsNccPpPS
    WwB/Pp2ikilKA3z/ktXvvxhe68ysQmThGmESjUxj221CyJi+690x4NpQsOelivfs
    Oz6f0/hrkzT2AB8cOhHc0ErtURT+rWIahFQXAszHXaJNU2wOeaOMPAFdBNO7fge5
    4M0OgIObKRDuRE+tQrY/VJksh1+GD+565WJP/jj64P/g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefuddtleenucevlhhushhtvghrufhiiigvpeejfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefuddtleenucevlhhushhtvghrufhiiigvpeejfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970164AbeCSSad (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:30:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031949AbeCSSaa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:30:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 37/41] scsi: qla2xxx: Fix NULL pointer access for fcport structure
Date: Mon, 19 Mar 2018 19:08:37 +0100
Message-Id: <20180319180734.620851158@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
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

From: Quinn Tran <quinn.tran@cavium.com>

commit 5c25d451163cab9be80744cbc5448d6b95ab8d1a upstream.

when processing iocb in a timeout case, driver was trying to log messages
without verifying if the fcport structure could have valid data. This
results in a NULL pointer access.

Fixes: 726b85487067("qla2xxx: Add framework for async fabric discovery")
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -102,11 +102,16 @@ qla2x00_async_iocb_timeout(void *data)
 	struct srb_iocb *lio = &sp->u.iocb_cmd;
 	struct event_arg ea;
 
-	ql_dbg(ql_dbg_disc, fcport->vha, 0x2071,
-	    "Async-%s timeout - hdl=%x portid=%06x %8phC.\n",
-	    sp->name, sp->handle, fcport->d_id.b24, fcport->port_name);
+	if (fcport) {
+		ql_dbg(ql_dbg_disc, fcport->vha, 0x2071,
+		    "Async-%s timeout - hdl=%x portid=%06x %8phC.\n",
+		    sp->name, sp->handle, fcport->d_id.b24, fcport->port_name);
 
-	fcport->flags &= ~FCF_ASYNC_SENT;
+		fcport->flags &= ~FCF_ASYNC_SENT;
+	} else {
+		pr_info("Async-%s timeout - hdl=%x.\n",
+		    sp->name, sp->handle);
+	}
 
 	switch (sp->type) {
 	case SRB_LOGIN_CMD:
