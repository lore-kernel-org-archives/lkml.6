Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932249AbeEWJbB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:31:01 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51724 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932196AbeEWJay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:30:54 -0400
X-Google-Smtp-Source: AB8JxZpFvcS+wKs2cNUv8/Jk8HPDnjYUf9dQlT0n7rwGrZvBnuJx5mOAKcZSCJ6G4sme1HP7yeGyVvTcaeeSJ8NbbPQ=
MIME-Version: 1.0
In-Reply-To: <1527065564-9127-1-git-send-email-phil.edworthy@renesas.com>
References: <1527065564-9127-1-git-send-email-phil.edworthy@renesas.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 May 2018 11:30:52 +0200
Message-ID: <CACRpkdY9di8hzPzVvaQjDaAd2ERqYKDwxAUspCKakkmxjD93fA@mail.gmail.com>
Subject: Re: [PATCH] gpio: dwapb: Rework support for 1 interrupt per port A GPIO
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hoan Tran <hotran@apm.com>, Lee Jones <lee.jones@linaro.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 10:52 AM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:

> Treat DT and ACPI the same as much as possible. Note that we can't use
> platform_get_irq() to get the DT interrupts as they are in the port
> sub-node and hence do not have an associated platform device.
>
> This also fixes a problem introduced with error checking when calling
> platform_get_irq().
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

OK this patch applied!

Yours,
Linus Walleij
