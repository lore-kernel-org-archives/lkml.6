Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5C5C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C308721872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfAXCSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 21:18:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbfAXCSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 21:18:13 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8BFBF240BB8092AC6728;
        Thu, 24 Jan 2019 10:18:09 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Thu, 24 Jan 2019
 10:18:08 +0800
Subject: Re: [PATCH] netfilter: nat: Update comment of get_unique_tuple
To:     <pablo@netfilter.org>, <kadlec@blackhole.kfki.hu>, <fw@strlen.de>,
        <davem@davemloft.net>
References: <20190110130618.25344-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <fa26810d-4b22-f1a3-8d0d-bbbde4cc14f5@huawei.com>
Date:   Thu, 24 Jan 2019 10:18:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190110130618.25344-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

On 2019/1/10 21:06, YueHaibing wrote:
> Replace outdated __ip_conntrack_confirm in comment.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/netfilter/nf_nat_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
> index d159e9e..f54a8db 100644
> --- a/net/netfilter/nf_nat_core.c
> +++ b/net/netfilter/nf_nat_core.c
> @@ -460,7 +460,8 @@ static void nf_nat_l4proto_unique_tuple(struct nf_conntrack_tuple *tuple,
>   * and NF_INET_LOCAL_OUT, we change the destination to map into the
>   * range. It might not be possible to get a unique tuple, but we try.
>   * At worst (or if we race), we will end up with a final duplicate in
> - * __ip_conntrack_confirm and drop the packet. */
> + * __nf_conntrack_confirm and drop the packet.
> + */
>  static void
>  get_unique_tuple(struct nf_conntrack_tuple *tuple,
>  		 const struct nf_conntrack_tuple *orig_tuple,
> 

