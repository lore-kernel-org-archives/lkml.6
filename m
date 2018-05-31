Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754932AbeEaLv3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:51:29 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34379 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754882AbeEaLvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:51:23 -0400
X-Google-Smtp-Source: ADUXVKLHiAmnTHHPhvLUvx6HjwZe9ouyjcIPEsKtsopLAlwOBTwYMqxvanq7e/XaRVDN5M5MxX65zdEsqivB4OjueQE=
MIME-Version: 1.0
X-Originating-IP: [31.168.164.210]
In-Reply-To: <20180529161248.fphjnceozoyxqy7v@verge.net.au>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <1527171551-21979-2-git-send-email-gilad@benyossef.com> <20180529161248.fphjnceozoyxqy7v@verge.net.au>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Thu, 31 May 2018 14:51:22 +0300
Message-ID: <CAOtvUMfoyuaGac29WUYqvfRr1S7Fof3FgMZo_3K7EaozqbeT6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] crypto: ccree: correct host regs offset
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, stable@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 7:12 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, May 24, 2018 at 03:19:06PM +0100, Gilad Ben-Yossef wrote:
>> The product signature and HW revision register have different offset on the
>> older HW revisions.
>> This fixes the problem of the driver failing sanity check on silicon
>> despite working on the FPGA emulation systems.
>>
>> Fixes: 27b3b22dd98c ("crypto: ccree - add support for older HW revs")
>
> Did the above introduce a regression that is fixed by this patch
> or did it add a feature that only works with this patch?
>

Sort of in between - the first patch made more devices work but
unreliability (it will sometime work, sometime doesn't).
This one make it work reliably.

> In the case of the latter I would drop the Fixes tag,
> but I don't feel strongly about it.
>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
> Minor not below not withstanding,
>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thank you for the review and help :-)

Gilad

-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
