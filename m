Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC0BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B8B21537
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fDbPiPxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B8B21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389867AbeHGS7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:59:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50056 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeHGS7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pczK/DLGLW3M05d/bCG2c9SVft/aE1G1w2ohDy0rCgc=; b=fDbPiPxOrrqJJaX0U/tIsR92lT
        N5BDxOApQGEk5n5s0hr3HazXjTJtP10F5v889uvDt/B+qqWK6vsTT4/bPDlvyPiB9B+IQ6L1XZdKf
        yepndo75pphsHACUdAQrPLqjJjZDDiSub3fC6COoByHTLC4SueQSgg8qatiIMPx84HMdkUGTgMgaV
        2PIL6HxnwE620P0EC5f1eqKeD3U10zYaPBFBDFNJ63YXVS4WZg2OaWR/xRibBjeZIWkWr1CbaMyi3
        qdYr3B2TZL1l1WZj6hojFusMs7VaU7wxRmvsLDTxYvtuWjuN6mDMMRXHaJpyYITIiPGacB8WThzYP
        hbX9vpYQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fn55L-0001KA-Kt; Tue, 07 Aug 2018 16:43:51 +0000
Subject: Re: [PATCH] mailbox: add MODULE_LICENSE() for mtk-cmdq-mailbox.c
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org
Cc:     Jassi Brar <jassisinghbrar@gmail.com>, CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
References: <99f4666b-95fc-a1dd-04d3-3d1d803990fb@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b15a42e2-566f-ee7b-8dee-dc56d979c258@infradead.org>
Date:   Tue, 7 Aug 2018 09:43:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <99f4666b-95fc-a1dd-04d3-3d1d803990fb@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This applies to linux-next...

On 08/07/2018 09:42 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix missing MODULE_LICENSE() in mtk-cmdq-mailbox.c:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/mailbox/mtk-cmdq-mailbox.o
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: <linux-mediatek@lists.infradead.org>
> Cc: CK Hu <ck.hu@mediatek.com>
> Cc: Houlong Wei <houlong.wei@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-next-20180807.orig/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ linux-next-20180807/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -567,3 +567,5 @@ static void __exit cmdq_drv_exit(void)
>  
>  subsys_initcall(cmdq_drv_init);
>  module_exit(cmdq_drv_exit);
> +
> +MODULE_LICENSE("GPL v2");
> 
> 


-- 
~Randy
