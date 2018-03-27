Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeC0NPc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:15:32 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38304 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeC0NPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:15:30 -0400
X-Google-Smtp-Source: AG47ELuIw0pg+HitbD2bDiccGvnkqGkkU++fM9GJBPwyq6oVvjoucLHlOwM1RaZ3CXWthIJPX2rv8mG42EjUdx2EPNU=
MIME-Version: 1.0
In-Reply-To: <1521447194-26514-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1521447194-26514-1-git-send-email-hayashi.kunihiko@socionext.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 15:15:28 +0200
Message-ID: <CACRpkdatq6B7Of1DZAq0RcwcHxf6Qy1HcMaCC=3Wb_ogYsYfvw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: uniphier: add UART hardware flow control pin-mux settings
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 9:13 AM, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:

> UniPhier SoCs have the following pins for hardware flow control of UART:
>   XRTS, XCTS
> and for modem control of UART:
>   XDTR, XDSR, XDCD, XRI
>
> The port number with the flow control is SoC-dependent.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Patch applied with Masahiro's ACK!

Yours,
Linus Walleij
