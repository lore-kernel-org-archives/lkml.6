Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeBZJgF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:36:05 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:39130 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeBZJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:36:01 -0500
X-Google-Smtp-Source: AG47ELt1Eiv76S4fVDOL+MPa8gBlPKLQYF+wTxbKJ/sMTk5Kp4ufJbgirRAVjNEqh/3GHEC/uLzVM9F3XD3RBGdM80M=
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Feb 2018 10:36:00 +0100
Message-ID: <CACRpkdYGQUynZJu+4-Bj=TzL5=C4qt2cYav__9aHSnwD2NERDA@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for v4.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

two fixes to GPIO, both by nice colleagues fixing my mistakes.
Please pull it in!

Linus Walleij

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.16-2

for you to fetch changes up to c2b3eec47c1b2161adbc70676f1422e6f56aaa32:

  gpio: Handle deferred probing in of_find_gpio() properly (2018-02-21
09:37:34 +0100)

----------------------------------------------------------------
GPIO fixes for the v4.16 kernel:

- Two patches fixing up my mistakes with device tree properties
  compatible for SPI and regulators. Nice to smoke this out for
  v4.16 though, when we actually use it in v4.17 it will be
  in nice shape.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      gpio: Handle deferred probing in of_find_gpio() properly

Maxime Ripard (1):
      gpiolib: Keep returning EPROBE_DEFER when we should

 drivers/gpio/gpiolib-of.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)
