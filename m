Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754567AbeDTKHs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:07:48 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:38941 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754375AbeDTKHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:07:46 -0400
X-Google-Smtp-Source: AIpwx4/QcjWdu7pgXl9M9/Q2OF8U6wOodhk+DrYLmFFQV5S8EuoIZEMD6SonO85KYGOd3lqI8CuZijXxUZkflOzl1tg=
MIME-Version: 1.0
In-Reply-To: <1524215874-15093-2-git-send-email-pierre-yves.mordret@st.com>
References: <1524215874-15093-1-git-send-email-pierre-yves.mordret@st.com> <1524215874-15093-2-git-send-email-pierre-yves.mordret@st.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Apr 2018 12:07:44 +0200
X-Google-Sender-Auth: H04hCWeIHHtksaDg-IYsfE9kcko
Message-ID: <CAMuHMdWwmsOm_LjjhYBFseFa1HaWFCbGEGf+XbZxSSf3JC=vPQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] ARM: configs: multi_v7: Add I2C support
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre-Yves,

On Fri, Apr 20, 2018 at 11:17 AM, Pierre-Yves MORDRET
<pierre-yves.mordret@st.com> wrote:
> This patch adds I2C F7 support to multi_v7_defconfig
>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Thanks for your patch!

I think the subject should be "ARM: multi_v7_defconfig: Add STM32F7
I2C support",
as generic I2C support is already enabled.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
