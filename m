Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753676AbeBZOQ7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:16:59 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34529 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753354AbeBZOQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:16:56 -0500
X-Google-Smtp-Source: AG47ELsbxS97KX3vIJUEtWNyVjCstwr7OFRxkUWnEw6Yjy0xgHqb1EjdNMn8NfBvt+AftC/CUbQm2J9MFMXYz2A5b9w=
MIME-Version: 1.0
In-Reply-To: <20180226130558.7634-10-rf@opensource.cirrus.com>
References: <20180226130558.7634-1-rf@opensource.cirrus.com> <20180226130558.7634-10-rf@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 16:16:54 +0200
Message-ID: <CAHp75VebWArW6p4HbvnBYEsBqg5WJkn3Afh+cBNKCDS_W71LBg@mail.gmail.com>
Subject: Re: [PATCH v8 9/9] gpio: madera: Support Cirrus Logic Madera class codecs
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, patches@opensource.cirrus.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 3:05 PM, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
> This adds support for the GPIOs on Cirrus Logic Madera class codecs.
> Any pins not used for special functions (see the pinctrl driver) can be
> used as general single-bit input or output lines. The number of available
> GPIOs varies between codecs.
>
> Note that this is part of a composite MFD for these codecs and can only
> be used with the corresponding MFD and other child drivers on those
> silicon. The GPIO block on these codecs does not exist indepedently of
> the rest of the MFD.

> +struct madera_gpio {
> +       struct madera *madera;
> +       struct gpio_chip gpio_chip;
> +};

Why do you need this? I suppose one embeds or refers to the other.

-- 
With Best Regards,
Andy Shevchenko
