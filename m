Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeCZIYg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:24:36 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39984 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeCZIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:24:34 -0400
X-Google-Smtp-Source: AIpwx4+YfscXslNgPiAqAuV85tY8xTMtvyKxj3cP0eumsoOhS4f+K98UQeqp+jWTAy+fDq4JlPZsP/1hf5gaf05DsmI=
MIME-Version: 1.0
In-Reply-To: <e48b8ffb2497a49492746bed4b0b4276e256e4ad.1521723192.git.vilhelm.gray@gmail.com>
References: <cover.1521723192.git.vilhelm.gray@gmail.com> <e48b8ffb2497a49492746bed4b0b4276e256e4ad.1521723192.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 10:24:33 +0200
Message-ID: <CACRpkdYGt68XrPe=za+a7tWw8+39JTjUPicMssM2-qNMnMmb=A@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] gpio: pci-idio-16: Implement get_multiple callback
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 1:59 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> The ACCES I/O PCI-IDIO-16 series of devices provides 16
> optically-isolated digital inputs accessed via two 8-bit ports. Since
> eight input lines are acquired on a single port input read, the
> PCI-IDIO-16 GPIO driver may improve multiple input reads by utilizing a
> get_multiple callback. This patch implements the
> idio_16_gpio_get_multiple function which serves as the respective
> get_multiple callback.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied.

Yours,
Linus Walleij
