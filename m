Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeCUIHd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:07:33 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:40433 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbeCUIH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:07:29 -0400
X-Google-Smtp-Source: AG47ELu4w87d1BiZ70Tb44qQr5XJNzJ3C4LBk1b1MSzUAnc9gkn4GC9513BtYC5Hq2CZgV8xepPLDI4Kkf5EPHqU3FU=
MIME-Version: 1.0
In-Reply-To: <20180226130558.7634-9-rf@opensource.cirrus.com>
References: <20180226130558.7634-1-rf@opensource.cirrus.com> <20180226130558.7634-9-rf@opensource.cirrus.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Mar 2018 09:07:28 +0100
Message-ID: <CACRpkdaV=NK_wXyjHnwRZ44MN1dgdpu9vm-S4fa9swdi04iEvQ@mail.gmail.com>
Subject: Re: [PATCH v8 8/9] pinctrl: madera: Add driver for Cirrus Logic
 Madera codecs
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, patches@opensource.cirrus.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 2:05 PM, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:

> These codecs have a variable number of I/O lines each of which
> is individually selectable to a wide range of possible functions.
>
> The functionality is slightly different from the traditional muxed
> GPIO since most of the functions can be mapped to any pin (and even
> the same function to multiple pins). Most pins have a dedicated
> "alternate" function that is only available on that pin. The
> alternate functions are usually a group of signals, though it is
> not always necessary to enable the full group, depending on the
> alternate function and how it is to be used. The mapping between
> alternate functions and GPIO pins varies between codecs depending
> on the number of alternate functions and available pins.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> There are some minor changes since LinusW last reviewed this patch but as
> they are trivial I have carried forward Linus's Reviewed-by:
> - SPDX license headers
> - can now build it as a module
> - avoided a minor checkpatch warning about an unnecessary else {} in
>     madera_get_group_name()

It's fine. Keep my Review tag.

Yours,
Linus Walleij
