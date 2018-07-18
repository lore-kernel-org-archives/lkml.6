Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883DAECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9EA2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9EA2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeGREZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:25:35 -0400
Received: from nautica.notk.org ([91.121.71.147]:34509 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeGREZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:25:34 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 34063C009; Wed, 18 Jul 2018 05:49:46 +0200 (CEST)
Date:   Wed, 18 Jul 2018 05:49:31 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH] net/9p/trans_virtio.c: fix some spell mistakes in
 comments
Message-ID: <20180718034931.GA27247@nautica>
References: <5B4EB7D9.9010108@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B4EB7D9.9010108@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Wed, Jul 18, 2018:
> Fix spelling mistake in comments of p9_virtio_zc_request().
> 
> Signed-off-by: Jun Piao <piaojun@huawei.com>

Thanks, queued it.

> ---
>  net/9p/trans_virtio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index c9f2717..86077f7 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -384,8 +384,8 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
>   * p9_virtio_zc_request - issue a zero copy request
>   * @client: client instance issuing the request
>   * @req: request to be issued
> - * @uidata: user bffer that should be ued for zero copy read
> - * @uodata: user buffer that shoud be user for zero copy write
> + * @uidata: user buffer that should be used for zero copy read
> + * @uodata: user buffer that should be used for zero copy write
>   * @inlen: read buffer size
>   * @outlen: write buffer size
>   * @in_hdr_len: reader header size, This is the size of response protocol data

-- 
Dominique Martinet
