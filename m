Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeBGJ2y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:28:54 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:23269 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753314AbeBGJ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:28:52 -0500
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 07 Feb 2018 10:28:50 +0100
X-ME-IP: 86.201.132.185
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        alsa-devel@alsa-project.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        tfiga@chromium.org, paul.burton@mips.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Linus Walleij <linus.walleij@linaro.org>, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, Tony Lindgren <tony@atomide.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 00/20] Remove references to undefined symbols and fix two potential bugs
References: <20180205012146.23981-1-ulfalizer@gmail.com>
        <CAFkk2KRafUf3ki2R7B1pE_wzYkYn-OdeqLnvL0kScSxdzDMEXw@mail.gmail.com>
X-URL: http://belgarath.falguerolles.org/
Date: Wed, 07 Feb 2018 10:28:11 +0100
In-Reply-To: <CAFkk2KRafUf3ki2R7B1pE_wzYkYn-OdeqLnvL0kScSxdzDMEXw@mail.gmail.com>
        (Ulf Magnusson's message of "Mon, 5 Feb 2018 03:08:24 +0100")
Message-ID: <87lgg587ys.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf Magnusson <ulfalizer@gmail.com> writes:

> The symbol AC97_BUS_NEW in sound/ac97/Kconfig selects the globally
> undefined symbol AC97.
>
> It doesn't seem to simply be a misspelling of AC97_BUS, because then
> the dependencies of AC97_BUS_COMPAT would be impossible to satisfy.
You're correct.

I don't know what happened to me when coding this, but you can safely remove
this useless select statement.

Cheers.

-- 
Robert
