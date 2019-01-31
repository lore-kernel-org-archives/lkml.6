Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD4AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757922070C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733185AbfAaM6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:58:50 -0500
Received: from foss.arm.com ([217.140.101.70]:43284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732280AbfAaM6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:58:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F00EA78;
        Thu, 31 Jan 2019 04:58:50 -0800 (PST)
Received: from [10.1.25.162] (e121487-lin.cambridge.arm.com [10.1.25.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 693F73F589;
        Thu, 31 Jan 2019 04:58:48 -0800 (PST)
Subject: Re:
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     Michal Hocko <mhocko@suse.com>,
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
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <10982a2f-8ff0-50f4-cdce-d028808d188f@arm.com>
Date:   Thu, 31 Jan 2019 12:58:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zb-+hmF-zOrs-_J=m+YZO-R-VdwWKErYVHqtNcShk7sPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick,

On 1/31/19 5:54 AM, Souptick Joarder wrote:
> On Thu, Jan 17, 2019 at 4:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>>
>> On Thu, Jan 17, 2019 at 04:53:44PM +0530, Souptick Joarder wrote:
>>> On Mon, Jan 7, 2019 at 10:54 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>>>
>>>> Remove duplicate headers which are included twice.
>>>>
>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>
>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
>>
>>> Any comment on this patch ?
> 
> If no further comment, can we get this patch in queue for 5.1 ?

I'd be nice to use proper tags in subject
line. I'd suggest 

[PATCH] ARM: mm: Remove duplicate header

but you can get some inspiration form

git log --oneline --no-merges arch/arm/mm/

In case you want to route it via ARM tree you need to drop it into
Russell's patch system [1]. 

[1] https://www.armlinux.org.uk/developer/patches/

Cheers
Vladimir
