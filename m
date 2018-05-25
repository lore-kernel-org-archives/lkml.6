Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966547AbeEYMBb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:01:31 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43515 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966243AbeEYMB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:01:28 -0400
X-Google-Smtp-Source: ADUXVKK1wOH/Pl3KnKz6TcMLdi9GHmumf0fblNKxW3eWZ8leZdg22iljHqvb9fOYzfumAanxuVThwAJiwdqrO1isJyI=
MIME-Version: 1.0
In-Reply-To: <25d1c303-71d7-8c38-880f-7bb0e133a876@suse.de>
References: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org>
 <20180520051736.4842-6-manivannan.sadhasivam@linaro.org> <CACRpkdYF7a-uwye0uwn-pT9Bprj74q1-Pcbq4WLyiE+kYY4j7w@mail.gmail.com>
 <25d1c303-71d7-8c38-880f-7bb0e133a876@suse.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 May 2018 14:01:27 +0200
Message-ID: <CACRpkdYL6OWL7qeCRgS7Tw81oG8vUpi-kM+vOkudZHoiGizNRA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add Actions Semi S900 pinctrl entries
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, liuwei@actions-semi.com,
        96boards@ucrobotics.com,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        GPIO SUBSYSTEM <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        Jeff Chen <jeff.chen@actions-semi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4PC1dJJ018802

On Fri, May 25, 2018 at 6:12 AM, Andreas Färber <afaerber@suse.de> wrote:

> I fail to understand how splitting the MAINTAINERS section is going to
> help with the pinctrl conflict at hand?

OK let's keep it like it is then, one entry.

>The problem is that instead of
> refactoring my S500 pinctrl driver to his liking, Mani has submitted a
> competing S900 pinctrl driver that you went on to merge. The human
> aspect is that merging his driver took the credit away from me having
> written the earlier pinctrl driver (based on my rtd1295 pinctrl driver).
> The practical aspect is that I can't drop my pinctrl driver from my work
> branch until there is equivalent functionality in the merged driver. I
> am lacking the time to rewrite S500 pin definitions on top of Mani's
> myself at this time, and I haven't seen S500 patches from him yet.

I am sorry if you feel you are being treated unfairly.

I can't help to think about the old IT project motto "always
calculate to throw one version away". We are always going to
have a bit of collateral damage around out sometimes chaotic
and unstructured development process.

I haven't seen this S500 patch posted anywhere on the pin control
official mailing list. As subsystem maintainer I have a vast flow of
information already, actively polling around other subcommunities
is simply not possible for me.

I need to deal with what ends up on the list, I think it would have
been better if you simply posted your S500 driver at the time,
no matter the state. "Release early, release often" and discuss
design on the GPIO mailing list where I can see it, so I have some
idea what is going on here.

> Also I had been investing efforts in explaining the upstreaming process
> to Actions, last in November. I see Thomas Liau and Jeff Chen missing in
> CC and I have not seen any Reviewed-by or Acked-by from anyone at
> Actions on this and the preceding series. There are more chips than the
> one on Linaro's 96board, so I would prefer to assure that the design
> works for all. Thus I am very critical of you applying the patches
> without waiting for review by Actions.

It is not too late to take it out if there is some problem from their
side.

When I merge a driver it doesn't mean "definately approved, will
send to Torvalds", type of "seal of approval" it rather usually it
means "I want to test it in linux-next in due time for the merge
window".

I don't mind taking it out if there are problems, and I do not mind
even reverting it in the -rc phase if there are problems.
I don't mind having to revert patches like this or even rebasing
the tree if required.

However if they do not come back at all within some week or
two that is passivity and then it goes in.

> Other aspects are: The reason I wrote the pinctrl driver is that I
> experienced a UART TX issue on the Sparky board and was hoping a pinctrl
> driver might resolve that, but it didn't. So I still have a mix of
> boards where some are working and some are pretty unusable, without any
> clues on why.

Hm how typical :/

Getting to serial is paramount to getting anywhere with the
hacking. I see this becomes a bit of showstopper for your
development work here.

> That said, I don't object to having a separate MAINTAINERS section for
> the pinctrl driver(s) as long as I still get CC'ed on changes. We have
> wanted to add Mani as R for Actions overall, so that would probably mean
> adding me as R to an Actions pinctrl section, to avoid syncing the paths
> between two sections.

No problem we keep it to one entry.

> I had previously felt that it does not make sense
> to list Mani as co-maintainer (M) for Actions overall since he can't tag
> and submit from my repo. And for the record I have offered him to take
> over which he didn't want to. I still hope to find some more time to
> review and queue his SPS patches, a driver that I have designed and thus
> understand and am much happier about the incremental additions there.

OK nice!

> A further side note is that I had reached out about setting up an
> infradead mailing list linux-actions, but there was no response from
> David or anyone. Having an L on the section(s) would avoid messing with
> R and hand-maintained CC lists. Any help with that appreciated.

We can talk to kernel.org about setting up a list, that probably works
quicker.

Yours,
Linus Walleij
