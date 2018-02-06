Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeBFNaB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:30:01 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:39441 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBFN3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 08:29:53 -0500
X-Google-Smtp-Source: AH8x225Sdltg8PrvkDyQf8vekzNWTKRNm+VJep5rEpe5ktWT30jv5ojQ0/BaYJaxrOGsrMcaAoEPdPWpwm8ddlFazZo=
MIME-Version: 1.0
In-Reply-To: <85344479-907c-adf7-6ae6-6d6acff2c1b1@users.sourceforge.net>
References: <85344479-907c-adf7-6ae6-6d6acff2c1b1@users.sourceforge.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 6 Feb 2018 14:29:51 +0100
Message-ID: <CACRpkdbMRzD11F9b5QHCHeRp7aBqXNCr6dpPjKg9fSFdc5rOVQ@mail.gmail.com>
Subject: Re: [PATCH] gpio-wm831x: Use seq_putc() in wm831x_gpio_dbg_show()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-gpio@vger.kernel.org, patches@opensource.cirrus.com,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2018 at 9:37 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 12 Jan 2018 21:30:09 +0100
>
> A single character (line break) should be put into a sequence.
> Thus use the corresponding function "seq_putc".
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied with Charles' ACK.

Yours,
Linus Walleij
