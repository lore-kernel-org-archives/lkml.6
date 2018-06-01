Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeFARyk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:54:40 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:43289 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbeFARyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:54:38 -0400
X-Google-Smtp-Source: ADUXVKJFSH9EvB2RH+dHdsKMwOIkQr8sCemVpK5uQne3Zy6R3T/Yk65fxrkvVuNOaTK5z9MCjO7YxQ==
Subject: Re: [PATCH v2 1/2] ARM: debug: Add Iproc UART3 debug addresses
To: Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, Laura Abbott <labbott@redhat.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>
References: <20180530131956.13972-1-peron.clem@gmail.com>
 <93c2d07a-9344-ed39-261e-11084067a3fa@broadcom.com>
 <CAJiuCcek9KU6QWsAAxVCLUaf1v97uR6FcLOfY=A1LGCMTmjHjg@mail.gmail.com>
 <41bbf801-f060-2056-4015-b4d05c6831bb@broadcom.com>
 <61a35071-4304-a25f-8c99-fe504b2c2346@gmail.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <152f524b-49c5-2fc3-8f65-b71f0241b530@broadcom.com>
Date: Fri, 1 Jun 2018 10:54:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <61a35071-4304-a25f-8c99-fe504b2c2346@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry Florian, I had a couple issues with my email client yesterday and 
I'm not sure if you have received my reply.

Please see my reply inline.

On 5/31/2018 3:16 PM, Florian Fainelli wrote:
> 
> 
> On 05/31/2018 10:24 AM, Ray Jui wrote:
>>
>>
>> On 5/31/2018 1:22 AM, Clément Péron wrote:
>>> Hi Rai,
>>>
>>> On Wed, 30 May 2018 at 19:25, Ray Jui <ray.jui@broadcom.com> wrote:
>>>>
>>>> Hi Clément,
>>>>
>>>> Correct me if I'm wrong, but I thought the trend is to move to use
>>>> earlycon that can be activated from kernel command line for early print
>>>> before the serial driver is loaded.
>>>>
>>>> Have you tried earlcon?
>>> No, only tested this method.
>>>
>>> Thanks,
>>> Clement
>>>
>>
>> If I remember it correctly, I think the trend is to use earlycon. There
>> are obvious shortcomings by making this configuration compile time based.
> 
> This is true, though on ARM 32-bit kernels DEBUG_LL gets used by the
> kernel self-decompressor and also before earlycon has a chance to run,
> this is useful to debugging memory issues where your memory
> configuration is incorrect typically.
> 

This is true.

> Either way is fine with me (accepting or dropping) the patch, though
> there is probably minimal impact in just accepting such a change.
> 

Will leave the decision to you then.

Thanks,

Ray
