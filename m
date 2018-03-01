Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965122AbeCAIZc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:25:32 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:56203 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935781AbeCAIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:25:30 -0500
X-Google-Smtp-Source: AG47ELvu5590a5YsHDO6hdtJ0Cp+g3bsfbAmbKkXzUNi3j+YNAn/N1BMGcnpsbX6X9EpHWesaFDPZJtaS93W0qp/YAU=
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Mar 2018 09:25:28 +0100
Message-ID: <CACRpkdZpVtTVuPYMhRPP1WpyraHsXoRQX9yv5yv8hmOQWJ69vw@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v4.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

two smallish pin control fixes: one actual code fix for the Meson and
a MAINTAINERS update.

Please pull it in!

Yours,
Linus Walleij


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.16-2

for you to fetch changes up to 78de41a368af26e54ba53e63629fd7f166f17cef:

  MAINTAINERS: add Freescale pin controllers (2018-02-21 11:09:23 +0100)

----------------------------------------------------------------
Pin control fixes for v4.16:

- Fix a pin group on the Meson.
- Assign maintainers for Freescale/NXP pin controllers.

----------------------------------------------------------------
Stefan Agner (1):
      MAINTAINERS: add Freescale pin controllers

Yixun Lan (1):
      pinctrl: meson-axg: adjust uart_ao_b pin group naming

 MAINTAINERS                               | 11 +++++++++++
 drivers/pinctrl/meson/pinctrl-meson-axg.c |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)
