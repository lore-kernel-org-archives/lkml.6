Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeCZI1J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:27:09 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41575 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbeCZI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:27:05 -0400
X-Google-Smtp-Source: AG47ELszV8vrx18FmMIDQutHGzAecsJGp3qXoFkbQgrBaZ0wzcOa+ZXVsrfYcnquAjqMi9ncJuKn9G36VC8BItfmXCQ=
MIME-Version: 1.0
In-Reply-To: <a91859083599fe06a302eb336858d56ce8e8ea3d.1521723192.git.vilhelm.gray@gmail.com>
References: <cover.1521723192.git.vilhelm.gray@gmail.com> <a91859083599fe06a302eb336858d56ce8e8ea3d.1521723192.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 10:27:04 +0200
Message-ID: <CACRpkdaarvTewRR6sz0C_3ML5uhHhXR3BazYZXvEFdEJBw8FTw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] gpio: 104-idi-48: Implement get_multiple callback
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

> The ACCES I/O 104-IDI-48 series of devices provides 48
> optically-isolated inputs accessed via six 8-bit ports. Since eight
> input lines are acquired on a single port input read, the 104-IDI-48
> GPIO driver may improve multiple input reads by utilizing a get_multiple
> callback. This patch implements the idi_48_gpio_get_multiple function
> which serves as the respective get_multiple callback.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied.

Yours,
Linus Walleij
