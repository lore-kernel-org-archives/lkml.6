Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeC0L3P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:29:15 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:46920 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeC0L3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:29:13 -0400
X-Google-Smtp-Source: AG47ELsbD0vuARF5z8UVZ6lCkk0VxOgtMBH6lVw2iTLIDSeR0DAf7MfpRRZbG+83Wx+iyjgax0L+PBlhHE7sFf2OnBw=
MIME-Version: 1.0
In-Reply-To: <20180313131904.13700-8-rf@opensource.cirrus.com>
References: <20180313131904.13700-1-rf@opensource.cirrus.com> <20180313131904.13700-8-rf@opensource.cirrus.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 13:29:12 +0200
Message-ID: <CACRpkdZspUbmCk7OwA-rva6zd89TZXt45t5mFes0feuRyOUp9w@mail.gmail.com>
Subject: Re: [PATCH v9 7/9] pinctrl: madera: Add DT bindings for Cirrus Logic
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

On Tue, Mar 13, 2018 at 2:19 PM, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:

> This is the binding description of the pinctrl driver for Cirrus Logic
> Madera codecs. The binding uses the generic pinctrl binding so  the main
> purpose here is to describe the device-specific names for groups and
> functions.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I can also just apply this if you want, as it has no dependencies to
anything else. I just assume you want to keep it together with the
rest of this complex series.

Yours,
Linus Walleij
