Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbeBVORj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:17:39 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36681 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932593AbeBVORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:17:36 -0500
X-Google-Smtp-Source: AG47ELuVKUwCRWCmMkq4C3CXkwWUw7ls0g1k8K1FteybKhi9YXlknjxJ73NTf7HS5WdRmjsme8CbuXchpNK/1NvNrik=
MIME-Version: 1.0
In-Reply-To: <422a4c63-5ffc-2b40-4d9a-cf947d4af2fd@users.sourceforge.net>
References: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net> <422a4c63-5ffc-2b40-4d9a-cf947d4af2fd@users.sourceforge.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 15:17:35 +0100
Message-ID: <CACRpkdZF+_vG3FF4i=FzJAUnCZqqOKGZp6DqHhUOZQHQ2ZWr5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: omap: Improve a size determination in omap_gpio_probe()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-gpio@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 10:08 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 10 Feb 2018 21:49:22 +0100
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
