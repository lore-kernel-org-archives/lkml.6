Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936331AbeCBMBE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:01:04 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:55440 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936318AbeCBMBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:01:00 -0500
X-Google-Smtp-Source: AG47ELs6//DRHsEDUuc2AjOKCrvp7cKv7ruxR7/LvSYIEPQ9lzxJfwClqBzo7tTGz1KKKPt0JrRHNtKWBOEkkIwLsEs=
MIME-Version: 1.0
In-Reply-To: <3c3b8755d186b1f762081ee18efb718886814e51.1519984021.git.baruch@tkos.co.il>
References: <3c3b8755d186b1f762081ee18efb718886814e51.1519984021.git.baruch@tkos.co.il>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Mar 2018 13:00:59 +0100
Message-ID: <CACRpkdaS2cYCZiT4VJ4Nji3=j_MTtxCNuDWUi8T8Nvm4dJgrcQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: raspberrypi-exp: explain Kconfig dependency
To: Baruch Siach <baruch@tkos.co.il>
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 10:47 AM, Baruch Siach <baruch@tkos.co.il> wrote:

> Commit 7ed915059c3001 (gpio: raspberrypi-ext: fix firmware dependency)
> fixed the Kconfig dependency to ensure that gpio-raspberrypi-exp is not
> built-in when the firmware is a module. But the Kconfig syntax for doing
> so is cryptic. Add a comment to make it a little easier.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Patch applied.

Yours,
Linus Walleij
