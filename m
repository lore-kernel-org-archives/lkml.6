Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932775AbeBVOPa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:15:30 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:32920 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932674AbeBVOP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:15:28 -0500
X-Google-Smtp-Source: AG47ELtylVXSMCX8h1vRC2YBFk36+XtWgnh1Ox/4c/lAZLD2H55x1pwPy3tNPZkK7TD6BogBeTqZv8gBOozWfxmeIZY=
MIME-Version: 1.0
In-Reply-To: <df13123f-5c90-03e0-edb6-0ab9751b7aa2@users.sourceforge.net>
References: <da77f86c-a366-0a0f-10fd-9b7cfd879391@users.sourceforge.net> <df13123f-5c90-03e0-edb6-0ab9751b7aa2@users.sourceforge.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 15:15:27 +0100
Message-ID: <CACRpkdZNipm4spks8wdGRwG2UwxvQ87svtV9FjiCPYnwNw-62Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: timberdale: Improve a size determination in timbgpio_probe()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 9:33 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 10 Feb 2018 21:13:28 +0100
>
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.

Yours,
Linus Walleij
