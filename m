Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbeCNIVs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:21:48 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:37111 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753057AbeCNIVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:21:45 -0400
X-Google-Smtp-Source: AG47ELt6c/7JmPurvX0qHfd2UiZYk85/SurXT54QqTxHfE4YHvMq7nkYirtesNXtirgCB7nnjym3Cf87Zd0P73L2CsA=
MIME-Version: 1.0
In-Reply-To: <30abb41033b9670c06a54ff484d61d25d3c6e5cd.1520963956.git-series.kieran.bingham+renesas@ideasonboard.com>
References: <cover.89a4a5175efbf31441ba717a99b0e3c31088179f.1520963956.git-series.kieran.bingham+renesas@ideasonboard.com>
 <30abb41033b9670c06a54ff484d61d25d3c6e5cd.1520963956.git-series.kieran.bingham+renesas@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Mar 2018 09:21:44 +0100
X-Google-Sender-Auth: 0JwPQGIGTPnFbasHXFuBOOEix1I
Message-ID: <CAMuHMdU2XR36gmyuprDFLn5riuST_Av+--cncdOnYdiDsT-9Yw@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] media: vsp1: Remove packed attributes from
 aligned structures
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 7:05 PM, Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
> The use of the packed attribute can cause a performance penalty for
> all accesses to the struct members, as the compiler will assume that the
> structure has the potential to have an unaligned base.
>
> These structures are all correctly aligned and contain no holes, thus
> the attribute is redundant and negatively impacts performance, so we
> remove the attributes entirely.
>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
