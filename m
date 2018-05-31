Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754809AbeEaLzL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:55:11 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39379 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754674AbeEaLzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:55:07 -0400
X-Google-Smtp-Source: ADUXVKLmjx8vaXlSU19DzS6Vl+OYB298UubM8HUt7a+S2248kVqd2SUr3wBqDTfnxQcnjqeuhH35/IJg1CkTNGCz5qs=
MIME-Version: 1.0
X-Originating-IP: [31.168.164.210]
In-Reply-To: <20180529161936.prhp4oikzamr6u3n@verge.net.au>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <1527171551-21979-6-git-send-email-gilad@benyossef.com> <20180529161936.prhp4oikzamr6u3n@verge.net.au>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Thu, 31 May 2018 14:55:06 +0300
Message-ID: <CAOtvUMeBCH+23c3FDWncMwPPe5N=7yjRKzhyLmFXrYazgGbcJw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: renesas: r8a7795: add ccree binding
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
        Ofir Drang <ofir.drang@arm.com>,
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

On Tue, May 29, 2018 at 7:19 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, May 24, 2018 at 03:19:10PM +0100, Gilad Ben-Yossef wrote:
>> Add bindings for CryptoCell instance in the SoC.
>>
>> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
> In so far as I can review the details of this (which is not much) this
> looks fine to me. I am, however, a little unclear in when it should be
> accepted.

Since Herbert Xu ACKed the driver changes, I would say the only gating
commit is Geert's CR clock patch.
If that one is in, than I would say this one should go in as well.

Thanks,
Gilad

-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
