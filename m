Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeDCN6l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:58:41 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34389 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeDCN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:58:39 -0400
X-Google-Smtp-Source: AIpwx4852CKxWvfHmBjlKHwhBMsWXHstGxbxxRd7r8EMDTKrI5K3avZMNFWBxdZYuQuU1pZnFzn1l224bduI9W/avqc=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzwCiRrT5Ltfg0Uci7jXVRX2hw_fHp_srK_f7yacNKwwg@mail.gmail.com>
References: <20180402060123.GB12733@app09> <CA+55aFzwCiRrT5Ltfg0Uci7jXVRX2hw_fHp_srK_f7yacNKwwg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 3 Apr 2018 15:58:38 +0200
X-Google-Sender-Auth: D5fcJ3oZnAfp89LDHoKHDvqnVKw
Message-ID: <CAK8P3a1GRKneXEiHpnKt2bE-ez+zE=WB6sV=xmBccqFDT8noxw@mail.gmail.com>
Subject: Re: [GIT PULL] Andes(nds32) Port for Linux 4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greentime Hu <green.hu@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime <greentime@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 6:04 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Apr 1, 2018 at 11:01 PM, Greentime Hu <green.hu@gmail.com> wrote:
>>
>> This tag contains the core nds32 Linux port(including interrupt controller
>> driver and timer driver), which has been through 7 rounds of review on mailing
>> list.
>
> Can I get an overview of the nds32 architecture (uses, quirks, reasons
> for existing?) to add to the initial merge message? Just an overview,
> not some kind of architecture manual thing.
>
> Yeah, yeah, I can google it myself and write something up, but it's
> the kind of information I'd like to see when merging an architecture I
> hadn't really ever heard about, and I suspect most others haven't
> either.

The non-marketing description is that this is a fairly conventional
(in a good way) low-end RISC architecture that is usually integrated
into custom microcontroller and SoC designs, competing with
the similar ARM32, ARC, MIPS32, RISC-V, Xtensa and (currently
under review) C-Sky architectures that occupy the same space.

The most interesting bit from my perspective is that Andestech
are already selling a new generation of CPU cores that are
based on 32-bit and 64-bit RISC-V, but are still supporting enough
customers on the existing cores to invest in both.

     Arnd
