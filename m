Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbeBJHhF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 02:37:05 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37850 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeBJHhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 02:37:03 -0500
X-Google-Smtp-Source: AH8x226OOyZxUCJlt+mhRbtiWCpMOYdPPc8uWXWknE3uclHY+vlQEK9tOjP16LEFaoy4f7himtbsJvH0P3Ahn7kkJqM=
MIME-Version: 1.0
In-Reply-To: <20180210024120.27503-2-manivannan.sadhasivam@linaro.org>
References: <20180210024120.27503-1-manivannan.sadhasivam@linaro.org> <20180210024120.27503-2-manivannan.sadhasivam@linaro.org>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Sat, 10 Feb 2018 08:36:21 +0100
Message-ID: <CAOFm3uFU9KPZqvRucm8U0ruy6ZZ6AoN55ELCdzp6+sqA6i_SaQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] dt-bindings: clock: Add Actions S900 clock bindings
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, LKML <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Manivannan,

On Sat, Feb 10, 2018 at 3:41 AM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add Actions Semi S900 clock bindings.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

<snip>

> diff --git a/include/dt-bindings/clock/actions,s900-cmu.h b/include/dt-bindings/clock/actions,s900-cmu.h
> new file mode 100644
> index 000000000000..2fa94e19922b
> --- /dev/null
> +++ b/include/dt-bindings/clock/actions,s900-cmu.h
> @@ -0,0 +1,139 @@
> +/*
> + * Device Tree binding constants for Actions S900 Clock Management Unit
> + *
> + * Copyright (c) 2014 Actions Semi Inc.
> + * Copyright (c) 2017 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */

Would you consider using the new SPDX license ids rather that this
time-tested but rather boring legalese?

The (still new and fresh) license documentation contributed by tglx
--the only maintainer that I know that understands both the innards of
Spectre and Meltdown and the beauty of reStructuredText -- is in:
Documentation/process/license-rules.rst

Practically this means replacing the above by a simple single line and
getting rid of a whopping 8 comment lines!

SPDX-License-Identifier: GPL-2.0+

You get to save a few tree as a bonus if you also do the same for all
Linaro-copyrighted files. Yes this is saving trees because I will use
less paper each time I print a listing of the kernel source code.
Which is something that I rarely if ever do: but somebody must do it
somewhere for sure.

If I do the math: we have ~60K files in the kernel, and say we can
remove roughly 5 lines of legalese per file on average. Each printed
source code page is roughly 60 lines : this will mean a saving of
about 6000 paper sheets saved on each printout! A letter-size paper
ream is 500 pages, about 2.5 Kg and costs about ~$8.  You can extract
about 10K to 20k sheets of paper per tree [1].
Therefore my Fermi estimate is that using shorter legalese in the
kernel will eventually save roughly ONE FULL smaller tree (6K pages)
each time someone prints the kernel code: incredible, right?

Thank  you for helping make the kernel a mostly legalese-free codebase
and saving trees at the same time!

[1] https://www.sierraclub.org/sierra/2014-4-july-august/green-life/how-much-paper-does-one-tree-produce
-- 
Cordially
Philippe Ombredanne
