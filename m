Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754696AbeBGRP0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753390AbeBGRPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:15:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEEB217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x224ru4iRFFavWAvv0Q5QHJyAIw6017qJXqOUnAbviMqSvTPdHwCj0+YpFyMIfJ+gOUrLpZcJPc5sjdMs7qHZoi4=
MIME-Version: 1.0
In-Reply-To: <16de2ed2-c2d8-8236-b001-2bc78e4c1d2f@arm.com>
References: <422a4ff024038db02a2952158b0babe5b9281b2b.1517922544.git.robin.murphy@arm.com>
 <CAL_JsqKZ8xzKD=ncTyT1LzCe0+gRL1pzcjDVOyBv61hUTGESnA@mail.gmail.com> <16de2ed2-c2d8-8236-b001-2bc78e4c1d2f@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 7 Feb 2018 11:15:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ1Hc8irF4LWM=1=OACC=fmRbg4c1evV777zKj3XOzi=w@mail.gmail.com>
Message-ID: <CAL_JsqJ1Hc8irF4LWM=1=OACC=fmRbg4c1evV777zKj3XOzi=w@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Remove last trace of GENERIC_IO
To: Robin Murphy <Robin.Murphy@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 6, 2018 8:14 AM, "Robin Murphy" <robin.murphy@arm.com> wrote:
>
> On 06/02/18 16:06, Rob Herring wrote:
>>
>> On Tue, Feb 6, 2018 at 7:11 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> Since commit 9de8da47742b ("kconfig: kill off GENERIC_IO option"), this
>>> select has done nothing, and is now just confusing. Clean it up.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>   lib/Kconfig | 1 -
>>>   1 file changed, 1 deletion(-)
>>
>>
>> We already have:
>>
>> https://lkml.org/lkml/2018/1/17/924
>>
>> and this series:
>>
>> https://lkml.org/lkml/2018/2/4/208
>
>
> Agh, Ulf's patch is even sat in my inbox...
>
> This was just a drive-by from looking into HAS_IOMEM, sorry for the noise :)

What are you looking into there? IMO, we should get rid of HAS_IOMEM.
It's basically a !UML option to turn off a bunch of drivers in UML.

Rob
