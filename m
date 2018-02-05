Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeBEE7I (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 23:59:08 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39943 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbeBEE7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 23:59:00 -0500
X-Google-Smtp-Source: AH8x227igbR8Q0BeTXDKjFUVyp3hg9QbuOSYlt/29wOl+ikKH/y806QDsEqyIixrsasuGszZwBpi+yhSgYMD4JwO6V8=
MIME-Version: 1.0
In-Reply-To: <20180205044821.3zvs7cfhdr3eu2qa@oak.ozlabs.ibm.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-3-ulfalizer@gmail.com>
 <20180205044821.3zvs7cfhdr3eu2qa@oak.ozlabs.ibm.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 5 Feb 2018 05:58:59 +0100
Message-ID: <CAFkk2KRQRx9kQLk1eCgLzogern240FOKW=OEJAFPNUAgtf4fEg@mail.gmail.com>
Subject: Re: [PATCH 02/20] KVM: PPC: Book3S PR: Fix broken select due to misspelling
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        tfiga@chromium.org, paul.burton@mips.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Linus Walleij <linus.walleij@linaro.org>, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, will.deacon@arm.com,
        Tony Lindgren <tony@atomide.com>, Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 5:48 AM, Paul Mackerras <paulus@ozlabs.org> wrote:
> On Mon, Feb 05, 2018 at 02:21:14AM +0100, Ulf Magnusson wrote:
>> Commit 76d837a4c0f9 ("KVM: PPC: Book3S PR: Don't include SPAPR TCE code
>> on non-pseries platforms") added a reference to the globally undefined
>> symbol PPC_SERIES. Looking at the rest of the commit, PPC_PSERIES was
>> probably intended.
>>
>> Change PPC_SERIES to PPC_PSERIES.
>>
>> Discovered with the
>> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
>> script.
>>
>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>
> Acked-by: Paul Mackerras <paulus@ozlabs.org>
>
> Which tree is this series going into?
>
> Paul.

I didn't have a particular one in mind. I imagined people would pick
up individual patches into the trees that make the most sense. It was
easiest to do the undefined symbol removal as a kernel-wide batch job.

All patches are against linux-next.

Cheers,
Ulf
