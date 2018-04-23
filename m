Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754458AbeDWHZL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:25:11 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:44521 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754432AbeDWHZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:25:07 -0400
X-Google-Smtp-Source: AIpwx4/ut5fh4GX1b9a8xniXYFhSyFtI1IIcWW/mVpCzXCsQ5pXD04TsiwHEB0yXyN5jftPO5wznArnpDow6Yse+fc4=
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKVCdk8nFwmtfNt4mMOVYFVxefgafP6JtXThvFhROFB8w@mail.gmail.com>
References: <20180418222905.10414-1-robh@kernel.org> <e7a2f4ca-40c2-05ef-097c-2cecd31fb731@gmail.com>
 <CAL_JsqKVCdk8nFwmtfNt4mMOVYFVxefgafP6JtXThvFhROFB8w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Apr 2018 09:25:05 +0200
X-Google-Sender-Auth: x07oIi5vBlIx1_fdQExd95vtCko
Message-ID: <CAMuHMdVG542FbRgrEnSa6TeiDxXDxB3Fh1ZFd8UGB2c4UxZUcg@mail.gmail.com>
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
To: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        devicetree-spec@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Sat, Apr 21, 2018 at 3:28 AM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Apr 20, 2018 at 4:00 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> Others have already commented on a desire to have a way to specify that
>> number of interrupts should match number of interrupt-names.
>
> Yeah, but I don't see a way to do that. You could stick the array size
> constraints in a common definition and have a $ref to that definition
> from both, but that doesn't really save you too much.

As Bjorn said, this could be handled in the validation tool, for the myriad of
standard list properties that have an accompanying names property.

That avoids having to specify the relation in each and every binding document.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
