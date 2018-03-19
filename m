Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521485040-2-16763271939005079087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521485040; b=dxKHJ8j2xZImfkozbr1lUfWs6ADMgeFZMfa3TKzJ4ue2ZRs
    ul/B5LZYtwVstiLdmdyMRkzRB11xXf2VEFK65gAOCoJHv/9iV+Ym7v4UvQLEhvVk
    YQ3rT1IxPijtD1Jzx/jUwNgbPUGXo7CRNUVQuKdhNSIYMkIMKzLJ2gQsQnB9PuFv
    C52O1CTd3g9BddJXdw+Z8A5gqBOPcOBt0Mnow6Jb9VjFN9GTIDuYu3721BaIDMbk
    zjfD9KnnxWQ3Z32rUVPlnGu9//nVdhZhOB4zk1Hh4bxwjwgE3PF2unXMouBqWJyQ
    uosdU7eOUQaUh2pqzwmGr8N8o1tHMVwN4MsNrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521485040; bh=AP8L7oFnbxrKXh/PRnDbrJjPjL
    lv1FmPR1fIrjvuEWo=; b=lXHsewQ8yKrsP9mgW4A01IZa8GFDIeR8Ih7dJStBhi
    FxISai4sHgS9xKEVci4X7NQ8YmUGh4wPh4Ut6IyBhp6CURK1/V2nAkrOx4BwCBHk
    91zg785aTcrXkza9Cz2aemh7iAxyoNYzy+kiB++0nTBFRBP0dGSxN5dcpaeGhbeZ
    EWTIN83tnslBQ+liOHEnTyJgTMZnCfW0+4bCqd/0FVmOvK8uSeAOoTCetcpdhUK2
    IBckyZs1YwuaLPEeGQqLUO4OQERED/vRkr+JAAH2EcsgG7VFY5k3IStj8BDk48Jq
    cAcSzzU2W7SMJ9vqqdnr95B1NRox/3KLtaAuTWotTfEg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeftdejleenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeftdejleenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968185AbeCSSno (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:43:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53960 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970292AbeCSSc1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:32:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 38/52] scsi: qla2xxx: Fix smatch warning in qla25xx_delete_{rsp|req}_que
Date: Mon, 19 Mar 2018 19:08:36 +0100
Message-Id: <20180319180737.131838465@linuxfoundation.org>
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

From: Himanshu Madhani <himanshu.madhani@cavium.com>

commit 62aa281470fdb7c0796d63a1cc918a8c1f02dde2 upstream.

This patch fixes following warnings reported by smatch:

drivers/scsi/qla2xxx/qla_mid.c:586 qla25xx_delete_req_que()
error: we previously assumed 'req' could be null (see line 580)

drivers/scsi/qla2xxx/qla_mid.c:602 qla25xx_delete_rsp_que()
error: we previously assumed 'rsp' could be null (see line 596)

Fixes: 7867b98dceb7 ("scsi: qla2xxx: Fix memory leak in dual/target mode")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_mid.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -582,8 +582,9 @@ qla25xx_delete_req_que(struct scsi_qla_h
 		ret = qla25xx_init_req_que(vha, req);
 		if (ret != QLA_SUCCESS)
 			return QLA_FUNCTION_FAILED;
+
+		qla25xx_free_req_que(vha, req);
 	}
-	qla25xx_free_req_que(vha, req);
 
 	return ret;
 }
@@ -598,8 +599,9 @@ qla25xx_delete_rsp_que(struct scsi_qla_h
 		ret = qla25xx_init_rsp_que(vha, rsp);
 		if (ret != QLA_SUCCESS)
 			return QLA_FUNCTION_FAILED;
+
+		qla25xx_free_rsp_que(vha, rsp);
 	}
-	qla25xx_free_rsp_que(vha, rsp);
 
 	return ret;
 }
