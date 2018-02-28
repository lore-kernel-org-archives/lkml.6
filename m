Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbeB1P6S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:58:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52428 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752516AbeB1P6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:58:15 -0500
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>, Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] arm64: dts: juno: fix size of GICv2m MSI frames
To: Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180207143255.17003-3-marc.zyngier@arm.com>
 <1519832935-7338-1-git-send-email-sudeep.holla@arm.com>
 <36126393-ee37-40f1-9d5d-1c7f25c648dc@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <f4ce910b-f263-a4e1-710c-875ac152d4bf@arm.com>
Date: Wed, 28 Feb 2018 15:58:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <36126393-ee37-40f1-9d5d-1c7f25c648dc@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/02/18 15:51, Robin Murphy wrote:
> Hi Sudeep,
> 
> Cheers for sorting it out...
> 
> On 28/02/18 15:48, Sudeep Holla wrote:
>> Currently the size of GICv2m MSI frames are listed as 4kB while the
>> Juno TRM specifies 64kB for each of these MSI frames.
>>
>> Though the devices connected themself might just use the first 4kB,
> 
> s/themself/themselves/
> 
>> to be consistent with the genaral practice of 64kB boundary alignment
> 
> s/genaral/general/
> 

Fixed those now.

>> to all the devices, lets keep the size as 64kB. This might also help
>> in avoiding any surprise when passing the device to a VM.
>>
>> This patch increase the size of each GICv2m MSI frames from 4kB to 64kB
>> as per the specification.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 

Thanks.

-- 
Regards,
Sudeep
