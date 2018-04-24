Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbeDXOtG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:49:06 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41128 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeDXOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:49:02 -0400
X-Google-Smtp-Source: AIpwx48mjBBv8SzygV9Kdz185N8QI62JbGUu4HS8n+Rd0u6IAA5oQQibL5huI7GKo8QnbAAaecR+jjoRzirLBc+RRl0=
MIME-Version: 1.0
In-Reply-To: <20180424131720.4357-1-luc.vanoostenryck@gmail.com>
References: <20180424131720.4357-1-luc.vanoostenryck@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Apr 2018 16:49:01 +0200
X-Google-Sender-Auth: ExLuMAO9breG8hGx1IX-cxVsFVg
Message-ID: <CAMuHMdWvvMyEN_sek1e4QxCVZbSZ4X27RqH7XampcH97t=mvwg@mail.gmail.com>
Subject: Re: [PATCH] net: sh-eth: fix sh_eth_start_xmit()'s return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        netdev <netdev@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 3:17 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
>
> Fix this by returning 'netdev_tx_t' in this driver too.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
