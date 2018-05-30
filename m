Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968695AbeE3HLm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:11:42 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37041 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968533AbeE3HLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:11:37 -0400
X-Google-Smtp-Source: ADUXVKK2MZ2k2IcAf7IO8UX8Pfyn7iPs9pfiqN8h2QOTefa52uFZNKWjuD2xkVVbmuobJxpdfAM8jw+yXy37QE+J9GI=
MIME-Version: 1.0
In-Reply-To: <20180529145101.20808-1-nsekhar@ti.com>
References: <20180529145101.20808-1-nsekhar@ti.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 30 May 2018 09:11:36 +0200
Message-ID: <CACRpkdaKFPp72FvOC9s7fxnmOsmNQ7xZ0O8WZi_a3+81E4mL8Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: davinci: fix build warning when !CONFIG_OF
To: Sekhar Nori <nsekhar@ti.com>
Cc: Keerthy <j-keerthy@ti.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4U7C1wr028152

On Tue, May 29, 2018 at 4:51 PM, Sekhar Nori <nsekhar@ti.com> wrote:

> This nukes the following warning that is seen when building without
> OF support:
>
> drivers/gpio/gpio-davinci.c:437:25: warning: ‘keystone_gpio_get_irq_chip’ defined but not used [-Wunused-function]
>  static struct irq_chip *keystone_gpio_get_irq_chip(unsigned int irq)
>                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Patch applied.

Yours,
Linus Walleij
