Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeCZIKr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:10:47 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55558 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeCZIKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:10:44 -0400
X-Google-Smtp-Source: AIpwx4/tDix7H7SFI4ewjl9fSuLNBu7W8sa2+GG9+qq4R2Kkuk2b1iS0i8MQ8kl01b3mBlrHGSAy0rpj69SzDxb4HLo=
MIME-Version: 1.0
In-Reply-To: <1699105253cb33680bb27ca61e6fc9fb0bd2aaf8.1521723192.git.vilhelm.gray@gmail.com>
References: <cover.1521723192.git.vilhelm.gray@gmail.com> <1699105253cb33680bb27ca61e6fc9fb0bd2aaf8.1521723192.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 10:10:43 +0200
Message-ID: <CACRpkdbkX8iW0T1cDKmiMK=zXtQ=DULx7-KW5_jAwWZszS+coQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] gpio: 104-idio-16: Implement get_multiple callback
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

> The ACCES I/O 104-IDIO-16 series of devices provides 16
> optically-isolated digital inputs accessed via two 8-bit ports. Since
> eight input lines are acquired on a single port input read, the
> 104-IDIO-16 GPIO driver may improve multiple input reads by utilizing a
> get_multiple callback. This patch implements the
> idio_16_gpio_get_multiple function which serves as the respective
> get_multiple callback.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied.

Yours,
Linus Walleij
