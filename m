Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932865AbeBVOOl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:14:41 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:55262 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932648AbeBVOOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:14:39 -0500
X-Google-Smtp-Source: AH8x225pLwyfKXWLz6uDCAF0EC583sxgf9vBEScTRiCr7FAMT2DBXaTqEW6hpD3Gufkw/ojKT5rQWMFIarPBil7DQs4=
MIME-Version: 1.0
In-Reply-To: <758bf4e7-5beb-dbf6-54ed-6c691a56bbee@users.sourceforge.net>
References: <da77f86c-a366-0a0f-10fd-9b7cfd879391@users.sourceforge.net> <758bf4e7-5beb-dbf6-54ed-6c691a56bbee@users.sourceforge.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 15:14:38 +0100
Message-ID: <CACRpkdZ=nVFP3ROMyBAudXO1Ow+nff+o-X0UY6zDrkY43VT5_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: timberdale: Delete an error message for a
 failed memory allocation in timbgpio_probe()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 9:32 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 10 Feb 2018 21:09:08 +0100
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.

Yours,
Linus Walleij
