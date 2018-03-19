Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484369-2-417087219164067939
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
    t=1521484369; b=Tt7Hn+FAljp9tZYXZ3VQlkJ+NC4VFOwIypCYgiHprWu+tfe
    CQ8TbXsFVUOGzPUyb2C1jNDby3cRHm/lwdoR51DCiwXKpd77gJCdllGd+jfIsuBF
    ULJ4fJwCD5ku21kQlBa6E+fpG2NjB7q8A4ibvqXRo6k4jnW//2B7zuv3xdoEn853
    mLTeQCgwPJnAR5ihGWJf81drPgysMzwAH0yjjBRCe27Jf3010tVt9BKT5UEHilwq
    ttnj2gMYE77hHr2Cmvi19E9o6no0R/1jI3Eo5Fcv8m9wb2UofhyY4Tud2/4YwCPT
    1+grmT76LzD6/de+yBQnEoihcW0D0pxWtLhxb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484369; bh=9bGtU55IyayehqUU96e3L1wB7s
    ncz5I8KwwWPqiQrOw=; b=MXQStFbadrEwWC4vVIohfMT+mJ+P7NYsKagmwqPHpd
    2Ogx/yBLgJyQpJXcIHFgzEWmRr3pnSo5kPl5QoK4i1AN0QBT3rbPX1inGX9mOigV
    /9XPQ0Ys8gPT6Uy87RhPB3i6iOPRHGCQYXvIsCQIJnSJzetwi4JVdUtzZMR9GKek
    9k7uMp7sR+YFtCoOwIumfx39PKHiARavs+ocgZ1LxTiJMIlnKyi7m0rgeqP6mvqO
    OCV2HgVmKoRs5hwBxMY1MoyGN6pLRo59r3MP8i9pnI2kAj20QvUAqjBHxyUrKcvp
    hjlZ3dWkcovSZsoGLv2qlodbFMPnJCuyOFxw3qXwgUkA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeiudekvdenucevlhhushhtvghrufhiiigvpeefje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeiudekvdenucevlhhushhtvghrufhiiigvpeefje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970312AbeCSSch (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:32:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54012 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934606AbeCSScf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:32:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bill Kuzeja <william.kuzeja@stratus.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 41/52] scsi: qla2xxx: Fix crashes in qla2x00_probe_one on probe failure
Date: Mon, 19 Mar 2018 19:08:39 +0100
Message-Id: <20180319180737.287104302@linuxfoundation.org>
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

From: Bill Kuzeja <William.Kuzeja@stratus.com>

commit 6a2cf8d3663e13e19af636c2a8d92e766261dc45 upstream.

Because of the shifting around of code in qla2x00_probe_one recently,
failures during adapter initialization can lead to problems, i.e. NULL
pointer crashes and doubly freed data structures which cause eventual
panics.

This V2 version makes the relevant memory free routines idempotent, so
repeat calls won't cause any harm. I also removed the problematic
probe_init_failed exit point as it is not needed.

