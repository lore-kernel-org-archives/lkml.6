Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbeE1HqK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:46:10 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38333 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753826AbeE1HqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:46:06 -0400
X-Google-Smtp-Source: ADUXVKIzNUQsHArqgFAO/q/jm7H935NRMw3sg2C9HHzzQEyv57gh14qr04E6uFImqIteFZSzj23LWFbESv33wDt5Ylo=
MIME-Version: 1.0
In-Reply-To: <1527261094-10412-1-git-send-email-phil.edworthy@renesas.com>
References: <1527261094-10412-1-git-send-email-phil.edworthy@renesas.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 May 2018 09:46:04 +0200
Message-ID: <CACRpkdb4A=oFh6iirtWLVqqf5F2JpZ3Q-Gc7i+tT9EP7Phb+Dg@mail.gmail.com>
Subject: Re: [PATCH] gpio: dwapb: Fix rework support for 1 interrupt per port
 A GPIO
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

On Fri, May 25, 2018 at 5:11 PM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:

> Commit da069d5d2b814d9887989dcdb29fb0202eac8b38 ("gpio: dwapb: Rework
> support for 1 interrupt per port A GPIO"), was an incremental patch that
> was supposed to provide the delta between v5 and v6 patch set for
> adding support for 1 interupt per port A GPIO. v5 was applied, then some
> other feedback came afterwards.
>
> However, in my haste I managed to drop the changes made to dwapb_port_property
> struct. This patch includes those missing changes.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Patch applied!

Yours,
Linus Walleij
