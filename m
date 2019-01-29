Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5152C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0362148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfA2HL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:11:26 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:54636 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfA2HLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:11:25 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 062F11403ED22;
        Mon, 28 Jan 2019 23:11:24 -0800 (PST)
Date:   Mon, 28 Jan 2019 23:11:24 -0800 (PST)
Message-Id: <20190128.231124.1595620451604571041.davem@davemloft.net>
To:     yang.wei9@zte.com.cn
Cc:     krzk@kernel.org, herbert@gondor.apana.org.au,
        yuehaibing@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn
Subject: Re: [PATCH net] net: apple: replace dev_kfree_skb_irq by
 dev_consume_skb_irq for drop profiles
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1548718753-41047-1-git-send-email-yang.wei9@zte.com.cn>
References: <1548718753-41047-1-git-send-email-yang.wei9@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 28 Jan 2019 23:11:25 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Wei <yang.wei9@zte.com.cn>
Date: Tue, 29 Jan 2019 07:39:13 +0800

> dev_consume_skb_irq() should be called in bmac_txdma_intr() when 
> xmit done. It makes drop profiles more friendly.
> 
> Signed-off-by: Yang Wei <yang.wei9@zte.com.cn>

Applied.
