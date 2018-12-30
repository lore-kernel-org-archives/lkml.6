Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAD2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BF720828
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeL3QaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 11:30:04 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52542
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbeL3QaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 11:30:00 -0500
X-IronPort-AV: E=Sophos;i="5.56,417,1539640800"; 
   d="scan'208";a="290435979"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 30 Dec 2018 17:29:57 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Netanel Belgazal <netanel@amazon.com>
Cc:     kernel-janitors@vger.kernel.org, Saeed Bishara <saeedb@amazon.com>,
        Zorik Machulsky <zorik@amazon.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] net: ena: reduce indentation
Date:   Sun, 30 Dec 2018 16:53:09 +0100
Message-Id: <1546185195-25676-3-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete tab aligning a statement with the right hand side of a
preceding assignment rather than the left hand side.

Found with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/net/ethernet/amazon/ena/ena_eth_com.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.c b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
index f6c2d3855be8..f7b4e359a2ff 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
@@ -200,8 +200,8 @@ static inline int ena_com_sq_update_llq_tail(struct ena_com_io_sq *io_sq)
 
 		pkt_ctrl->curr_bounce_buf =
 			ena_com_get_next_bounce_buffer(&io_sq->bounce_buf_ctrl);
-			memset(io_sq->llq_buf_ctrl.curr_bounce_buf,
-			       0x0, llq_info->desc_list_entry_size);
+		memset(io_sq->llq_buf_ctrl.curr_bounce_buf,
+		       0x0, llq_info->desc_list_entry_size);
 
 		pkt_ctrl->idx = 0;
 		if (unlikely(llq_info->desc_stride_ctrl == ENA_ADMIN_SINGLE_DESC_PER_ENTRY))

