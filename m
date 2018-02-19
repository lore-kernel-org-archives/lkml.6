Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeBSRDh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:03:37 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33765 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbeBSRDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:03:34 -0500
X-Google-Smtp-Source: AH8x2240U2woO1ozIWTCWatlvMc5Itwv3jCY9USPxeqqYh87WEYGvle6OnIPbEkE+Zb5+5iHmsD4adqVn1RHX0IkmFk=
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKheTj_b5TjPJq1erjjeqHJDJQG5MyUi2qbHbFJkarfGg@mail.gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-11-ulfalizer@gmail.com>
 <CAL_JsqKheTj_b5TjPJq1erjjeqHJDJQG5MyUi2qbHbFJkarfGg@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 19 Feb 2018 18:03:32 +0100
Message-ID: <CAFkk2KR5eBfsXoZa-qty0neUKO0=3P82AVNb+SM37QOb7VMPDg@mail.gmail.com>
Subject: Re: [PATCH 10/20] lib/Kconfig: Remove leftover select of GENERIC_IO
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, Paul Burton <paul.burton@mips.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Hellwig <hch@lst.de>, Michal Nazarewicz <mina86@mina86.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Paul Mackerras <paulus@ozlabs.org>, Will Deacon <will.deacon@arm.com>,
        Tony Lindgren <tony@atomide.com>, Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Dave Airlie <airlied@redhat.com>,
        Jeremy Kerr <jk@ozlabs.org>, Bart Van Assche <bart.vanassche@wdc.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 4:48 PM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Feb 4, 2018 at 7:21 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>> GENERIC_IO was removed by commit 9de8da47742b ("kconfig: kill off
>> GENERIC_IO option"), but HAS_IOMEM still selects it.
>>
>> Remove the select of GENERIC_IO from HAS_IOMEM.
>>
>> Discovered with the
>> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
>> script.
>>
>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>> ---
>>  lib/Kconfig | 1 -
>>  1 file changed, 1 deletion(-)
>
> Who do you intend to apply this because people keep sending the same fix?
>
> Rob

I didn't have a particular tree in mind. I imagined people would pick
up patches into the trees where they make the most sense.

I just turned it into a patchset to keep track of it easier myself.
Looks like that might have caused some confusion in retrospect.

Cheers,
Ulf
