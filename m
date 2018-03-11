Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932151AbeCKKGZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 06:06:25 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42823 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932116AbeCKKGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:06:23 -0400
X-Google-Smtp-Source: AG47ELvvJBMofRJxjBhB86pTadci5RwhXIfbVd2JMdzp84tITSBPEfIczic89xrZWJregrveocn0o8L1ZBt6gCzmXPc=
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 11 Mar 2018 11:06:22 +0100
Message-ID: <CACRpkdZvwWmh7NqcoM9bgTxnLECv5thLavyCAS7jPv87DF0ZTA@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for v4.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is a singular fix for v4.16 and the Renesas RCAR driver.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.16-3

for you to fetch changes up to 9ac79ba9c77d8595157bbdc4327919f8ee062426:

  gpio: rcar: Use wakeup_path i.s.o. explicit clock handling
(2018-03-05 09:01:21 +0100)

----------------------------------------------------------------
This is a single GPIO fix for the v4.16 series affecting the
Renesas driver, and fixes wakeup from external stuff.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      gpio: rcar: Use wakeup_path i.s.o. explicit clock handling

 drivers/gpio/gpio-rcar.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)
