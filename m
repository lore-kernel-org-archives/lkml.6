Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933616AbeCGPVL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:21:11 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:40366 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933335AbeCGPVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:21:06 -0500
X-Google-Smtp-Source: AG47ELttOJgRqwH2DzYUBTjudGfcXHWwZbgOSa9t78pVNYnyoBTp2eC53+OGUIRHWnjSHqrvJ9ArchJe4F4iMJuHnJ4=
MIME-Version: 1.0
In-Reply-To: <1520432391.3731.8.camel@flygoat.com>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
 <20170927151527.25570-4-prasannatsmkumar@gmail.com> <20180306000832.GL4197@saruman>
 <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com> <1520432391.3731.8.camel@flygoat.com>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Wed, 7 Mar 2018 20:51:04 +0530
Message-ID: <CANc+2y5t9PLHJTF0RvoVOTy0DpWtb++ARFT=5KuJOd-1Da+ASQ@mail.gmail.com>
Subject: Re: [RFC 3/4] MIPS: Ingenic: Initial X1000 SoC support
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w27FLGo0029875

Hi Jiaxun,

On 7 March 2018 at 19:49, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> 在 2018-03-07三的 19:14 +0530，PrasannaKumar Muralidharan写道：
>>
>> I used to get my code tested from Domink but I could not reach him
>> for
>> quite some time. Before buying the development board myself I would
>> like to see if anyone can help me in testing. Do you have any contact
>> with Ingenic who can help in testing this?
>>
>
> Hi PrasannaKumar
>
> I'm resently working on Ingenic chips too. Ingentic guys have sent me a
> X1000 development broad and it will arrive in about two weeks. I have a
> ejtag debugger also (but not very suit with X1000 because X1000 have
> different ejtag interface with standard MIPS cores, maybe we need some
> modification on openocd). So maybe I can help in testing this after I
> get my broad. Just ask if you need any help.
> Thanks
> --
> Jiaxun Yang <jiaxun.yang@flygoat.com>

Really nice to hear. I will ask for help once I make changes.

Thanks,
PrasannaKumar
