Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9789DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D8D20828
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbeL3QaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 11:30:02 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52561
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbeL3QaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 11:30:01 -0500
X-IronPort-AV: E=Sophos;i="5.56,417,1539640800"; 
   d="scan'208";a="290435980"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 30 Dec 2018 17:29:57 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] i40e: increase indentation
Date:   Sun, 30 Dec 2018 16:53:10 +0100
Message-Id: <1546185195-25676-4-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert spaces to tabs to get correct alignment.

Found with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/net/ethernet/intel/i40e/i40e_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4d40878e395a..6c435b61941f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3610,7 +3610,7 @@ static void i40e_configure_msi_and_legacy(struct i40e_vsi *vsi)
 		      (I40E_QUEUE_TYPE_TX
 		       << I40E_QINT_TQCTL_NEXTQ_TYPE_SHIFT);
 
-	       wr32(hw, I40E_QINT_TQCTL(nextqp), val);
+		wr32(hw, I40E_QINT_TQCTL(nextqp), val);
 	}
 
 	val = I40E_QINT_TQCTL_CAUSE_ENA_MASK		      |

