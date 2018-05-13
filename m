Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeEMCm2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 22:42:28 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:44204 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeEMCmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 22:42:25 -0400
X-Google-Smtp-Source: AB8JxZqQ0KkuMTNNluTYn8G7xAz9R6H+cd6SNuDbz/mxsAOWz4TnfEbAYzY88+5SI2yoFu9UDcm6oQ==
MIME-Version: 1.0
In-Reply-To: <677E6987-24AE-4D7C-9BF2-6BE3F43212C7@holtmann.org>
References: <CAC=mGzijVyqEG=DXH4v9WkD0kXR2WOJC4KBPzoT7g5wqVrPGXA@mail.gmail.com>
 <677E6987-24AE-4D7C-9BF2-6BE3F43212C7@holtmann.org>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Sun, 13 May 2018 10:42:23 +0800
X-Gmail-Original-Message-ID: <CAC=mGzj-GNQ0Xz3PodDHyypNtFsOEfBdNBnNkysW2ZZ8Wwuijg@mail.gmail.com>
Message-ID: <CAC=mGzj-GNQ0Xz3PodDHyypNtFsOEfBdNBnNkysW2ZZ8Wwuijg@mail.gmail.com>
Subject: Re: [RFC] net: Add new LoRaWAN subsystem
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4D2gYbw016377

Hi Jiri and Marcel,

2018-05-11 23:39 GMT+08:00 Marcel Holtmann <marcel@holtmann.org>:
> Hi Jian-Hong,
>
>> A Low-Power Wide-Area Network (LPWAN) is a type of wireless
>> telecommunication wide area network designed to allow long range
>> communications at a low bit rate among things (connected objects), such
>> as sensors operated on a battery.  It can be used widely in IoT area.
>> LoRaWAN, which is one kind of implementation of LPWAN, is a medium
>> access control (MAC) layer protocol for managing communication between
>> LPWAN gateways and end-node devices, maintained by the LoRa Alliance.
>> LoRaWAN™ Specification could be downloaded at:
>> https://lora-alliance.org/lorawan-for-developers
>>
>> However, LoRaWAN is not implemented in Linux kernel right now, so I am
>> trying to develop it.  Here is my repository:
>> https://github.com/starnight/LoRa/tree/lorawan-ndo/LoRaWAN
>>
>> Because it is a kind of network, the ideal usage in an user space
>> program should be like "socket(PF_LORAWAN, SOCK_DGRAM, 0)" and with
>> other socket APIs.  Therefore, the definitions like AF_LORAWAN,
>> PF_LORAWAN ..., must be listed in the header files of glibc.
>> For the driver in kernel space, the definitions also must be listed in
>> the corresponding Linux socket header files.
>> Especially, both are for the testing programs.
>>
>> Back to the mentioned "LoRaWAN is not implemented in Linux kernel now".
>> Could or should we add the definitions into corresponding kernel header
>> files now, if LoRaWAN will be accepted as a subsystem in Linux?
>
> when you submit your LoRaWAN subsystem to netdev for review, include a patch that adds these new address family definitions. Just pick the next one available. There will be no pre-allocation of numbers until your work has been accepted upstream. Meaning, that the number might change if other address families get merged before yours. So you have to keep updating. glibc will eventually follow the number assigned by the kernel.

Thanks for your guidance.  I will follow the steps.

Thanks a lot,

Jian-Hong Pan

> Regards
>
> Marcel
>
