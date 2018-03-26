Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeCZQ3v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:29:51 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:38058 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeCZQ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:29:50 -0400
X-Google-Smtp-Source: AG47ELuXTgZzxMYzRifSj/sulnIZmialD1smL1+2PAPiaOPAf4vJdLvlzF4A0Mtgg92W1aLZ/HqkfiywpzVi2d3Bcd0=
MIME-Version: 1.0
In-Reply-To: <20180314153603.3127932-25-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de> <20180314153603.3127932-25-arnd@arndb.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 18:29:48 +0200
Message-ID: <CACRpkdZiY4kBqyAe8AV6hTaNvjRCr7DG=_0_6UBW8SLN73fxQg@mail.gmail.com>
Subject: Re: [PATCH 24/47] gpio: remove etraxfs driver
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 4:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The cris architecture is getting removed, so we no longer need the
> etraxfs driver.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
