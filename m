Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeEQMyU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:54:20 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:36355 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeEQMyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:54:18 -0400
X-Google-Smtp-Source: AB8JxZo18KmKwyHWijs6t7QgBm3B/7FHu8zPFogsIAsUDvsvjnwHM5IYmcKEMxAH28q2+0R78TYGmI2b7QTJDGDPmBU=
MIME-Version: 1.0
X-Originating-IP: [217.140.96.140]
In-Reply-To: <1526387370-17142-2-git-send-email-gilad@benyossef.com>
References: <1526387370-17142-1-git-send-email-gilad@benyossef.com> <1526387370-17142-2-git-send-email-gilad@benyossef.com>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Thu, 17 May 2018 15:54:17 +0300
Message-ID: <CAOtvUMcN2kYFQEiMc7ignecPTdt9yOnfs2=TDjRnMAJ9WNRbuQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] crypto: ccree: drop signature register check
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: Ofir Drang <ofir.drang@arm.com>,
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

Herbert,

On Tue, May 15, 2018 at 3:29 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> We were using the content of the signature register as a sanity
> check for the hardware functioning but it turns out not all
> implementers use the same values so the check is giving false
> negative on certain SoCs and so we drop it.
>

Please drop this patch. I have found a better fix and will send a v2 soon.

Thanks,
Gilad


-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
