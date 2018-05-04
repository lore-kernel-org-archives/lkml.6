Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeEDHtm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:49:42 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35211 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEDHtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:49:41 -0400
X-Google-Smtp-Source: AB8JxZqrivJXBM4lXCXKk2elTrHSNW6IeBLDrfmflVRcVTg6+nNGLOcdkEj8VNHWPCFsQjnbeu18n0AOHmbgxw6xAnU=
MIME-Version: 1.0
In-Reply-To: <1524828105-26585-4-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20180427112241epcas1p423b20f397d034a444ec018f39241d82b@epcas1p4.samsung.com>
 <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com> <1524828105-26585-4-git-send-email-b.zolnierkie@samsung.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 May 2018 09:49:39 +0200
X-Google-Sender-Auth: IIgQurLoFzqFiv_gqMBk9ejWgEc
Message-ID: <CAMuHMdUEHosD=RyvQrBEjci1=DBH+2x9r9baX1d=0mx-sCc0qQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] video: fbdev: remove unused sh_mobile_meram driver
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
