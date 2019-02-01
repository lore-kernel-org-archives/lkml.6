Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32367C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051DD20870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfBAMgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:36:51 -0500
Received: from foss.arm.com ([217.140.101.70]:59200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfBAMgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:36:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 828A980D;
        Fri,  1 Feb 2019 04:36:50 -0800 (PST)
Received: from [10.1.25.162] (e121487-lin.cambridge.arm.com [10.1.25.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEA8C3F59C;
        Fri,  1 Feb 2019 04:36:47 -0800 (PST)
Subject: Re:
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Michal Hocko <mhocko@suse.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, rppt@linux.vnet.ibm.com,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
References: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
 <CAFqt6zbbXvpEEH2rNnLCBpNxEjK3YwNS1kYkyFPBhG7uvsHE1A@mail.gmail.com>
 <20190117112803.GC3710@rapoport-lnx>
 <CAFqt6zb-+hmF-zOrs-_J=m+YZO-R-VdwWKErYVHqtNcShk7sPA@mail.gmail.com>
 <10982a2f-8ff0-50f4-cdce-d028808d188f@arm.com>
 <CAFqt6zYE9Mv0Y+pfOtbOWeT5+AxPaJWB9_pkD5VO+pZVs-dF3w@mail.gmail.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <001c1195-fe06-fc78-b8a9-ec96f44aef32@arm.com>
Date:   Fri, 1 Feb 2019 12:36:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYE9Mv0Y+pfOtbOWeT5+AxPaJWB9_pkD5VO+pZVs-dF3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/19 12:32 PM, Souptick Joarder wrote:
> On Thu, Jan 31, 2019 at 6:28 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>>
>> Hi Souptick,
>>
>> On 1/31/19 5:54 AM, Souptick Joarder wrote:
>>> On Thu, Jan 17, 2019 at 4:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>>>>
>>>> On Thu, Jan 17, 2019 at 04:53:44PM +0530, Souptick Joarder wrote:
>>>>> On Mon, Jan 7, 2019 at 10:54 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>>>>>
>>>>>> Remove duplicate headers which are included twice.
>>>>>>
>>>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>>>
>>>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
>>>>
>>>>> Any comment on this patch ?
>>>
>>> If no further comment, can we get this patch in queue for 5.1 ?
>>
>> I'd be nice to use proper tags in subject
>> line. I'd suggest
>>
>> [PATCH] ARM: mm: Remove duplicate header
>>
>> but you can get some inspiration form
>>
>> git log --oneline --no-merges arch/arm/mm/
>>
>> In case you want to route it via ARM tree you need to drop it into
>> Russell's patch system [1].
> 
> How to drop it to Russell's patch system other than posting it to
> mailing list ? I don't know.

https://www.armlinux.org.uk/developer/patches/info.php

Vladimir

>>
>> [1] https://www.armlinux.org.uk/developer/patches/
>>
>> Cheers
>> Vladimir
> 

