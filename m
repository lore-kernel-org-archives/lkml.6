Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754895AbeEWSVe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:21:34 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40616 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754658AbeEWSVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:21:33 -0400
X-Google-Smtp-Source: ADUXVKJnkqWrHTpQh6/IyJrGU4q2et2KoOffK5R/XJXVfaP45B7CiEOKODcUEKm8haeQZ1J3nH5QYQ==
Subject: Re: B53 DSA switch problem on Banana Pi-R1 on Fedora 26
To: Gerhard Wiesinger <lists@wiesinger.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org
References: <3bdb712d-38bd-e2ca-63cf-8406a7b5689d@wiesinger.com>
 <20180522201632.GB4396@lunn.ch>
 <59d6b55f-d50a-063c-90a9-31a758e01383@gmail.com>
 <fa5c2615-40b3-62bc-3dda-59f9ef574686@wiesinger.com>
 <76c3f5ec-0ab2-c06d-98e8-277284bb1a8e@gmail.com>
 <e1b56677-50e5-94e0-86f0-b0c797c4897d@gmail.com>
 <88af3639-f3f9-ed45-c6bd-b30021347633@wiesinger.com>
 <fb898d25-3e5a-787b-cc4b-f670e4b61f58@gmail.com>
 <f0a85a79-2d4a-cdc2-f007-a707b8619b23@wiesinger.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <40ccb3ae-fe60-4bf2-afa3-63ed62336e96@gmail.com>
Date: Wed, 23 May 2018 11:21:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f0a85a79-2d4a-cdc2-f007-a707b8619b23@wiesinger.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/2018 11:11 AM, Gerhard Wiesinger wrote:
> On 23.05.2018 19:47, Florian Fainelli wrote:
>> On 05/23/2018 10:29 AM, Gerhard Wiesinger wrote:
>>> On 23.05.2018 17:50, Florian Fainelli wrote:
>>>> On 05/23/2018 08:28 AM, Florian Fainelli wrote:
>>>>> On 05/22/2018 09:49 PM, Gerhard Wiesinger wrote:
>>>>>> On 22.05.2018 22:42, Florian Fainelli wrote:
>>>>>>> On 05/22/2018 01:16 PM, Andrew Lunn wrote:
>>>>>>>>> Planned network structure will be as with 4.7.x kernels:
>>>>>>>>>
>>>>>>>>> br0 <=> eth0.101 <=> eth0 (vlan 101 tagged) <=> lan 1-lan4
>>>>>>>>> (vlan 101
>>>>>>>>> untagged pvid)
>>>>>>>>>
>>>>>>>>> br1 <=> eth0.102 <=> eth0 (vlan 102 tagged) <=> wan (vlan 102
>>>>>>>>> untagged pvid)
>>>>>>>> Do you even need these vlans?
>>>>>>> Yes, remember, b53 does not currently turn on Broadcom tags, so the
>>>>>>> only
>>>>>>> way to segregate traffic is to have VLANs for that.
>>>>>>>
>>>>>>>> Are you doing this for port separation? To keep lan1-4 traffic
>>>>>>>> separate from wan? DSA does that by default, no vlan needed.
>>>>>>>>
>>>>>>>> So you can just do
>>>>>>>>
>>>>>>>> ip link add name br0 type bridge
>>>>>>>> ip link set dev br0 up
>>>>>>>> ip link set dev lan1 master br0
>>>>>>>> ip link set dev lan2 master br0
>>>>>>>> ip link set dev lan3 master br0
>>>>>>>> ip link set dev lan4 master br0
>>>>>>>>
>>>>>>>> and use interface wan directly, no bridge needed.
>>>>>>> That would work once Broadcom tags are turned on which requires
>>>>>>> turning
>>>>>>> on managed mode, which requires work that I have not been able to
>>>>>>> get
>>>>>>> done :)
>>>>>> Setup with swconfig:
>>>>>>
>>>>>> #!/usr/bin/bash
>>>>>>
>>>>>>
>>>>>> INTERFACE=eth0
>>>>>>
>>>>>> # Delete all IP addresses and get link up
>>>>>> ip addr flush dev ${INTERFACE}
>>>>>> ip link set ${INTERFACE} up
>>>>>>
>>>>>> # Lamobo R1 aka BPi R1 Routerboard
>>>>>> #
>>>>>> # Speaker | LAN1 | LAN2 | LAN3 | LAN4 || LAN5 | HDMI
>>>>>> # SW-Port |  P2  |  P1  |  P0  |  P4  ||  P3  |
>>>>>> # VLAN    |  11  |  12  |  13  |  14  ||ALL(t)|
>>>>>> #
>>>>>> # Switch-Port P8 - ALL(t) boards internal CPU Port
>>>>>>
>>>>>> # Setup switch
>>>>>> swconfig dev ${INTERFACE} set reset 1
>>>>>> swconfig dev ${INTERFACE} set enable_vlan 1
>>>>>> swconfig dev ${INTERFACE} vlan 101 set ports '3 8t'
>>>>>> swconfig dev ${INTERFACE} vlan 102 set ports '4 0 1 2 8t'
>>>>>> swconfig dev ${INTERFACE} set apply 1
>>>>>>
>>>>>> How to achieve this setup CURRENTLY with DSA?
>>>>> Your first email had the right programming sequence, but you did not
>>>>> answer whether you have CONFIG_BRIDGE_VLAN_FILTERING enabled or not,
>>>>> which is likely your problem.
>>>> Here are some reference configurations that should work:
>>>>
>>>> https://github.com/armbian/build/issues/511#issuecomment-320473246
>>> I know, some comments are from me but none of them worked, therefore on
>>> LKML :-)
>> I see, maybe you could have started there, that would have saved me a
>> trip to github to find out the thread.
>>
>>> /boot/config-4.16.7-100.fc26.armv7hl:CONFIG_BRIDGE_VLAN_FILTERING=y
>>>
>>> so this can't be the issue, any further ideas?
>> Yes, remove the "self" from your bridge vlan commands, I don't see that
>> being necessary.
> 
> Same:
> [root@bpi ~]# bridge vlan add dev lan1 vid 101 pvid untagged self
> RTNETLINK answers: Operation not supported
> [root@bpi ~]# bridge vlan add dev lan1 vid 101 pvid untagged
> RTNETLINK answers: Operation not supported
> [root@bpi ~]# bridge vlan add dev lan1 vid 101
> RTNETLINK answers: Operation not supported
> 
> Any ideas how to debug further?

Not particularly no, you would have to trace through the code where this
is failing, strace might give a first level of clue.

> 
>>
>>> On my 2nd Banana Pi-R1 still on Fedora 25 with kernel
>>> 4.12.8-200.fc25.armv7hl the commands still work well, but I wanted to
>>> test the upgrade on another one.
>>>
>>> /boot/config-4.12.8-200.fc25.armv7hl:CONFIG_BRIDGE_VLAN_FILTERING=y
>> Is using an upstream or compiled by yourself kernel an option at all? I
>> have no clue what is in a distribution kernel.
> 
> Typically the Fedora kernels work fine (long term experience since
> Fedora Core 1 from 2004 :-) ). I had some custom patches in there in the
> past for external RTC and b53_switch.kernel_4.5+.patch, but otherwise no
> topics. Therefore with upstream DSA support that should be fine then.
> 
> 
> Infos can be found here:
> 
> https://koji.fedoraproject.org/koji/packageinfo?packageID=8
> 
> https://koji.fedoraproject.org/koji/buildinfo?buildID=1078638
> 
> 
> Ciao,
> 
> Gerhard
> 
> 


-- 
Florian
