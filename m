Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754863AbeDCFqi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 01:46:38 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:43036 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754807AbeDCFqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 01:46:36 -0400
X-Google-Smtp-Source: AIpwx4+hSznMYTzd6ISmf1/zAl7nHkIwWgIeuUhiWVnLyvBjhMNGl7aS/QvUGH4ybD0yCZj9zdm+p3KpAGBBGJxdHTg=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzwCiRrT5Ltfg0Uci7jXVRX2hw_fHp_srK_f7yacNKwwg@mail.gmail.com>
References: <20180402060123.GB12733@app09> <CA+55aFzwCiRrT5Ltfg0Uci7jXVRX2hw_fHp_srK_f7yacNKwwg@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Tue, 3 Apr 2018 13:45:55 +0800
Message-ID: <CAEbi=3c9Y4D+6cf+oYJJdTpzTWNbqw7tWBJsK7VOAnS9q2+K3A@mail.gmail.com>
Subject: Re: [GIT PULL] Andes(nds32) Port for Linux 4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime <greentime@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w335kiRf008949

2018-04-03 0:04 GMT+08:00 Linus Torvalds <torvalds@linux-foundation.org>:
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
>

Hi, Linus:

Andes nds32 architecture supports Linux for Andes's N10, D10, N13,
N15, D15 processor cores.

Based on the patented 16/32-bit AndeStar RISC-like architecture, we
designed the configurable AndesCore series of embedded processor
families. AndesCores range from highly performance-efficient
small-footprint cores for microcontrollers and deeply-embedded
applications to 1GHz+ cores running Linux, covering general-purpose
N-series cores for a wide range of computing need, DSP-capable
D-series cores for digital signal control, instruction-extensible
E-series cores for application-specific acceleration, and secure
S-series cores for best protection of the most valuable.

Our customers together have shipped over 2.5 billion SoC’s with Andes
processors embedded (including non-MMU IP cores). It will help our
customers to get better Linux support if we are merged into mainline.
