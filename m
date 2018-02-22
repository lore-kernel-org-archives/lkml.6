Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932804AbeBVOQf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:16:35 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:40645 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932593AbeBVOQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:16:32 -0500
X-Google-Smtp-Source: AH8x224DWHF6LWvP7woryHRn2HxFl/RZkYMXm6opWLdknTpo52EbqkeuErKfGNq4dsdLdkw0mlGM1wqaR4NzsFeZDz4=
MIME-Version: 1.0
In-Reply-To: <86570340-688b-34ec-2d99-ff728ccbe4a9@users.sourceforge.net>
References: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net> <86570340-688b-34ec-2d99-ff728ccbe4a9@users.sourceforge.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 15:16:31 +0100
Message-ID: <CACRpkdaEteCvgQuP-+5eR7Jn1E4ViZdskV9DqA7uekcuqO_k5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: omap: Delete an error message for a failed
 memory allocation in omap_gpio_probe()
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

On Sat, Feb 10, 2018 at 10:07 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 10 Feb 2018 21:46:30 +0100
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.

Yours,
Linus Walleij
