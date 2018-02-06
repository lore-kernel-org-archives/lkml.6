Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeBFQO2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:14:28 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39322 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbeBFQOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:14:21 -0500
Subject: Re: [PATCH] kconfig: Remove last trace of GENERIC_IO
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <422a4ff024038db02a2952158b0babe5b9281b2b.1517922544.git.robin.murphy@arm.com>
 <CAL_JsqKZ8xzKD=ncTyT1LzCe0+gRL1pzcjDVOyBv61hUTGESnA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <16de2ed2-c2d8-8236-b001-2bc78e4c1d2f@arm.com>
Date: Tue, 6 Feb 2018 16:14:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKZ8xzKD=ncTyT1LzCe0+gRL1pzcjDVOyBv61hUTGESnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/18 16:06, Rob Herring wrote:
> On Tue, Feb 6, 2018 at 7:11 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>> Since commit 9de8da47742b ("kconfig: kill off GENERIC_IO option"), this
>> select has done nothing, and is now just confusing. Clean it up.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   lib/Kconfig | 1 -
>>   1 file changed, 1 deletion(-)
> 
> We already have:
> 
> https://lkml.org/lkml/2018/1/17/924
> 
> and this series:
> 
> https://lkml.org/lkml/2018/2/4/208

Agh, Ulf's patch is even sat in my inbox...

This was just a drive-by from looking into HAS_IOMEM, sorry for the noise :)

Thanks,
Robin.
