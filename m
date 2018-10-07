Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7127AC65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCFD20882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCFD20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJGRAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 13:00:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:54590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbeJGRAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 13:00:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE91CACF9;
        Sun,  7 Oct 2018 09:54:05 +0000 (UTC)
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861799.4088.6.camel@HansenPartnership.com>
 <CAKMK7uGvgttqL_RoXumd0F4w8UMqwaVODaMWnOZz5weSFzDJ2A@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <b0bb3179-6bf5-3a85-9567-b0a73e1c3e9d@suse.com>
Date:   Sun, 7 Oct 2018 11:54:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uGvgttqL_RoXumd0F4w8UMqwaVODaMWnOZz5weSFzDJ2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/18 11:04 AM, Daniel Vetter wrote:
> On Sat, Oct 6, 2018 at 11:36 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
>>
>> From 4a614e9440148894207bef5bf69e74071baceb3b Mon Sep 17 00:00:00 2001
>> From: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Date: Sat, 6 Oct 2018 14:21:56 -0700
>> Subject: [PATCH 1/2] code-of-conduct: Fix the ambiguity about collecting email
>>  addresses
>>
>> The current code of conduct has an ambiguity in the it considers publishing
>> private information such as email addresses unacceptable behaviour.  Since
>> the Linux kernel collects and publishes email addresses as part of the patch
>> process, add an exception clause for email addresses ordinarily collected by
>> the project to correct this ambiguity.
>>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> ---
>>  Documentation/process/code-of-conduct.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
>> index ab7c24b5478c..aa40e34e7785 100644
>> --- a/Documentation/process/code-of-conduct.rst
>> +++ b/Documentation/process/code-of-conduct.rst
>> @@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants include:
>>  * Trolling, insulting/derogatory comments, and personal or political attacks
>>  * Public or private harassment
>>  * Publishing others’ private information, such as a physical or electronic
>> -  address, without explicit permission
>> +  address not ordinarily collected by the project, without explicit permission
>>  * Other conduct which could reasonably be considered inappropriate in a
>>    professional setting
> 
> We've discussed this a bit with freedesktop.org people a while ago,
> both from a CoC and privacy regulations pov, and we concluded that
> attaching random people's emails in Reported-by: and similar lines,
> without their consent, is indeed a problem. Bugzilla is rather
> problematic in this way, since it looks like it's protecting your
> email address and keeping it private, but then you can still just grab
> it from the bugzilla emails without first asking for permission.
> That's one of the reasons why fd.o admins want to retire Bugzilla in
> favour of gitlab issues (where this is handled a lot more strictly).
> 
> What we discussed in the older thread here on ksummit-discuss is
> making it clear that email addresses sent to public mailing lists are
> considered public information, which I think is worth clarifying. But
> what you're excempting here is anything collected without permission
> in the past, which I don't think is a good wording. I've definitely
> been skimping on the rules here in the past. At least in my
> understanding of the legal situation, if you get a bug report through
> a private channel, or at least a channel that hides private address
> information (like Bugzilla does, albeit sloppily), then you do have to
> ask for explicit consent to publishing that information.

That is my interpretation, too.

And it even says so in Documentation/submitting-patches.rst, do I don't
we need to clarify it further.

Cheers,

Hannes
