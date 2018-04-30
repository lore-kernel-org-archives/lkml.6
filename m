Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1984963-1525122298-2-11109501769984735942
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525122298; b=fTzD6VVd8C/wf1P0lOJ2+AzBsnUbXVN2uzjHTHn5mACCBopgJI
    8m5rNqvzsDuR4SFa/4sGmVtLr2H7nWH7yhg8V7y4sBNc5sSkSj8u6C3mD/osCJAr
    SSkivZL+XIpxXXEGwrWBl6KOGBOuiC2n4KYPh6/qld/D2grtVGSrokpNpbXDJbGi
    hey52CgyqVGuFf3MikVGCYGNWftQkuobp0VMjRVZWAxAh0S8vKxLYeQFy7yNDFPR
    C+8Cf7oPsGw975eIZqap1Jjxi2nelCvJGViESz7/RnFc536nIhFT/U8GZVpO7TA6
    I2C6saR2VKbD/sENXZdPi3yJWRKGtBz53qfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:in-reply-to:references
    :content-type:content-transfer-encoding:sender:list-id; s=fm2;
    t=1525122298; bh=dfZ6CAZM4OjbtKFvtwOo5DVWc4WLcAXnkJM5/3/ftT4=; b=
    V2kFzTojU5YIvNNtxxfpA693c9SaG6p9Zowg+I9FZmOtQxYLLGMK7A0kuSFwyKLC
    28bYGBDX79lufoS9Sj9VTVqR96ji1cWpN/kecd6gGTPr7i/mtemJaBDkkDmIa/5j
    9eRA1g/Ss4lFD4odJOsWMUR/5UVsuE6QYnn0GNAdtcnMx/5Hcw1sis6AJHs77gBd
    OEs2eOdOYgO1h4mTYEBlGYyWBzp5PCnoZ6IOCS+s+6mBiq4sXGun3FfwUoA5mulC
    9LC2p/x1Y2Ed5eghpb2viQwaFmp+EMWdqQ6XqPpx1+KNj60EuQIGD4reMjM4uRsc
    YLOqkPPD86fNi+45Hh+1Qg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=MLMyC7qz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-95 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=MLMyC7qz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-95 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAqEarDrDn/f7Y+ZnkhIBWAJE7QvokPFWdOYHvG4+MQs/yUfv7VPyauUjN00xAiLFMVwCkDPtFebighRV0m5xXIWgnyhH5zU2UP+RIHMiJqlrGw/d6w/
    ccn+UDdGNvARLMymvlCSJlZUo4Y0GzW3TnBTFT/5tQgKxyTEg0ieheaXpmlraEI2OqQoZV2CZkmGhm/OZhvaUisgYl1/yJGDYCR6l6wLYfMYNCXggBusrbpb
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=vkfgAjWNAAAA:8 a=FHifSlABsJDh7vlGtUMA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=s88AYcEWOXMFsoP9cgP2:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754871AbeD3VEM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 17:04:12 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47109 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755162AbeD3VDF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 17:03:05 -0400
X-ME-Sender: <xms:iITnWsj7Gz83rKoENa5aWBvQ1fe3_JqDkP8O0fJIxCvwx5guyNIzyw>
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>, stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/6] xen-blkfront: make local copy of response before using it
Date: Mon, 30 Apr 2018 23:01:49 +0200
Message-Id: <4af6663fbb4b4a97e5c89096033064627367982d.1525122026.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
In-Reply-To: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Data on the shared page can be changed at any time by the backend. Make
a local copy, which is no longer controlled by the backend. And only
then access it.

This is complementary to XSA155.

