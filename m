Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484994-2-3408625412943891626
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484993; b=d164WQZhCiJ59g3dhNiW4XKZ8QHZlZNAM+e9jDUh8YZy6jI
    neKbctlTbuIpB2qpeIeAyBk7AW+yIpAdXTjF7lbSpCQX42veLHoeH9s8iaz+N3O4
    UwbcqaEWi8UACOMOjZX4XtN/4XB6xAe2/Lb3rA/xhv+dv5gH8fzL1P3WeLFR/etx
    dgk/g1Pgq10qg3BEP6xhqKcKfBBC9hvO1rIBj8ueg/o8W/8CvbcNSmPZT+lHdqru
    Olhd0zQFZJfj9pZ8rj9ySwizp8MejGGKTeZ2KqdU0jUnm3iSY0PMY/AKMADzOkIM
    YRlTmhhBXszGMScpocViTDjWIFk0w5XZQJrSc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484993; bh=tR4LQnCLbDIFRPnywdUOvgAGQT
    biSb/wlfMWL+ORAdo=; b=s7IirvyCjJKIpeCNr3+sN0fd6CBpe24zcvw69VuZFx
    XKeeW2+HM0JJb1pF0hU1Kh1nlzW/s0RUsLo8J0SlIQvXoqakO09i4DTl1Z2Cf6P6
    smvpT/ZuvfvOMSwHHIwKwpAk+Da/u0D/LRoMd0XRBtqdxvNu6C2bWXkdYL0nLUX3
    D3ciS+u9qNw5pMwMxjvrbaqAbVN2EnlvRTe86hTeqtYbP9oJszLF2uPo7XpUzMNG
    qakb7rtxQkix/MMY1Gi+LAsX7hTGptYsU3I7RQU28WZwS4fJoJIFpOkuDhIjagM4
    j4JfabfljF/ZxYmf9BXSiLonv6LxqaNU/49C1JYlmChw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefuddtkeenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefuddtkeenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967496AbeCSSnL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:43:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970298AbeCSSca (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:32:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 39/52] scsi: qla2xxx: Fix NULL pointer access for fcport structure
Date: Mon, 19 Mar 2018 19:08:37 +0100
Message-Id: <20180319180737.179326405@linuxfoundation.org>
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