Fixes: d64d6c5671db ("scsi: qla2xxx: Fix NULL pointer crash due to probe failure")
Signed-off-by: Bill Kuzeja <william.kuzeja@stratus.com>
Acked-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_os.c |   59 ++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 22 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -449,7 +449,7 @@ static int qla2x00_alloc_queues(struct q
 	ha->req_q_map[0] = req;
 	set_bit(0, ha->rsp_qid_map);
 	set_bit(0, ha->req_qid_map);
-	return 1;
+	return 0;
 
 fail_qpair_map:
 	kfree(ha->base_qpair);
@@ -466,6 +466,9 @@ fail_req_map:
 
 static void qla2x00_free_req_que(struct qla_hw_data *ha, struct req_que *req)
 {
+	if (!ha->req_q_map)
+		return;
+
 	if (IS_QLAFX00(ha)) {
 		if (req && req->ring_fx00)
 			dma_free_coherent(&ha->pdev->dev,
@@ -476,14 +479,17 @@ static void qla2x00_free_req_que(struct
 		(req->length + 1) * sizeof(request_t),
 		req->ring, req->dma);
 
-	if (req)
+	if (req) {
 		kfree(req->outstanding_cmds);
-
-	kfree(req);
+		kfree(req);
+	}
 }
 
 static void qla2x00_free_rsp_que(struct qla_hw_data *ha, struct rsp_que *rsp)
 {
+	if (!ha->rsp_q_map)
+		return;
+
 	if (IS_QLAFX00(ha)) {
 		if (rsp && rsp->ring)
 			dma_free_coherent(&ha->pdev->dev,
@@ -494,7 +500,8 @@ static void qla2x00_free_rsp_que(struct
 		(rsp->length + 1) * sizeof(response_t),
 		rsp->ring, rsp->dma);
 	}
-	kfree(rsp);
+	if (rsp)
+		kfree(rsp);
 }
 
 static void qla2x00_free_queues(struct qla_hw_data *ha)
@@ -1717,6 +1724,8 @@ qla2x00_abort_all_cmds(scsi_qla_host_t *
 	struct qla_tgt_cmd *cmd;
 	uint8_t trace = 0;
 
+	if (!ha->req_q_map)
+		return;
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 	for (que = 0; que < ha->max_req_queues; que++) {
 		req = ha->req_q_map[que];
@@ -3071,14 +3080,14 @@ qla2x00_probe_one(struct pci_dev *pdev,
 	/* Set up the irqs */
 	ret = qla2x00_request_irqs(ha, rsp);
 	if (ret)
-		goto probe_hw_failed;
+		goto probe_failed;
 
 	/* Alloc arrays of request and response ring ptrs */
-	if (!qla2x00_alloc_queues(ha, req, rsp)) {
+	if (qla2x00_alloc_queues(ha, req, rsp)) {
 		ql_log(ql_log_fatal, base_vha, 0x003d,
 		    "Failed to allocate memory for queue pointers..."
 		    "aborting.\n");
-		goto probe_init_failed;
+		goto probe_failed;
 	}
 
 	if (ha->mqenable && shost_use_blk_mq(host)) {
@@ -3363,15 +3372,6 @@ skip_dpc:
 
 	return 0;
 
-probe_init_failed:
-	qla2x00_free_req_que(ha, req);
-	ha->req_q_map[0] = NULL;
-	clear_bit(0, ha->req_qid_map);
-	qla2x00_free_rsp_que(ha, rsp);
-	ha->rsp_q_map[0] = NULL;
-	clear_bit(0, ha->rsp_qid_map);
-	ha->max_req_queues = ha->max_rsp_queues = 0;
-
 probe_failed:
 	if (base_vha->timer_active)
 		qla2x00_stop_timer(base_vha);
@@ -4451,11 +4451,17 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 	if (ha->init_cb)
 		dma_free_coherent(&ha->pdev->dev, ha->init_cb_size,
 			ha->init_cb, ha->init_cb_dma);
-	vfree(ha->optrom_buffer);
-	kfree(ha->nvram);
-	kfree(ha->npiv_info);
-	kfree(ha->swl);
-	kfree(ha->loop_id_map);
+
+	if (ha->optrom_buffer)
+		vfree(ha->optrom_buffer);
+	if (ha->nvram)
+		kfree(ha->nvram);
+	if (ha->npiv_info)
+		kfree(ha->npiv_info);
+	if (ha->swl)
+		kfree(ha->swl);
+	if (ha->loop_id_map)
+		kfree(ha->loop_id_map);
 
 	ha->srb_mempool = NULL;
 	ha->ctx_mempool = NULL;
@@ -4471,6 +4477,15 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 	ha->ex_init_cb_dma = 0;
 	ha->async_pd = NULL;
 	ha->async_pd_dma = 0;
+	ha->loop_id_map = NULL;
+	ha->npiv_info = NULL;
+	ha->optrom_buffer = NULL;
+	ha->swl = NULL;
+	ha->nvram = NULL;
+	ha->mctp_dump = NULL;
+	ha->dcbx_tlv = NULL;
+	ha->xgmac_data = NULL;
+	ha->sfp_data = NULL;
 
 	ha->s_dma_pool = NULL;
 	ha->dl_dma_pool = NULL;
