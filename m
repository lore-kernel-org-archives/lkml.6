Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756547AbeEAS1N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:27:13 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:52652 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756295AbeEAS1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:27:11 -0400
X-Google-Smtp-Source: AB8JxZo+2NlB0QMk0OcMgb2Tk/s2kYbfzxZDkCjcGzlivcb0Nvi7ehUmVGX1r1VqHHJO1PK1oQXILw==
Subject: Re: [RFC net-next 0/5] Support for PHY test modes
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        rmk@armlinux.org.uk, linux-kernel@vger.kernel.org, cphealy@gmail.com,
        nikita.yoush@cogentembedded.com, vivien.didelot@savoirfairelinux.com,
        Nisar.Sayed@microchip.com, UNGLinuxDriver@microchip.com
References: <20180428003237.1536-1-f.fainelli@gmail.com>
 <20180429.225554.2165914401649980919.davem@davemloft.net>
 <eea70076-891c-5caa-a590-ef1b0421f3b2@gmail.com>
 <20180430232448.GB25602@lunn.ch>
 <19a6bf90-03d5-aa63-5f35-3b26801b79a9@gmail.com>
 <20180501174752.GA1265@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <cd910177-bff9-261a-78e7-aa0a2c6532b5@gmail.com>
Date: Tue, 1 May 2018 11:27:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501174752.GA1265@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2018 10:47 AM, Andrew Lunn wrote:
> On Tue, May 01, 2018 at 10:21:54AM -0700, Florian Fainelli wrote:
>> On 04/30/2018 04:24 PM, Andrew Lunn wrote:
>>>> Turning these tests on will typically result in the link partner
>>>> dropping the link with us, and the interface will be non-functional as
>>>> far as the data path is concerned (similar to an isolation mode). This
>>>> might warrant properly reporting that to user-space through e.g: a
>>>> private IFF_* value maybe?
>>>
>>> Hi Florian
>>>
>>> I think a IFF_* value would be a good idea. We want to give the user
>>> some indicate why they don't have working networking. ip link show
>>> showing PHY-TEST-MODE would help.
>>
>> IF_OPER_TESTING as defined in RFC 2863 looks like the correct way to
>> signal that. I did a quick test and setting operstate to
>> IFF_OPER_TESTING seems to correctly get reflected by iproute2/ifconfig
>> which no longer see RUNNING though the interface is still UP.
> 
> Hi Florian
> 
> I should really play with this.... but is the opstate printed by ip
> link show? Not showing RUNNING is not the best hint something else is
> going on. Actually saying TESTING somewhere is much clearer.

The operstate is settable and gettable from iproute2:

# ip link show gphy
4: gphy@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
switchid 00000000 state UP mode DEFAULT group default qlen 1000

# ip link set gphy state testing

Although the kernel refuses to allow user space to set it to something
different from up or down AFAICT. With my local hack to allow setting
operstate from user-space through sysfs, we do see that iproute2
correctly show it:

# echo 4 > /sys/class/net/gphy/operstate
# ip link show gphy
4: gphy@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
qdisc noqueue switchid 00000000 state TESTING mode DEFAULT group default
qlen 1000
    link/ether 00:10:18:de:38:1f brd ff:ff:ff:ff:ff:ff

but not from ifconfig. I was not too keen on adding a new IFF_* flag
because it usually means there was nothing else that could be done, and
it is disruptive to include/uapi/linux/if.h which I am afraid to break
(especially for non glibc systems).

Do you think that is acceptable? There are lots of things ifconfig can't
report, but at least, the state of the interface would not be "UP".
-- 
Florian
