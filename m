Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeEDHoP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:44:15 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:40021 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbeEDHoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:44:13 -0400
X-Google-Smtp-Source: AB8JxZoIU78z1aGu0wuDJhTJTf+2z3mfzAVryBnyWt1rS5L4LDL3ImNTFjwZMsbH8K2hVPn33lualwS6i8waHnsUQck=
MIME-Version: 1.0
In-Reply-To: <1524828105-26585-2-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20180427112227epcas2p4ea3a93a5680d69a62f12cac627ebafbc@epcas2p4.samsung.com>
 <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com> <1524828105-26585-2-git-send-email-b.zolnierkie@samsung.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 May 2018 09:44:11 +0200
X-Google-Sender-Auth: VgsqiYoZHnuZGs5cyJn2HtFlbMU
Message-ID: <CAMuHMdWY_rwtG2vTy5R_P=37vk59+D+7ro+MgobPnEm1nJ_YXQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] video: fbdev: sh_mobile_lcdcfb: remove unused MERAM support
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Simon Horman <horms+renesas@verge.net.au>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 1:21 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Since commit a521422ea4ae  ("ARM: shmobile: mackerel: Remove Legacy C
> board code") MERAM functionality is unused. Remove it.
>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