CC: stable@vger.kernel.org
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/block/xen-blkfront.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 2a8e781..3926811 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1549,7 +1549,7 @@ static bool blkif_completion(unsigned long *id,
 static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 {
 	struct request *req;
-	struct blkif_response *bret;
+	struct blkif_response bret;
 	RING_IDX i, rp;
 	unsigned long flags;
 	struct blkfront_ring_info *rinfo = (struct blkfront_ring_info *)dev_id;
@@ -1566,8 +1566,8 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 	for (i = rinfo->ring.rsp_cons; i != rp; i++) {
 		unsigned long id;
 
-		bret = RING_GET_RESPONSE(&rinfo->ring, i);
-		id   = bret->id;
+		RING_COPY_RESPONSE(&rinfo->ring, i, &bret);
+		id   = bret.id;
 		/*
 		 * The backend has messed up and given us an id that we would
 		 * never have given to it (we stamp it up to BLK_RING_SIZE -
@@ -1575,39 +1575,39 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 		 */
 		if (id >= BLK_RING_SIZE(info)) {
 			WARN(1, "%s: response to %s has incorrect id (%ld)\n",
-			     info->gd->disk_name, op_name(bret->operation), id);
+			     info->gd->disk_name, op_name(bret.operation), id);
 			/* We can't safely get the 'struct request' as
 			 * the id is busted. */
 			continue;
 		}
 		req  = rinfo->shadow[id].request;
 
-		if (bret->operation != BLKIF_OP_DISCARD) {
+		if (bret.operation != BLKIF_OP_DISCARD) {
 			/*
 			 * We may need to wait for an extra response if the
 			 * I/O request is split in 2
 			 */
-			if (!blkif_completion(&id, rinfo, bret))
+			if (!blkif_completion(&id, rinfo, &bret))
 				continue;
 		}
 
 		if (add_id_to_freelist(rinfo, id)) {
 			WARN(1, "%s: response to %s (id %ld) couldn't be recycled!\n",
-			     info->gd->disk_name, op_name(bret->operation), id);
+			     info->gd->disk_name, op_name(bret.operation), id);
 			continue;
 		}
 
-		if (bret->status == BLKIF_RSP_OKAY)
+		if (bret.status == BLKIF_RSP_OKAY)
 			blkif_req(req)->error = BLK_STS_OK;
 		else
 			blkif_req(req)->error = BLK_STS_IOERR;
 
-		switch (bret->operation) {
+		switch (bret.operation) {
 		case BLKIF_OP_DISCARD:
-			if (unlikely(bret->status == BLKIF_RSP_EOPNOTSUPP)) {
+			if (unlikely(bret.status == BLKIF_RSP_EOPNOTSUPP)) {
 				struct request_queue *rq = info->rq;
 				printk(KERN_WARNING "blkfront: %s: %s op failed\n",
-					   info->gd->disk_name, op_name(bret->operation));
+					   info->gd->disk_name, op_name(bret.operation));
 				blkif_req(req)->error = BLK_STS_NOTSUPP;
 				info->feature_discard = 0;
 				info->feature_secdiscard = 0;
@@ -1617,15 +1617,15 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 			break;
 		case BLKIF_OP_FLUSH_DISKCACHE:
 		case BLKIF_OP_WRITE_BARRIER:
-			if (unlikely(bret->status == BLKIF_RSP_EOPNOTSUPP)) {
+			if (unlikely(bret.status == BLKIF_RSP_EOPNOTSUPP)) {
 				printk(KERN_WARNING "blkfront: %s: %s op failed\n",
-				       info->gd->disk_name, op_name(bret->operation));
+				       info->gd->disk_name, op_name(bret.operation));
 				blkif_req(req)->error = BLK_STS_NOTSUPP;
 			}
-			if (unlikely(bret->status == BLKIF_RSP_ERROR &&
+			if (unlikely(bret.status == BLKIF_RSP_ERROR &&
 				     rinfo->shadow[id].req.u.rw.nr_segments == 0)) {
 				printk(KERN_WARNING "blkfront: %s: empty %s op failed\n",
-				       info->gd->disk_name, op_name(bret->operation));
+				       info->gd->disk_name, op_name(bret.operation));
 				blkif_req(req)->error = BLK_STS_NOTSUPP;
 			}
 			if (unlikely(blkif_req(req)->error)) {
@@ -1638,9 +1638,9 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 			/* fall through */
 		case BLKIF_OP_READ:
 		case BLKIF_OP_WRITE:
-			if (unlikely(bret->status != BLKIF_RSP_OKAY))
+			if (unlikely(bret.status != BLKIF_RSP_OKAY))
 				dev_dbg(&info->xbdev->dev, "Bad return from blkdev data "
-					"request: %x\n", bret->status);
+					"request: %x\n", bret.status);
 
 			break;
 		default:
-- 
git-series 0.9.1
