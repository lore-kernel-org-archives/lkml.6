Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933247AbeBMCIr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 21:08:47 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36235 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933148AbeBMCIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 21:08:46 -0500
X-Google-Smtp-Source: AH8x227jm5YyXFrin28zzGWYzrAjh9/EtAW4yKoDiua1l0ijN0Sg0lnDtcQ1jMdzx29DGOoK1/C81rsd/3V3ob0zaD0=
MIME-Version: 1.0
In-Reply-To: <CACPK8XcGhxTq7QGeub2rAEtGSyrOmnobspVJfhE5YmB6MQRM9w@mail.gmail.com>
References: <20180212205833.151019-1-brendanhiggins@google.com>
 <20180212205833.151019-2-brendanhiggins@google.com> <CACPK8XcGhxTq7QGeub2rAEtGSyrOmnobspVJfhE5YmB6MQRM9w@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 12 Feb 2018 18:08:45 -0800
Message-ID: <CAFd5g46EVEQmETawUagDLzySLTFQqc2aM4kFJvvHMU_dvP5V3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] arm: npcm: add low-level debug support for NPCM7XX
To: Joel Stanley <joel@jms.id.au>
Cc: Jeremy Kerr <jk@ozlabs.org>, Russell King <linux@armlinux.org.uk>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 5:59 PM, Joel Stanley <joel@jms.id.au> wrote:
> Hi Brendan,
>
> On Tue, Feb 13, 2018 at 7:28 AM, Brendan Higgins
> <brendanhiggins@google.com> wrote:
>> Enable low-level debug support for Nuvoton NPCM7XX family by adding the
>> debug port definitions for the SoC.
>
> When playing with the Poleg boards at the recent OpenBMC hackathon
> Jeremy discovered that the UART is a normal-ish 8250, with a custom
> divisor and a few extra bits to be set.
>
> I found that we can us the generic 8250 low level debugging support
> just fine. This is because u-boot sets up the divisor settings for us
> (as you've assumed with your version here), and from there it's just
> reading/writing characters.
>
> Assuming you can reproduce our results, I suggest we drop these
> patches in favour of adding the correct configuration the Poleg.
>

Sounds good to me. I trust that if you were able to get the 8250 driver
working on the Poleg that it does indeed work.

We can talk about configuring it off the Linux mailing lists.

<snip>

Thanks!
