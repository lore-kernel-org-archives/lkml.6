Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752490AbeCZI16 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:27:58 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40550 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbeCZI14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:27:56 -0400
X-Google-Smtp-Source: AG47ELsSVwRlU0+vIpr2xed9jscY+SKq5NlL/52El1p5lw6SDtSnVKcZ0y61iLq61Ho4AWN5QIsxolJFmeUB0LmHfh8=
MIME-Version: 1.0
In-Reply-To: <dca781eea9e47dafa3da9d450e2de54d11c62878.1521723192.git.vilhelm.gray@gmail.com>
References: <cover.1521723192.git.vilhelm.gray@gmail.com> <dca781eea9e47dafa3da9d450e2de54d11c62878.1521723192.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 10:27:54 +0200
Message-ID: <CACRpkdaDWyjNA6DajVAuiOX+sad3mzEMfx7sUKTDMr9oOfDdKQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] gpio: gpio-mm: Implement get_multiple callback
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 2:00 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> The Diamond Systems GPIO-MM series of devices contain two 82C55A
> devices, which each feature three 8-bit ports of I/O. Since eight input
> lines are acquired on a single port input read, the GPIO-MM GPIO driver
> may improve multiple input reads by utilizing a get_multiple callback.
> This patch implements the gpiomm_gpio_get_multiple function which serves
> as the respective get_multiple callback.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied.

Yours,
Linus Walleij
