Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DF6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC4C2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OrxCn2zF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC4C2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbeGWWlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:41:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbeGWWla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=plvNO2omLlVIj8YTfETVX+6OOFle1CON1LAkwNfAVEY=; b=OrxCn2zFBjmVJKmoIPJ1BolAo
        fGpPGf/jvxVpOV0FqCYahZ5d2AsA1oU89UG+Ezswz3rBlcgoG0UFcphVTSMvTqXprw1pvu7PEixms
        MAfxmoJZS4g+IDjlHSuh8XUagBjW2aYeWJl07eJk6oBNqK0p9EFmd5dtR4lctiLUehkLaBidVSsNy
        QWEqTbkt7+IQXSqwOlhP1WZqIFTm8XLgBnecquUXYJY6wzklY0CcgrhBYukyqmko4+G2bFqfESnkZ
        PQ0i1yEBDmfxZ6nB84+CWwQMQY+aofs+jhqxLfNePoP5eRxkJdBcHt9APN+mXrSOSs+fRjcUzrokM
        0YdqNtmnA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhiX7-0007Zd-9E; Mon, 23 Jul 2018 21:38:21 +0000
Subject: Re: [PATCH] Drivers: Xen: xlate_mmu.c: Fixed comment layout
To:     Mark Railton <mark@markrailton.com>, boris.ostrovsky@oracle.com,
        jgross@suse.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20180723213404.20720-1-mark@markrailton.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e0b30ab8-d418-cbe0-d03c-a0aee1d48367@infradead.org>
Date:   Mon, 23 Jul 2018 14:38:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723213404.20720-1-mark@markrailton.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 02:34 PM, Mark Railton wrote:
> Fixed issue with multi line comment

Fix [not Fixed]

> 
> Signed-off-by: Mark Railton <mark@markrailton.com>
> ---
>  drivers/xen/xlate_mmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
> index 23f1387b3ef7..3b03bc1641ed 100644
> --- a/drivers/xen/xlate_mmu.c
> +++ b/drivers/xen/xlate_mmu.c
> @@ -151,8 +151,9 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
>  	struct remap_data data;
>  	unsigned long range = DIV_ROUND_UP(nr, XEN_PFN_PER_PAGE) << PAGE_SHIFT;
>  
> -	/* Kept here for the purpose of making sure code doesn't break
> -	   x86 PVOPS */
> +	/* Kept here for the purpose of making sure code doesn't
> +	 * break x86 PVOPS
> +	 */

That is still not the preferred kernel multi-line comment style.
Documentation/process/coding-style.rst says:

	/*
	 * This is the preferred style for multi-line
	 * comments in the Linux kernel source code.
	 * Please use it consistently.
	 *
	 * Description:  A column of asterisks on the left side,
	 * with beginning and ending almost-blank lines.
	 */

although Networking code has a slightly different preferred style (as in
your patch).

>  	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
>  
>  	data.fgfn = gfn;
> 


-- 
~Randy
