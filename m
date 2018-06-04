Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeFDLqI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:46:08 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:40026 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbeFDLqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:46:06 -0400
X-Google-Smtp-Source: ADUXVKL45BdywzQkCJdxlyiPsTiLtEheggsqQgylC1uuKx8PY4fHY3owJtZzl4ECGYRl+p1bTE/xRkvOKrXvqYecBw4=
MIME-Version: 1.0
In-Reply-To: <7ce9a8c3996506ae6f9ab16b3cf73c287e205a89.1527909627.git.fthain@telegraphics.com.au>
References: <cover.1527909627.git.fthain@telegraphics.com.au>
 <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
 <7ce9a8c3996506ae6f9ab16b3cf73c287e205a89.1527909627.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Jun 2018 13:46:04 +0200
X-Google-Sender-Auth: rEtO8zFf6sjLwJfCFWDRauevi8g
Message-ID: <CAMuHMdUzDqSvVxjOPWK=TSSsNo4Ej3_5TRbv+vRLU5ukSGvxdw@mail.gmail.com>
Subject: Re: [PATCH 02/11] macintosh/via-pmu: Add missing mmio accessors
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 2, 2018 at 5:27 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Add missing in_8() accessors to init_pmu() and pmu_sr_intr().
>
> This fixes several sparse warnings:
> drivers/macintosh/via-pmu.c:536:29: warning: dereference of noderef expression
> drivers/macintosh/via-pmu.c:537:33: warning: dereference of noderef expression
> drivers/macintosh/via-pmu.c:1455:17: warning: dereference of noderef expression
> drivers/macintosh/via-pmu.c:1456:69: warning: dereference of noderef expression
>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
