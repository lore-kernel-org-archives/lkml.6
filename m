Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbeDRJgg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:36:36 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:41147 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbeDRJg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:36:29 -0400
X-Google-Smtp-Source: AIpwx48obenp8ZZ7EYAslcH+k8FAZYnzzf3nH9//vd0A9a5SqW848RRIygSc9Uc9GobXtA3+GJxQlKnlqLiEpTDtlpE=
MIME-Version: 1.0
In-Reply-To: <20180416215032.5023-12-mylene.josserand@bootlin.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com> <20180416215032.5023-12-mylene.josserand@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Apr 2018 11:36:27 +0200
X-Google-Sender-Auth: Fl4ZwKgyX-asfmfyGFp1EL6tyYM
Message-ID: <CAMuHMdU9soQuNMC59Y2AQdTmXbWBz-P3EFfZ6NYGKukJVukKgg@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] ARM: shmobile: Convert file to use cntvoff
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>, quentin.schulz@bootlin.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3I9bBnN018020

Hi Mylène,

On Mon, Apr 16, 2018 at 11:50 PM, Mylène Josserand
<mylene.josserand@bootlin.com> wrote:
> Now that a common function is available for CNTVOFF's
> initialization, let's convert shmobile-apmu code to use
> this function.

Thanks for your patch, works fine on Renesas ALT with R-Car E2,
which suffers from lack of CNTVOFF initialization.

> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
