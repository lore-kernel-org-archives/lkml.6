Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeDJSIn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:08:43 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:44728 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeDJSIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:08:41 -0400
X-Google-Smtp-Source: AIpwx491vTi3dLcSjsCq+YvuEU2ujAs3kekiI2o2Z/KxwdMpFVBje+zr5pajhJlnyhyRvp3/75rYl7drbExZCLdfnCk=
MIME-Version: 1.0
In-Reply-To: <a5b37e5feff8a58dc63799ec76ef906695fd7239.1523376423.git.hns@goldelico.com>
References: <cover.1523376423.git.hns@goldelico.com> <a5b37e5feff8a58dc63799ec76ef906695fd7239.1523376423.git.hns@goldelico.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 10 Apr 2018 21:08:39 +0300
Message-ID: <CAHp75VcXpXZ+Ue7Cz0ORupgUjLTCiEwFYb2cs9kePX6EbEs-+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] gpio: pca953x: set the PCA_PCAL flag also when
 matching by DT
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 7:07 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> The of_device_table is missing the PCA_PCAL flag so the
> pcal6524 would be operated in tca6424 compatibility mode which
> does not handle the new interrupt mask registers.


> +       { .compatible = "nxp,pcal6524", .data = OF_953X(24, PCA_INT |
> +                                                           PCA_PCAL), },
> +       { .compatible = "nxp,pcal9555a", .data = OF_953X(16, PCA_INT |
> +                                                            PCA_PCAL), },

Sorry didn't comment this earlier, though I think one line still
better to read disregard of 80 char limit.


-- 
With Best Regards,
Andy Shevchenko
