Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521483390-2-2593275811444384959
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
    t=1521483389; b=laVvBAedrEsUXVA27g1Ulx0TMgcBO6P3jVzfxuLbCpHj+aV
    zUutnW5SBLk6dtEGnhmGWLgO+97POk4SXoy7Gxa+BuUHgMxhL8e0H9StPpuZtT2K
    2nHw3S+hZ1MxRZju3rSRa9cU2uT7KgUbK05u5jGnxuBi//0Yxxqyso9OynWVyvIN
    5acsu+GJ0rgbRNsVUaKkRSJsO2pd/PwQnjQZ9a0V60yA1KS+QypbJsd0IbVrdVoX
    VrZaMndX0J6ql8jSXe3CDUTwySy1j/Yxaz4hxCDPYW0rIOPjxPIy7HyHuPWI1Mpi
    UTkWrtsx/aIxxlm0GyQC2LYIFANTGkXeIV0Ns2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483389; bh=iqNy3hbY0JT6cf6Y3ZWl9GG5kf
    DHegGjKtiWF5bajcw=; b=VL1TEu9Iuxw3D/m80TTlAcQhd1kZXj1c0XPtUFQhKQ
    +x0hiJpQbJokIcD6P2zfUT7onBmi79sa1P3KjTdsXXrTN1yTT81wH4jCeoW2n1jg
    1NhnGSEXGC1cr+LsPDdObIP2t7j1AV5PG+eL/8hVLk5jSsgV4X1k876qoSaZl5ij
    X4zcU0SYaPQgIyoYZZkuROitfAXDI5R5GJlBuOmJYgzg1Dy0C53u8bLoMM8Mly0R
    Ez+T5D2M9MHW1eMrM8rsU5mjH8eeYp6mupe/ER4a4X7wfGGislSAEe+Ab0Xh3TsH
    qBY/3oB7eDXsyXBlWyz0yYIYf7OrqDV6/Q3pEAg4x/Zg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeggedutdenucevlhhushhtvghrufhiiigvpeeige;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeggedutdenucevlhhushhtvghrufhiiigvpeeige;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030617AbeCSSQ0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:16:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45066 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968750AbeCSSQR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:16:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 074/134] scsi: sg: close race condition in sg_remove_sfp_usercontext()
Date: Mon, 19 Mar 2018 19:05:57 +0100
Message-Id: <20180319171859.944040060@linuxfoundation.org>
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

From: Hannes Reinecke <hare@suse.de>


[ Upstream commit 97d27b0dd015e980ade63fda111fd1353276e28b ]

sg_remove_sfp_usercontext() is clearing any sg requests, but needs to
take 'rq_list_lock' when modifying the list.

Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sg.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -535,6 +535,7 @@ sg_read(struct file *filp, char __user *
 	} else
 		count = (old_hdr->result == 0) ? 0 : -EIO;
 	sg_finish_rem_req(srp);
+	sg_remove_request(sfp, srp);
 	retval = count;
 free_old_hdr:
 	kfree(old_hdr);
@@ -575,6 +576,7 @@ sg_new_read(Sg_fd * sfp, char __user *bu
 	}
 err_out:
 	err2 = sg_finish_rem_req(srp);
+	sg_remove_request(sfp, srp);
 	return err ? : err2 ? : count;
 }
 
@@ -811,6 +813,7 @@ sg_common_write(Sg_fd * sfp, Sg_request
 		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
 			"sg_common_write: start_req err=%d\n", k));
 		sg_finish_rem_req(srp);
+		sg_remove_request(sfp, srp);
 		return k;	/* probably out of space --> ENOMEM */
 	}
 	if (atomic_read(&sdp->detaching)) {
@@ -823,6 +826,7 @@ sg_common_write(Sg_fd * sfp, Sg_request
 		}
 
 		sg_finish_rem_req(srp);
+		sg_remove_request(sfp, srp);
 		return -ENODEV;
 	}
 
@@ -1312,6 +1316,7 @@ sg_rq_end_io_usercontext(struct work_str
 	struct sg_fd *sfp = srp->parentfp;
 
 	sg_finish_rem_req(srp);
+	sg_remove_request(sfp, srp);
 	kref_put(&sfp->f_ref, sg_remove_sfp);
 }
 
@@ -1856,8 +1861,6 @@ sg_finish_rem_req(Sg_request *srp)
 	else
 		sg_remove_scat(sfp, req_schp);
 
-	sg_remove_request(sfp, srp);
-
 	return ret;
 }
 
@@ -2204,12 +2207,17 @@ sg_remove_sfp_usercontext(struct work_st
 	struct sg_fd *sfp = container_of(work, struct sg_fd, ew.work);
 	struct sg_device *sdp = sfp->parentdp;
 	Sg_request *srp;
+	unsigned long iflags;
 
 	/* Cleanup any responses which were never read(). */
+	write_lock_irqsave(&sfp->rq_list_lock, iflags);
 	while (!list_empty(&sfp->rq_list)) {
 		srp = list_first_entry(&sfp->rq_list, Sg_request, entry);
 		sg_finish_rem_req(srp);
+		list_del(&srp->entry);
+		srp->parentfp = NULL;
 	}
+	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 
 	if (sfp->reserve.bufflen > 0) {
 		SCSI_LOG_TIMEOUT(6, sg_printk(KERN_INFO, sdp,
