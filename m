Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932748AbeBVOTz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:19:55 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:36915 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeBVOTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:19:52 -0500
X-Google-Smtp-Source: AG47ELsQDZMhP2t7Z3H3RswBoYbohSGO/R2lKypdLb540eIeaOrpIRW6+b5WCnvlaGl9oeRaShGxW3a3j4DfOyotprc=
MIME-Version: 1.0
In-Reply-To: <d73420c9-60ee-ab28-e881-299441815afc@users.sourceforge.net>
References: <d73420c9-60ee-ab28-e881-299441815afc@users.sourceforge.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 15:19:50 +0100
Message-ID: <CACRpkdbjJPcRwqCNvRnKyyrSLcrcp9CKCcWXXvSRx8BwtBw72A@mail.gmail.com>
Subject: Re: [PATCH] gpio: merrifield: Delete an error message for a failed
 memory allocation in mrfld_gpio_probe()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 1:42 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 11 Feb 2018 13:30:14 +0100
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.

Yours,
Linus Walleij
