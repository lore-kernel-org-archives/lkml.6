Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131F2C282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E1721726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfAVKaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:30:46 -0500
Received: from foss.arm.com ([217.140.101.70]:50282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbfAVKap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:30:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 632F8EBD;
        Tue, 22 Jan 2019 02:30:45 -0800 (PST)
Received: from [10.1.196.42] (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB4323F6A8;
        Tue, 22 Jan 2019 02:30:43 -0800 (PST)
Cc:     Sudeep.Holla@arm.com, rafael@kernel.org,
        linux-kernel@vger.kernel.org, zhangfx@lemote.com,
        wuzhangjin@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH V3] cacheinfo: Keep the old value if of_property_read_u32
 fails
To:     chenhuacai@gmail.com, gregkh@linuxfoundation.org
References: <1545207363-7402-1-git-send-email-chenhc@lemote.com>
 <CAAhV-H61Muv7V358Mfe27C0tEedOQGncN1Dfq2wu1ddaVT1o0w@mail.gmail.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <0f1a742c-9123-e615-6abc-bc6325a7644c@arm.com>
Date:   Tue, 22 Jan 2019 10:30:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAAhV-H61Muv7V358Mfe27C0tEedOQGncN1Dfq2wu1ddaVT1o0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/01/2019 00:51, Huacai Chen wrote:
> Ping?
> 
> On Wed, Dec 19, 2018 at 4:15 PM Huacai Chen <chenhc@lemote.com> wrote:
>>
>> Commit 448a5a552f336bd7b847b1951 ("drivers: base: cacheinfo: use OF
>> property_read_u32 instead of get_property,read_number") makes cache
>> size and number_of_sets be 0 if DT doesn't provide there values. I
>> think this is unreasonable so make them keep the old values, which is
>> the same as old kernels.
>>
>> Fixes: 448a5a552f33 ("drivers: base: cacheinfo: use OF property_read_u32 instead of get_property,read_number")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Looks like this slipped through the cracks during holiday period.
Wait until Greg responds for a week, if not please repost as it may be
difficult to dig out old emails especially the ones during holidays.

-- 
Regards,
Sudeep
