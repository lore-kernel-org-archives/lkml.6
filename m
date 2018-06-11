Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zqm0NbR8HlsxUQAAmS7hNA
	; Mon, 11 Jun 2018 14:16:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 06FF0607A4; Mon, 11 Jun 2018 14:16:39 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XkMgaY6A"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8F2C860351;
	Mon, 11 Jun 2018 14:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F2C860351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933557AbeFKOG7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:06:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933486AbeFKOGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dGkzfC0RM7gc5d0orX2hU4DPQ3QLXn+i7TNcZAss9dw=; b=XkMgaY6AkOoFJHfIkcQxrYlMO
        dlWV9Rg5erA1rsPqNft1xX8dPajTtdB+gjPNxrcuCqHlIYzXwFLIQGMdBuReV63+atIWOt6yBlShi
        tgEPlcuW7gt3Yh2n6/QeJauiX1o5746sAc8My6YKcdHy7+m1rq0bNlg8+XLFpN+1nj1/Aj4zpuInK
        2+EWJE5mb4nqNshK/sIAIAVorQzWsEM/c5CzNE/HIYo9FL90KABaL9ApCD7opp0YuRy8vTgiUL+v/
        g8I3Be4GM3RfGfqbmuZT7JlbSh/yX4PDebgn7wHQMhRjJ/T0AB9FHFc3ZckzlTywspmfvxZXNNv0j
        CcuJvsE+Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNT4-0004dU-Py; Mon, 11 Jun 2018 14:06:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v13 18/72] xarray: Add MAINTAINERS entry
Date: Mon, 11 Jun 2018 07:05:45 -0700
Message-Id: <20180611140639.17215-19-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Add myself as XArray and IDR maintainer.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14fbc6e94774..afb6678188b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15598,6 +15598,18 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vdso
 S:	Maintained
 F:	arch/x86/entry/vdso/
 
+XARRAY
+M:	Matthew Wilcox <mawilcox@microsoft.com>
+M:	Matthew Wilcox <willy@infradead.org>
+L:	linux-fsdevel@vger.kernel.org
+S:	Supported
+F:	Documentation/core-api/xarray.rst
+F:	lib/idr.c
+F:	lib/xarray.c
+F:	include/linux/idr.h
+F:	include/linux/xarray.h
+F:	tools/testing/radix-tree
+
 XC2028/3028 TUNER DRIVER
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-media@vger.kernel.org
-- 
2.17.1
