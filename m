Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932285AbeBVMlQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:41:16 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:46059 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753719AbeBVMlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:41:12 -0500
X-Google-Smtp-Source: AG47ELt06PXDrfohzCrwcXohavDiXfpi4KZiw6uPJ/TwhXZY+H3Xa1Im5Xq6P8c7m1l20ocSNvugaLiBPkZ8DukuygM=
MIME-Version: 1.0
In-Reply-To: <97f41346-6abb-1c14-f536-ad12bbcb4c60@users.sourceforge.net>
References: <97f41346-6abb-1c14-f536-ad12bbcb4c60@users.sourceforge.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 13:41:11 +0100
Message-ID: <CACRpkdbeK282zbJPerxvuXLupMj_iJ_pRaBuDSYU2F+bYNr6AA@mail.gmail.com>
Subject: Re: [PATCH 0/2] I2C-Nomadik: Adjustments for nmk_i2c_probe()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-i2c@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 4:38 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 2 Feb 2018 16:34:56 +0100
>
> Two update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (2):
>   Delete an error message for a failed memory allocation
>   Improve a size determination

Those look OK.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
