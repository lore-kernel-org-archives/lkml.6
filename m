Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E47ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78482084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78482084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeGREV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:21:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9639 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbeGREV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:21:58 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C409E9ECCBCEA;
        Wed, 18 Jul 2018 11:45:56 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.382.0; Wed, 18 Jul 2018
 11:45:55 +0800
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
From:   piaojun <piaojun@huawei.com>
Subject: [PATCH] net/9p/trans_virtio.c: fix some spell mistakes in comments
Message-ID: <5B4EB7D9.9010108@huawei.com>
Date:   Wed, 18 Jul 2018 11:45:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling mistake in comments of p9_virtio_zc_request().

Signed-off-by: Jun Piao <piaojun@huawei.com>
---
 net/9p/trans_virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index c9f2717..86077f7 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -384,8 +384,8 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
  * p9_virtio_zc_request - issue a zero copy request
  * @client: client instance issuing the request
  * @req: request to be issued
- * @uidata: user bffer that should be ued for zero copy read
- * @uodata: user buffer that shoud be user for zero copy write
+ * @uidata: user buffer that should be used for zero copy read
+ * @uodata: user buffer that should be used for zero copy write
  * @inlen: read buffer size
  * @outlen: write buffer size
  * @in_hdr_len: reader header size, This is the size of response protocol data
-- 
