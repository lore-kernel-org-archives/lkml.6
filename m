Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C772FC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC6B206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfADLGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:06:52 -0500
Received: from sauhun.de ([88.99.104.3]:32910 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfADLGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:06:51 -0500
Received: from localhost (p54B3373D.dip0.t-ipconnect.de [84.179.55.61])
        by pokefinder.org (Postfix) with ESMTPSA id 20E172E3614;
        Fri,  4 Jan 2019 12:06:48 +0100 (CET)
Date:   Fri, 4 Jan 2019 12:06:44 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 5.0 (or how it will be called)
Message-ID: <20190104110641.bf7k42aprdikplx6@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="omoqqexgk64l5znl"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--omoqqexgk64l5znl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has only driver updates for you this time. Mostly new IDs/DT
compatibles, also SPDX conversions, small cleanups. STM32F7 got
FastMode+ and PM support, Axxia some reliabilty improvements.

Please pull.

Thanks,

   Wolfram


The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.0

for you to fetch changes up to 81482d13f37b1c9354d9bf5491699d993b193246:

  i2c: Add Actions Semiconductor Owl family S700 I2C support (2019-01-03 20:36:18 +0100)

----------------------------------------------------------------
Adamski, Krzysztof (Nokia - PL/Wroclaw) (3):
      i2c-axxia: dedicated function to set client addr
      i2c-axxia: check for error conditions first
      i2c: axxia: support sequence command mode

Adrian Bunk (2):
      dt-bindings: eeprom: at24: add "atmel,24c2048" compatible string
      eeprom: at24: add support for 24c2048

Davidlohr Bueso (1):
      i2c: Remove caller signal_pending branch predictions

Enric Balletbo i Serra (1):
      i2c: i2c-cros-ec-tunnel: Switch to SPDX identifier.

Fabrizio Castro (3):
      i2c: sh_mobile: Add support for r8a774c0 (RZ/G2E)
      dt-bindings: i2c: sh_mobile: Add r8a774c0 support
      dt-bindings: i2c: rcar: Add r8a774c0 support

Jarkko Nikula (1):
      i2c: ismt: Add support for Intel Cedar Fork

Lucas Stach (1):
      i2c: imx: don't print error message on probe defer

Parthiban Nallathambi (2):
      dt-bindings: i2c: Add S700 support for Actions Semi Soc's
      i2c: Add Actions Semiconductor Owl family S700 I2C support

Pierre-Yves MORDRET (3):
      dt-bindings: i2c-stm32: SYSCFG Fast Mode Plus support for I2C STM32F7
      i2c: stm32f7: SYSCFG Fast Mode Plus support for I2C STM32F7
      i2c: i2c-stm32f7: add PM Runtime support

Rob Herring (1):
      i2c: powermac: Use of_node_name_eq for node name comparisons

Simon Horman (2):
      i2c: sh_mobile: document support for r8a77990 (R-Car E3)
      i2c: sh_mobile: add support for r8a77990 (R-Car E3)

Stefan Wahren (1):
      i2c: bcm2835: Switch to SPDX identifier

Thierry Reding (4):
      dt-bindings: i2c: Use correct vendor prefix for Atmel
      i2c: tegra: Cleanup kerneldoc comments
      i2c: tegra: Add missing kerneldoc for some fields
      i2c: tegra: Switch to SPDX identifier

Wolfram Sang (2):
      Merge tag 'v4.20-rc6' into i2c/for-5.0
      Merge tag 'at24-4.21-updates-for-wolfram' of git://git.kernel.org/.../brgl/linux into i2c/for-5.0

jun qian (1):
      i2c: tegra: replace spin_lock_irqsave with spin_lock in ISR


with much appreciated quality assurance from
----------------------------------------------------------------
Alexander Sverdlin (3):
      (Rev.) i2c: axxia: support sequence command mode
      (Rev.) i2c-axxia: check for error conditions first
      (Rev.) i2c-axxia: dedicated function to set client addr

Dmitry Osipenko (1):
      (Rev.) i2c: tegra: replace spin_lock_irqsave with spin_lock in ISR

Eric Anholt (1):
      (Rev.) i2c: bcm2835: Switch to SPDX identifier

Geert Uytterhoeven (5):
      (Rev.) dt-bindings: i2c: rcar: Add r8a774c0 support
      (Rev.) dt-bindings: i2c: sh_mobile: Add r8a774c0 support
      (Rev.) i2c: sh_mobile: Add support for r8a774c0 (RZ/G2E)
      (Rev.) i2c: sh_mobile: add support for r8a77990 (R-Car E3)
      (Rev.) i2c: sh_mobile: document support for r8a77990 (R-Car E3)

Manivannan Sadhasivam (1):
      (Rev.) i2c: Add Actions Semiconductor Owl family S700 I2C support

Rob Herring (2):
      (Rev.) dt-bindings: i2c: Add S700 support for Actions Semi Soc's
      (Rev.) dt-bindings: i2c-stm32: SYSCFG Fast Mode Plus support for I2C STM32F7

Simon Horman (3):
      (Rev.) dt-bindings: i2c: rcar: Add r8a774c0 support
      (Rev.) dt-bindings: i2c: sh_mobile: Add r8a774c0 support
      (Rev.) i2c: sh_mobile: Add support for r8a774c0 (RZ/G2E)

 Documentation/devicetree/bindings/eeprom/at24.txt  |   1 +
 Documentation/devicetree/bindings/i2c/i2c-at91.txt |   2 +-
 .../devicetree/bindings/i2c/i2c-mux-ltc4306.txt    |   4 +-
 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |   2 +-
 Documentation/devicetree/bindings/i2c/i2c-owl.txt  |   4 +-
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   1 +
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |  10 +-
 .../devicetree/bindings/i2c/i2c-stm32.txt          |   6 +
 .../devicetree/bindings/i2c/nxp,pca9541.txt        |   2 +-
 drivers/i2c/busses/i2c-axxia.c                     | 168 +++++++++++++++----
 drivers/i2c/busses/i2c-bcm2835.c                   |  10 +-
 drivers/i2c/busses/i2c-cros-ec-tunnel.c            |  14 +-
 drivers/i2c/busses/i2c-ibm_iic.c                   |   2 +-
 drivers/i2c/busses/i2c-imx.c                       |   3 +-
 drivers/i2c/busses/i2c-ismt.c                      |   2 +
 drivers/i2c/busses/i2c-owl.c                       |   1 +
 drivers/i2c/busses/i2c-powermac.c                  |   8 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 |   2 +
 drivers/i2c/busses/i2c-stm32f7.c                   | 182 +++++++++++++++------
 drivers/i2c/busses/i2c-tegra.c                     |  54 +++---
 drivers/misc/eeprom/Kconfig                        |   2 +-
 drivers/misc/eeprom/at24.c                         |   3 +
 22 files changed, 346 insertions(+), 137 deletions(-)

--omoqqexgk64l5znl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwvPjwACgkQFA3kzBSg
KbYgJRAAjnZTVkgwTnBrU0OStqU2LucHp3lHCl7iGgsbQBuvJb3s0dx84vn+aAQ+
dc1zulgH6/I7UbteKwincbeXyK+nJBpduzhLXhDO6J0Z0knQPxgq7zL96mWXeoo+
tHVXwBpYFIBSmz50OQXoyuJMIc1CbskQbOZaZ1DT5Jkk75lzw4SwDCBFwmyLuRZd
u1tSUJVr+EdCP8VkY5ZMaTZfoeUutJrG5MyeLtLt2ncuWP/JXndfm/MNr2aLL7xk
jYMq6VvMNNMFaWW3Igz3ub7rGUYJba3jzNeiJNNRxYcTKISSs8R/sQF5p1IE+ra+
Oumr+ZOZQ33FNrdLoq01l+52kUyn0YuuJLXB+amj9etrEt5nqWa9aZZo/d7hgxVr
wxG2qA2M1BuSSNNU+xGjvYK5hnwyxw1eSBIXyNaYd7MOTk9WZKuksovnuqm7Bo3n
cvV0vj2XUZthZEHfZf+K2HVfe8sharwGoFyf9s7EaJYWP+EzsuHor58UdUrQCWZh
eHGNpsZqew7VBv+nDr32K5fcIpc0wz08j1TPgydStuyhE4l+OkaPyt1iubCL6UIj
qOOx1iblsCF44a85izliXDmFlOIjzbuUo3P0PcG5mkPhTu4HG/WgfzuXdWY2SPkZ
9LhDNz6fRMjM8mC/hGOF3lDjTzxYWy04hZkZTIKBSqTV+X5p3P8=
=2MnH
-----END PGP SIGNATURE-----

--omoqqexgk64l5znl--
