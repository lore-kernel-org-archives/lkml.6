Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C39ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0D920854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IzzgN4c1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0D920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbeGWWrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:47:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbeGWWrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cFhaIEl6XKDyQtbDGXn/qp5NMrjgmo1b4RsKI6Dq7nU=; b=IzzgN4c1KcnrupbP+lWlqxJyc
        FUuf+iV7QzqhfMaB7SDCxXgI2gRzj5buTsVRspnftxQ1EZpZgB7IKAG1ZaNLfcpKvdUB55FjwYfC6
        9f/PPs5dWP+hbZwoD2y6PdPRZKK+IR3d+cqXxQ2F8kzpzk/Im6Mtgk/AGDDQhs9GdiqZJzX2lWH73
        ZM5HBkqynhk+wpuszUoTYsHAsY3NzTnjjotVFP4PnIpDXUhVknS5P9Bdtu9irsCVHxmxQR0pE4wO2
        msCPzm0I10EgIg8jsQ78PZF9uQTSdXoHujXISqPoWYt6qTZHQFvrbxsCPpB73R5aTfaXiZMGRVW3k
        GMqsLhKzw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhid3-0000ml-Dv; Mon, 23 Jul 2018 21:44:29 +0000
Subject: Re: [PATCH] Drivers: Xen: xlate_mmu.c: Fixed comment layout
To:     Mark Railton <mark@markrailton.com>
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20180723213404.20720-1-mark@markrailton.com>
 <e0b30ab8-d418-cbe0-d03c-a0aee1d48367@infradead.org>
 <20180723214011.GA21167@ZeroCool>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <01b221f3-d923-1abb-0168-bfeba80b9a9a@infradead.org>
Date:   Mon, 23 Jul 2018 14:44:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723214011.GA21167@ZeroCool>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 02:40 PM, Mark Railton wrote:
> On Mon, Jul 23, 2018 at 02:38:20PM -0700, Randy Dunlap wrote:
>> On 07/23/2018 02:34 PM, Mark Railton wrote:
>>> Fixed issue with multi line comment
>>
>> Fix [not Fixed]
>>
>>>
>>> Signed-off-by: Mark Railton <mark@markrailton.com>
>>> ---
>>>  drivers/xen/xlate_mmu.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
>>> index 23f1387b3ef7..3b03bc1641ed 100644
>>> --- a/drivers/xen/xlate_mmu.c
>>> +++ b/drivers/xen/xlate_mmu.c
>>> @@ -151,8 +151,9 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
>>>  	struct remap_data data;
>>>  	unsigned long range = DIV_ROUND_UP(nr, XEN_PFN_PER_PAGE) << PAGE_SHIFT;
>>>  
>>> -	/* Kept here for the purpose of making sure code doesn't break
>>> -	   x86 PVOPS */
>>> +	/* Kept here for the purpose of making sure code doesn't
>>> +	 * break x86 PVOPS
>>> +	 */
>>
>> That is still not the preferred kernel multi-line comment style.
>> Documentation/process/coding-style.rst says:
>>
>> 	/*
>> 	 * This is the preferred style for multi-line
>> 	 * comments in the Linux kernel source code.
>> 	 * Please use it consistently.
>> 	 *
>> 	 * Description:  A column of asterisks on the left side,
>> 	 * with beginning and ending almost-blank lines.
>> 	 */
>>
>> although Networking code has a slightly different preferred style (as in
>> your patch).
>>
>>>  	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
>>>  
>>>  	data.fgfn = gfn;
>>>
>>
>>
>> -- 
>> ~Randy
> 
> Thank's for the feedback, I'll get that updated now.
> 
> I'm still kinda new to this, I assume I need to send the new patch via
> git send-email?

That is one option.  Use whatever works for you.

There are several email clients that also work well.
See Documentation/process/email-clients.rst.


-- 
~Randy
