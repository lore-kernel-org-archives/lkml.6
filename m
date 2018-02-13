Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964988AbeBMQsr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:48:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:40314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934060AbeBMQsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:48:46 -0500
Subject: Re: [PATCH] x86/acpi: check rsdp address received via bootparams to
 be valid
To: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, mingo@redhat.com
References: <20180116135730.19216-1-jgross@suse.com>
 <20180116154630.ke53suvokynj73qd@gmail.com>
 <432c21ab-24d8-1e70-a471-ad8a14357d4e@suse.com>
 <20180116163529.rc5j23oqmwk45rp5@gmail.com>
 <4a8b0233-9bb8-3c95-0a08-93a5ceffc231@suse.com>
 <20180117153404.qnv3tjf6jhk4xijs@gmail.com>
 <a0a790b4-069b-8c99-e898-368fce01c632@suse.com>
 <20180213163244.j2zuxyhs4kbfhwgj@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <1d6083f2-0a3e-2f3a-7089-426f81e8af93@suse.com>
Date: Tue, 13 Feb 2018 17:48:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213163244.j2zuxyhs4kbfhwgj@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/18 17:32, Ingo Molnar wrote:
> 
> * Juergen Gross <jgross@suse.com> wrote:
> 
>> So what about the following:
>>
>> From version 0x020e on (current version without my patches is 0x020d)
>> the boot loader will write its supported version or'ed with 0x8000 into
>> the same version field. So we can be sure any added fields are filled
>> with real data or the information has been evaluated by the boot loader,
>> if the returned version included that field. If the boot loader finds
>> the kernel supports a version < 0x020e it won't return its supported
>> version.
> 
> This seems like a usable workaround to me, as long as everyone involved
> agrees with it.

Okay, thanks for the feedback.

I'll go that route.

> I've removed the patches for the time being.

Seems a sensible thing to do.


Juergen
