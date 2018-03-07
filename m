Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754715AbeCGPFH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:05:07 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:54792 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754582AbeCGPFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:05:02 -0500
X-Google-Smtp-Source: AG47ELv88H4DzV5gtJ2zKIVGpdMpqbobLIpaJnWzLscBH+7m1gXnXTmlIKi1xXEVMkp80047jqEas26C//f6qPFGMaI=
MIME-Version: 1.0
In-Reply-To: <20180307143541.GN4197@saruman>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
 <20170927151527.25570-4-prasannatsmkumar@gmail.com> <20180306000832.GL4197@saruman>
 <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com> <20180307143541.GN4197@saruman>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Wed, 7 Mar 2018 20:35:00 +0530
Message-ID: <CANc+2y5wsvGWszu3pePYhs2wb1_AgPdjG+ugfOCzbZVfVHDMvw@mail.gmail.com>
Subject: Re: [RFC 3/4] MIPS: Ingenic: Initial X1000 SoC support
To: James Hogan <jhogan@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Dominik Peklo <dom.peklo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7 March 2018 at 20:05, James Hogan <jhogan@kernel.org> wrote:
> On Wed, Mar 07, 2018 at 07:14:49PM +0530, PrasannaKumar Muralidharan wrote:
>> > Does X1000 use a different PRID, or is it basically just a JZ4780 core
>> > with different SoC peripherals?
>>
>> Yes X1000 does have a different PRID (PRID = 0x2ed1024f). X1000 has
>
> Right, so thats 0x2e000000 | PRID_COMP_INGENIC_D1 | PRID_IMP_JZRISC |
> 0x4f, which cpu-probe.c already handles (apparently the D1 company code
> is used for JZ4770 & JZ4775 too).

Okay. Does this mean I need not modify get_board_mach_type() and
get_system_type()?

>> I used to get my code tested from Domink but I could not reach him for
>> quite some time. Before buying the development board myself I would
>> like to see if anyone can help me in testing. Do you have any contact
>> with Ingenic who can help in testing this?
>
> Not personally, but I'll ask around. Of course if nobody much cares
> about it in practice and nobody has the hardware, there may be little
> value in supporting it upstream.

Seems Jiaxun is interested in the board and is willing to help.

I have been told that Ingenic is focusing on IoT market and X1000 is
intended for IoT segment. I think that they would be selling several
100Ks of chip over the coming years. But I feel Ingenic spends time
only on maintaining their Linux port which is usually based on very
old kernel version.

> Cheers
> James

Thanks and regards,
PrasannaKumar
