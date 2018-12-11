Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97198C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF532081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544336;
	bh=beqLoBDuqLjFqmHwXnIdDGRykzZe/noO3dq15e4U5Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SjC86euWCCu22NKKZcr7bPa2zLu19Crjuplj5HgJG7p2LKwWvyX4xQVeVzUZFAbdx
	 WA7lU7onQXSWoHPyyNxzGTx7cjx/+LsnRVKn4G4bE7a2vVWmMpXhdIZNAYUyGGURsr
	 SEkS2gC4vSq1VJEZDKOEX+lzHgrO2E6fTrZHEEkw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF532081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbeLKPzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:55:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730337AbeLKPzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E9B20855;
        Tue, 11 Dec 2018 15:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543709;
        bh=beqLoBDuqLjFqmHwXnIdDGRykzZe/noO3dq15e4U5Ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMS3rHNo8rw5wn5ABzLvAQkDu9uFv59SJDzWW9BeWmLlE6pIthVypWO2pd2nSLofz
         C5ijZqqz0AxMt4Yd2mrbIi9w9c5qPWDA/8Th2qc//w4sdzYlwsGjWHDMs09v2vOcBL
         mf4dNfLDO2vSnrPsno199z+1iTTgpQ2urfHIAZZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michal Kalderon <michal.kalderon@cavium.com>,
        Denis Bolotin <denis.bolotin@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 032/118] drivers/net/ethernet/qlogic/qed/qed_rdma.h: fix typo
Date:   Tue, 11 Dec 2018 16:40:51 +0100
Message-Id: <20181211151645.537050763@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a97b9565338350d70d8d971c4ee6f0d4fa967418 ]

Add missing semicolon.

Fixes: 291d57f67d244973 ("qed: Fix rdma_info structure allocation")
Cc: Michal Kalderon <michal.kalderon@cavium.com>
Cc: Denis Bolotin <denis.bolotin@cavium.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_rdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.h b/drivers/net/ethernet/qlogic/qed/qed_rdma.h
index 50d609c0e108..3689fe3e5935 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.h
@@ -183,7 +183,7 @@ void qed_rdma_info_free(struct qed_hwfn *p_hwfn);
 static inline void qed_rdma_dpm_conf(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt) {}
 static inline void qed_rdma_dpm_bar(struct qed_hwfn *p_hwfn,
 				    struct qed_ptt *p_ptt) {}
-static inline int qed_rdma_info_alloc(struct qed_hwfn *p_hwfn) {return -EINVAL}
+static inline int qed_rdma_info_alloc(struct qed_hwfn *p_hwfn) {return -EINVAL;}
 static inline void qed_rdma_info_free(struct qed_hwfn *p_hwfn) {}
 #endif
 
-- 
2.19.1



