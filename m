Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeCWDF1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 23:05:27 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35683 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbeCWDFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 23:05:25 -0400
X-Google-Smtp-Source: AG47ELvagBdcNyfRS6pX0SeqN9YtBwWGFFI71rXJVxGJ8gwxH5KZAJFMj+lD5AqXyF/onZJ2YwknCMUZChY6MUQS/ms=
MIME-Version: 1.0
In-Reply-To: <1520334956-9900-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520334956-9900-1-git-send-email-yamada.masahiro@socionext.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Mar 2018 04:05:23 +0100
Message-ID: <CACRpkdYZCxX+=1-Ght1gJoyLFXk_W+3hpAn5XEWm13OnGQiCEA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: add 'depends on HAS_IOMEM' to fix unmet dependency
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Ludovic Barre <ludovic.barre@st.com>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Rob Herring <robh@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 12:15 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> These configs select MFD_SYSCON, but do not depend on HAS_IOMEM.
>
> Compile testing on architecture without HAS_IOMEM causes "unmet
> direct dependencies" in Kconfig phase.
>
> Detected by "make ARCH=score allyesconfig".
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
