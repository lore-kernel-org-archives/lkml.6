Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753711AbeC1PSh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:18:37 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:55704 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753360AbeC1PSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:18:36 -0400
X-Google-Smtp-Source: AIpwx4/Eyg+ZErYISzsAoYJdLY+GmD/I2bT6RRbhgzL4RCskfULunlWnkE5lXYW9BrW+uOvhN7kZ0mCHgpYBu8Gvg9U=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQWikF9K41uzkQjixUEO=_s14txEhvd=rmLY69JShezKg@mail.gmail.com>
References: <CAK7LNAQWikF9K41uzkQjixUEO=_s14txEhvd=rmLY69JShezKg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Mar 2018 17:18:34 +0200
X-Google-Sender-Auth: Hhno22Y1ertagJbQtHjq6PC90Xg
Message-ID: <CAK8P3a2db8WqWVQQtnFW+FtqLUSiEZqtUB79bNMw23g88iHixQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for 4.17 (2nd)
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 6:31 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Arnd, Olof,
>
> Sorry for this very late pull request.
> If possible, could you pull a little more for v4.17-rc1 ?

> ----------------------------------------------------------------
> UniPhier ARM SoC DT updates for v4.17 (2nd)
>
> - add syscon property to sound nodes
> - add more ethernet pin groups
> - add ethernet support for PXs3 SoC

It all looks harmless, so no problem at all. Pulled into next/dt, thanks!

       Arnd
