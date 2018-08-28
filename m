Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F178C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3232087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fpjapg+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3232087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeH2CWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:22:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47388 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeH2CWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L8MwGu5K3JPopr7scIHdFloNzJuRNy2bjOke80KbnsE=; b=fpjapg+3j18bIefonxpeQBQSdx
        ME7+HDchGj7b7M7lu6g8nEW/3ZE1ujKoMPYynrwFu42K/rzmAS+3n08dUKt/kHYxRdRGhi8ONzYDX
        0KnbY+cGxFx/HUsy+hf/OE2ndyKxkzx9+sn8/SWVpuO0mFwyG6gS/+sUQD8TKZ0zeivSKIXh+AXMR
        qce/W8Svl9vJ8hjJkaJgJ2cJcBKJqrnPCruOntEOCvtmhIEQNi/rG0avZvUabUsn3oC1/xzlV5SrC
        fnw3pDbqq8/OzV6ZSpqvX1kF/zxkOchDqz8egm6lZUAAHdM+w7FucqjCGGt+CsVww+aZla2yXwJfA
        O53KlVKg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fumTm-0005RT-SP; Tue, 28 Aug 2018 22:28:55 +0000
Subject: Re: [PATCH] Trivial numbering change in comments.
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Ray Clinton <mr.ray.clinton@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Alistair Strachan <astrachan@google.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
References: <CAPMnawu33A5L5a6a00tZ+_9cQxyN97OwXK0sO9Q60+YvR=Yg_A@mail.gmail.com>
 <20180828220327.GA22320@flashbox>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1c9d6084-9bb6-597b-029c-daf4ffd85c77@infradead.org>
Date:   Tue, 28 Aug 2018 15:28:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828220327.GA22320@flashbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 03:03 PM, Nathan Chancellor wrote:
> On Tue, Aug 28, 2018 at 04:08:18PM -0400, Ray Clinton wrote:
>> I'm trying to get my feet wet in kernel dev and while working on a patch
>> I noticed in a lengthy comment block that the number "2" was skipped
>> in a description of the steps of a protocol. This patch is simply correcting
>> this. This is for 4.18.0.
>>
>> It is a very trivial patch, but this is my first actual try at one and
>> thought I
>> might start out small (and I don't think you can get smaller than a single
>>  character change). Any and all advice (about this patch, email, or
>> anything else) is very welcome.
>>
>> Thanks so much!
>> Ray
>>
>> Signed-off-by: Ray Clinton <mr.ray.clinton@gmail.com>
>> ---
>>  drivers/staging/android/uapi/vsoc_shm.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/android/uapi/vsoc_shm.h
>> b/drivers/staging/android/uapi/vsoc_shm.h
>> index 6291fb2..0301172 100644
>> --- a/drivers/staging/android/uapi/vsoc_shm.h
>> +++ b/drivers/staging/android/uapi/vsoc_shm.h
>> @@ -92,7 +92,7 @@ struct fd_scoped_permission_arg {
>>   *    The transmitter can choose any appropriate hashing algorithm, including
>>   *    hash = futex_offset & ((1 << num_nodes_lg2) - 1)
>>   *
>> - * 3. The transmitter should atomically compare and swap futex_offset with 0
>> + * 2. The transmitter should atomically compare and swap futex_offset with 0
>>   *    at hash. There are 3 possible outcomes
>>   *      a. The swap fails because the futex_offset is already in the table.
>>   *         The transmitter should stop.
>> -- 
>> 2.7.4
> 
> Hi Ray,
> 
> Welcome to Linux kernel development and good first patch. Just a few
> words of advice for any future patches that you submit!
> 
> Make sure to include what subsystem you are modifying in the commit
> title. You can see examples by using 'git log --online <path>'; for

s/online/oneline/  :)

> this subsystem, it's usually "staging: android: vsoc:", making this
> patch's title "staging: android: vsoc: Trivial numbering change in comments".
> 
> I'd recommend keeping author details (such as your experience and other
> info) in-between the '---' and the file names modified in the patch so
> that they can be read by the maintainers/reviewers but not added to the
> commit message by 'git am'. This is also helpful for adding comments
> like what changed between versions of the patch or maybe something like
> "I'm not sure this change is correct, it could also be done via <method>,
> I'd like some review".
> 
> Small nits in the grand scheme of things but they'll come in handy as
> you develop more and more complex patches and series.
> 
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Cheers!
> Nathan
> 


-- 
~Randy
