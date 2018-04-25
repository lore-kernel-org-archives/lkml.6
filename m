Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeDYDTr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 23:19:47 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37043 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeDYDTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 23:19:43 -0400
X-Google-Smtp-Source: AB8JxZqTYqVTXw44uTSKEoQQBZUwnv1zi/Y7cd8ZNChL6LWD5O0EDTr1BgNpG6BdgIHeILEgSM53eg==
MIME-Version: 1.0
In-Reply-To: <20180424193754.jsuucbq57onhxhqe@flea>
References: <20180424113424.13196-1-wens@csie.org> <20180424113424.13196-3-wens@csie.org>
 <20180424121353.zxujyehsw3er2xq6@flea> <CAGb2v65iwbmOvQ2YA0e4QyTzQVj=F+5n6cWt2q6K80Y2b_3q3g@mail.gmail.com>
 <20180424193754.jsuucbq57onhxhqe@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 25 Apr 2018 11:19:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v64MwS+q87z9_UiKxVtgeAenA_9+QSS=cfF42PGy4PeJwQ@mail.gmail.com>
Message-ID: <CAGb2v64MwS+q87z9_UiKxVtgeAenA_9+QSS=cfF42PGy4PeJwQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] ARM: dts: sun8i: h3: Split out common board design
 for ALL-H3-CC
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 3:37 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Tue, Apr 24, 2018 at 08:17:11PM +0800, Chen-Yu Tsai wrote:
>> On Tue, Apr 24, 2018 at 8:13 PM, Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>> > On Tue, Apr 24, 2018 at 07:34:19PM +0800, Chen-Yu Tsai wrote:
>> >> The Libre Computer Project ALL-H3-CC has three models, all using the
>> >> same board design, but with different pin compatible SoCs and amount of
>> >> DRAM.
>> >>
>> >> Currently only the H3 1GB DRAM variant is supported. To support the two
>> >> other variants, first split the original device tree into a common board
>> >> design part and an SoC specific part.
>> >>
>> >> The SoC part only defines which SoC is used and model name, and includes
>> >> the SoC specific dtsi file and the common design dtsi file.
>> >>
>> >> Also fix up the SPDX identifier line to use the correct comment style,
>> >> and place it on the first line.
>> >>
>> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> >> ---
>> >>  .../boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 213 +-----------------
>> >>  ....dts => sunxi-hx-libretech-all-h3-cc.dtsi} |  11 +-
>> >
>> > I think I prefer the name of Neil's DTSI better, and since pretty much
>> > the same patches (a couple of hours) before, we'll merge them (while
>> > merging the rest of your patches, obviously).
>> >
>> > Does that work for you?
>>
>> I would like for the regulator voltage fix to be merged before the split.
>> This will make it trivial to back port, instead of having to reverse the
>> split, and maybe failing.
>
> Yes, I was just talking about replacing your two redundant patches,
> but keeping the order you have.

That works for me. Might require a little fixing up.
Let me know if you need help with that.

ChenYu
