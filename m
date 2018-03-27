Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeC0LcZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:32:25 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35713 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeC0LcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:32:24 -0400
X-Google-Smtp-Source: AG47ELvqpQMnBa3DBm4ecm6K0nJyj6DPb+YkvEwEYA6RQ4xiGWp0kjPH+WJKiwKOFJO5CHw3LYMaqIB/CVzB7d5ryhU=
MIME-Version: 1.0
In-Reply-To: <1520879456-14777-1-git-send-email-phil.edworthy@renesas.com>
References: <1520879456-14777-1-git-send-email-phil.edworthy@renesas.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 13:32:23 +0200
Message-ID: <CACRpkda36fEirnmyJpSs1a=QXvwr_8uRBrpAx2+6hx1R7XSi2Q@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: dwapb: Add support for a bus clock
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Hoan Tran <hotran@apm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 7:30 PM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:

> Enable an optional bus clock provided by DT.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v2:
>  - Fix include order.
>  - Use a clock name.
>  - Check errors from clk_prepare_enable()
>  - Add calls to enable/disable the clock in PM

Patch applied with Andy's review tag.

Yours,
Linus Walleij
