Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E368ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F7820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mk3xsQ9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F7820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388260AbeGWW60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:58:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388134AbeGWW60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2BhYGxodtoo6yOcgOLfmqUe9vFZ+7aARdjNNzbdEtt4=; b=Mk3xsQ9DhSNUq+Fziv4+G2ayO
        U246R1rSgZrlX0JSKpHPbK/8NqTA5ci6gO/+fQ1C17e7H4FZuA6jaDvD7xd8gv7yi1a/GRGr4ramA
        becQf38exY+Hd8ppKs3Sg/xf/ms95EugppVbnRYhwMi4K2YQeEWu3OyBxSm2Jv83htg3u/Kl3fS/j
        dgIfOrvt5TBiYifcvs2RirPRCcx768YH5fIPFwkgNzrV+ECnsgOUj+cEVffxdv7idFqW7Nju+P6o/
        2Pr0I4sdzRXZijOY8Ks/82A6ziyNIJC4/y8wnTJiA0WC5xgGDb4LgE69hsDQZtJHuiYSy3ITw4JaG
        WkGA68s0g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhinR-0008LV-74; Mon, 23 Jul 2018 21:55:13 +0000
Subject: Re: [PATCH] Drivers: Xen: xlate_mmu.c: Fixed comment layout
To:     Mark Railton <mark@markrailton.com>
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20180723213404.20720-1-mark@markrailton.com>
 <e0b30ab8-d418-cbe0-d03c-a0aee1d48367@infradead.org>
 <20180723214011.GA21167@ZeroCool>
 <01b221f3-d923-1abb-0168-bfeba80b9a9a@infradead.org>
 <20180723214804.GA21761@ZeroCool>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e8cab255-eb21-fd08-e62b-3afbbe853b84@infradead.org>
Date:   Mon, 23 Jul 2018 14:55:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723214804.GA21761@ZeroCool>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 02:48 PM, Mark Railton wrote:
> On Mon, Jul 23, 2018 at 02:44:28PM -0700, Randy Dunlap wrote:
>> On 07/23/2018 02:40 PM, Mark Railton wrote:
>>> On Mon, Jul 23, 2018 at 02:38:20PM -0700, Randy Dunlap wrote:
>>>> On 07/23/2018 02:34 PM, Mark Railton wrote:
>>>>> Fixed issue with multi line comment
>>>>
>>>> Fix [not Fixed]
>>>>
>>>>>
>>>>> Signed-off-by: Mark Railton <mark@markrailton.com>
>>>>> ---
>>>>>  drivers/xen/xlate_mmu.c | 5 +++--
>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
>>>>> index 23f1387b3ef7..3b03bc1641ed 100644
>>>>> --- a/drivers/xen/xlate_mmu.c
>>>>> +++ b/drivers/xen/xlate_mmu.c
>>>>> @@ -151,8 +151,9 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
>>>>>  	struct remap_data data;
>>>>>  	unsigned long range = DIV_ROUND_UP(nr, XEN_PFN_PER_PAGE) << PAGE_SHIFT;
>>>>>  
>>>>> -	/* Kept here for the purpose of making sure code doesn't break
>>>>> -	   x86 PVOPS */
>>>>> +	/* Kept here for the purpose of making sure code doesn't
>>>>> +	 * break x86 PVOPS
>>>>> +	 */
>>>>
>>>> That is still not the preferred kernel multi-line comment style.
>>>> Documentation/process/coding-style.rst says:
>>>>
>>>> 	/*
>>>> 	 * This is the preferred style for multi-line
>>>> 	 * comments in the Linux kernel source code.
>>>> 	 * Please use it consistently.
>>>> 	 *
>>>> 	 * Description:  A column of asterisks on the left side,
>>>> 	 * with beginning and ending almost-blank lines.
>>>> 	 */
>>>>
>>>> although Networking code has a slightly different preferred style (as in
>>>> your patch).
>>>>
>>>>>  	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
>>>>>  
>>>>>  	data.fgfn = gfn;
>>>>>
>>>>
>>>>
>>>> -- 
>>>> ~Randy
>>>
>>> Thank's for the feedback, I'll get that updated now.
>>>
>>> I'm still kinda new to this, I assume I need to send the new patch via
>>> git send-email?
>>
>> That is one option.  Use whatever works for you.
>>
>> There are several email clients that also work well.
>> See Documentation/process/email-clients.rst.
>>
>>
>> -- 
>> ~Randy
> 
> From 57c8104d2a30020005be16df2ca69ed66f6c4ae9 Mon Sep 17 00:00:00 2001
> From: Mark Railton <mark@markrailton.com>
> Date: Mon, 23 Jul 2018 22:28:53 +0100
> Subject: [PATCH] Drivers: Xen: xlate_mmu.c: Fixed comment layout
> 
> Fixed issue with multi line comment
> 
> Signed-off-by: Mark Railton <mark@markrailton.com>
> ---
>  drivers/xen/xlate_mmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
> index 23f1387b3ef7..2b77c79f8ce7 100644
> --- a/drivers/xen/xlate_mmu.c
> +++ b/drivers/xen/xlate_mmu.c
> @@ -151,8 +151,10 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
>  	struct remap_data data;
>  	unsigned long range = DIV_ROUND_UP(nr, XEN_PFN_PER_PAGE) << PAGE_SHIFT;
> 
> -	/* Kept here for the purpose of making sure code doesn't break
> -	   x86 PVOPS */
> +	/*
> +	 * Kept here for the purpose of making sure code doesn't
> +	 * break x86 PVOPS
> +	 */
>  	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
> 
>  	data.fgfn = gfn;
> --
> 2.17.1


Hi,

a.  The subject and the patch description should be in present tense, i.e.,
Fix instead of Fixed.

b.  Ideally you start a new email thread for new versions of a patch (but Cc:
the interested parties).

For the patch itself:
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
