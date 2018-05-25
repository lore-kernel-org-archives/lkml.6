Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030743AbeEYWvO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 18:51:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60286 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030538AbeEYWvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 18:51:13 -0400
Date: Sat, 26 May 2018 00:50:33 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 4.18
Message-ID: <20180525225033.GA26989@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

I'm a bit late for this very small PR, as I had to extend the expiration
date for my GPG signature key.

Two small DT changes that have no functional impact.

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.18-dt

for you to fetch changes up to a642693882ce417683012a211ca9d6e65bae1dc4:

  ARM: dts: at91-sama5d2_xplained: Use IRQ_TYPE specifier (2018-05-14 15:29:52 +0200)

----------------------------------------------------------------
AT91 DT for 4.18:

 - small DT improvements without functional changes

----------------------------------------------------------------
Dmitry Torokhov (1):
      ARM: dts: at91: sama5d4ek: use canonical compatible for touchscreen

Hernán Gonzalez (1):
      ARM: dts: at91-sama5d2_xplained: Use IRQ_TYPE specifier

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
