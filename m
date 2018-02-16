Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757468AbeBPJBh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:01:37 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35678 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757437AbeBPJBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:01:35 -0500
X-Google-Smtp-Source: AH8x2270nLR1/EbXq3RgfyfKXHx3Fon47OnNwXu/DXyuIIaIRzEbSyZ4EmOdQS56NeNyLcNbxNpja/2U8KI+WlmjF3U=
MIME-Version: 1.0
In-Reply-To: <20180215155638.kh6hxxo4tmit3jj4@verge.net.au>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-7-git-send-email-jacopo+renesas@jmondi.org>
 <20180215153948.puwztivx3zwtqxet@verge.net.au> <20180215155638.kh6hxxo4tmit3jj4@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2018 10:01:33 +0100
X-Google-Sender-Auth: K_dHUStCXqKMdVCDjNPc9HQK7XY
Message-ID: <CAMuHMdUPLPABkeefDE8+V4Bbs1GK9fBY0hzWU1_zAQ0o-3hTsg@mail.gmail.com>
Subject: Re: [PATCH 06/15] Documentation: devicetree: dma: Add r8a77965 dmac
To: Simon Horman <horms@verge.net.au>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 4:56 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Feb 15, 2018 at 04:39:49PM +0100, Simon Horman wrote:
>> On Tue, Feb 13, 2018 at 10:45:53AM +0100, Jacopo Mondi wrote:
>> > Add documentation for r8a77965 compatible string to rcar-dmac device
>> > tree bindings documentation.
>> >
>> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>
>> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>
> Sorry for not noticing this the first time around.
>
> I think a better subject would be:
>
> dt-bindings: dmaengine: rcar-dmac: document R8A77964 support

s/64/65/ ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
