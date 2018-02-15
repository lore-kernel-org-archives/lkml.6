Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756446AbeBOWua (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 17:50:30 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:47040 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756397AbeBOWu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 17:50:28 -0500
X-Google-Smtp-Source: AH8x227sCWKni2a2MGxFeqeqlbvge13dCGcMG4us6wWDG/pTSPfW3+P3zkZo2GndeNj7A/k/BeA/alwCEXqBAvrtbKQ=
MIME-Version: 1.0
In-Reply-To: <1518702115-22990-2-git-send-email-tali.perry1@gmail.com>
References: <1518702115-22990-1-git-send-email-tali.perry1@gmail.com> <1518702115-22990-2-git-send-email-tali.perry1@gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 15 Feb 2018 14:50:26 -0800
Message-ID: <CAFd5g44BZjZtCoOurtvwn6TuPzYPt6hN4+8CaSfdmU1E3qAXBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] npcm750: add fixed clocks (moved from drivers/clk/clk-npcm7xx.c)
To: Tali Perry <tali.perry1@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Nancy Yuen <yuenn@google.com>, Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 5:41 AM, Tali Perry <tali.perry1@gmail.com> wrote:
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
>

First off, this patchset should probably be combined with "[PATCH v2 0/1] clk:
npcm: add NPCM7xx clock driver":
https://www.spinics.net/lists/devicetree/msg215082.html

> ---
>  arch/arm/boot/dts/nuvoton-npcm750.dtsi | 1223 ++++++++++++++++++++++++++++++++
>  1 file changed, 1223 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nuvoton-npcm750.dtsi
>
> diff --git a/arch/arm/boot/dts/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
> new file mode 100644
> index 000000000000..107d901c06f2
> --- /dev/null
> +++ b/arch/arm/boot/dts/nuvoton-npcm750.dtsi

This file is already added in "[PATCH v10 2/3] arm: dts: add Nuvoton NPCM750
device tree": https://www.spinics.net/lists/arm-kernel/msg634281.html . You
should base this patchset on that patchset since this depends on it.

> @@ -0,0 +1,1223 @@
> +/*
> + * DTSi file for the NPCM750 SoC
> + *
> + * Copyright (c) 2014-2017 Nuvoton Technology corporation.
> + *
> + * Released under the GPLv2 only.
> + * SPDX-License-Identifier: GPL-2.0
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
<snip>

Cheers
