Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeCZIZ5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:25:57 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54676 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeCZIZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:25:55 -0400
X-Google-Smtp-Source: AIpwx4/stAp7de+MMR2ui2QbU73oVNGFy4SKW36xqIgFRhjhsaYQkv0Hk/8OPeCjlixoEs/8qc8ToTS4xZz7eNn8tCo=
MIME-Version: 1.0
In-Reply-To: <bd4594307521c93f952db774da466a54c434704a.1521723192.git.vilhelm.gray@gmail.com>
References: <cover.1521723192.git.vilhelm.gray@gmail.com> <bd4594307521c93f952db774da466a54c434704a.1521723192.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 10:25:54 +0200
Message-ID: <CACRpkdYtxbX3iW4hx7=xDvY7jWSue894mLvUDA9zHrB-8zufew@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] gpio: pcie-idio-24: Implement get_multiple/set_multiple
 callbacks
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

> The ACCES I/O PCIe-IDIO-24 series of devices provides 24
> optically-isolated digital I/O accessed via six 8-bit ports. Since eight
> input lines are acquired on a single port input read -- and similarly
> eight output lines are set on a single port output write -- the
> PCIe-IDIO-24 GPIO driver may improve multiple I/O reads/writes by
> utilizing a get_multiple/set_multiple callbacks. This patch implements
> the idio_24_gpio_get_multiple function which serves as the respective
> get_multiple callback, and implements the idio_24_gpio_set_multiple
> function which serves as the respective set_multiple callback.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied.

Yours,
Linus Walleij
