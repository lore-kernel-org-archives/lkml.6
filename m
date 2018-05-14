Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeENV1G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:27:06 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36171 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752556AbeENVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:25:47 -0400
X-Google-Smtp-Source: AB8JxZrV0J2jRl0c5HQjvEPIUOwh1n+Ncz46Tm8nSuILF3/rudzU7d4m6waoziypVNCzbPPuCi82N128Hes5arbg3S0=
MIME-Version: 1.0
In-Reply-To: <20180511162028.20616-7-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl> <20180511162028.20616-7-brgl@bgdev.pl>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 23:25:46 +0200
X-Google-Sender-Auth: i7f9TGZwcvA2m-WasAJwJAMw0Fk
Message-ID: <CAMuHMdWbmdGWz_h_77iHX6=ooadOHsiCMo1-iH33qw-4wZO4CQ@mail.gmail.com>
Subject: Re: [PATCH 06/12] of: add a new flag for OF device nodes
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 6:20 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This flag indicates that a device node has been populated early and
> that it needs different handling when called from
> of_platform_populate().
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
