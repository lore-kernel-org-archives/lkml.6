Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C63BC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 19:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3BA2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 19:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545678652;
	bh=MF89EJCvI8THAgcMSgeDeRqVpuUTWkbIExXw6NDIBrQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Og/QMCWGg9JQF7TF7FT+RHjoFXsCiJAm2CGk1/L1zpup5hlz1Mv7bkw3T5KHP3wax
	 ocVkF9U1gdJyC3XXWfOg5MiMqFYqe+/5F0mB/2lBfDjfPURCbsBJIcc1oshUzQstCQ
	 qo+qI4X2+0+SLvrBHglEy7nAq/hYnzqFA3DrLmvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbeLXTKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 14:10:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41450 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLXTKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 14:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3FoIFFgFbP+IYsI4TlVHh2/VFUvRJSjo6xrrdV0V+Q8=; b=Ojf3vSZ/pKFdQfSpA0IQrSreN
        vEHDbfbs48YqOiQNEEJ03RZ+15pYxI8Ca/GGg0JMWrwBo/RMd+dFD9Tff0LXnxjG90UExQ2HLOluG
        LHkNWvhGyaZUfOQMhF53Ql9fOu7GaO0+B9o/6vMJs2uQwu7FqcQdme9D52qCbRr0Ihl6E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gbVcl-00076Z-Rd; Mon, 24 Dec 2018 19:10:47 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 408BC440080; Mon, 24 Dec 2018 19:10:47 +0000 (GMT)
Date:   Mon, 24 Dec 2018 19:10:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [GIT PULL] SPI updates for v4.21
Message-ID: <20181224191047.GB1846@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
X-Cookie: knowledge, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
v4.21

for you to fetch changes up to 74ff666bd7ba2da563f99f2a8af7bf9f20008bc9:

  Merge remote-tracking branches 'spi/topic/mem' and 'spi/topic/mtd' into s=
pi-next (2018-12-20 16:01:30 +0000)

----------------------------------------------------------------
spi: Updates for v4.21

The main thing this release has been a lot of work on the integration
with SPI NOR flashes, there's been some specific support for a while for
controller features designed to make them perform better but it's not
worked out as well as hoped so the interface has been redesigned in a
way that will hopefully do better - it's already been adopted by a
number of additional controllers so things are looking good.  Otherwise
most of the work has been driver specific:

 - Support for better integration with NOR flashes from Boris Brezillon
   and Yogesh Narayan Gaur plus usage of it in several drivers.
 - A big cleanup of the Rockchip driver from Emil Renner Berthing.
 - Lots of performance improvements for bcm2835 from Lukas Wunner.
 - Slave mode support for pxa2xx from Lubomir Rintel.
 - Support for Macronix MXIC, Mediatek MT7629 and MT8183, NPCM PSPI,
   and Renesas r8a77470.

----------------------------------------------------------------
Alok Chauhan (2):
      spi: spi-geni-qcom: fix nitpicks
      spi: spi-geni-qcom: Simplify probe function

Arnd Bergmann (1):
      mtd: atmel-quadspi: disallow building on ebsa110

Boris Brezillon (4):
      spi: spi-mem: Add missing word in the SPI_MEM_DATA_OUT description
      spi: spi-mem: Add SPI_MEM_NO_DATA to the spi_mem_data_dir enum
      spi: spi-mem: Split spi_mem_exec_op() code
      spi: spi-mem: Add a new API to support direct mapping

Chuanhua Han (1):
      spi: spi-fsl-dspi: use IRQF_SHARED mode to request IRQ

Clark Wang (4):
      spi: lpspi: Replace all "master" with "controller"
      spi: lpspi: Add slave mode support
      spi: lpspi: Let watermark change with send data length
      doc: lpspi: Document DT bindings for LPSPI slave mode

Colin Ian King (1):
      spi: npcm: fix u32 csgpio being checked for less than zero

Dan Carpenter (1):
      spi: npcm: Fix an error code in the probe function

Emil Renner Berthing (14):
      spi: rockchip: make spi_enable_chip take bool
      spi: rockchip: use designated init for dma config
      spi: rockchip: always use SPI mode
      spi: rockchip: use atomic_t state
      spi: rockchip: disable spi on error
      spi: rockchip: read transfer info directly
      spi: rockchip: don't store dma channels twice
      spi: rockchip: remove master pointer from dev data
      spi: rockchip: simplify use_dma logic
      spi: rockchip: set min/max speed
      spi: rockchip: precompute rx sample delay
      spi: rockchip: use irq rather than polling
      spi: rockchip: support 4bit words
      spi: rockchip: support lsb-first mode

Fabrizio Castro (2):
      spi: rspi: Add r8a77470 to the compatible list
      spi: sh-msiof: Add r8a774c0 support

Fredrik Ternerot (1):
      spi: pl022: Handle cs_change for last transfer

Hoan Nguyen An (1):
      spi: sh-msiof: Reduce the number of times write to and perform the tr=
ansmission from FIFO

Jarkko Nikula (1):
      spi: pxa2xx: Remove LPSS private register restoring during resume

Jay Fang (1):
      spi: dw-mmio: add ACPI support

Keiji Hayashibara (2):
      spi: uniphier: fix incorrect property items
      spi: uniphier: re-add addressing properties

Leilk Liu (4):
      spi: mediatek: Add bindings for mediatek MT8183 soc platform
      spi: mediatek: add spi support for mt8183 IC
      spi: mediatek: Add bindings for mediatek MT7629 soc platform
      spi: mediatek: add spi support for mt7629 IC

Linus Walleij (1):
      spi: gpio: Support 3WIRE high-impedance turn-around

Lubomir Rintel (7):
      spi: pxa2xx: dt-bindings: Add spi-slave property
      spi: Deal with slaves that return from transfer_one() unfinished
      spi: pxa2xx: Add slave mode support
      spi: pxa2xx: dt-bindings: Add ready GPIO signal
      spi: pxa2xx: Add ready signal
      spi: pxa2xx: Deal with the leftover garbage in TXFIFO
      spi: pxa2xx: Fix '"CONFIG_OF" is not defined' warning

Lukas Wunner (10):
      spi: bcm2835: Avoid finishing transfer prematurely in IRQ mode
      spi: bcm2835: Fix book-keeping of DMA termination
      spi: bcm2835: Fix race on DMA termination
      spi: bcm2835: Drop unused code for native Chip Select
      spi: bcm2835: Document struct bcm2835_spi
      spi: bcm2835: Overcome sglist entry length limitation
      spi: bcm2835: Unbreak the build of esoteric configs
      spi: bcm2835: Polish transfer of DMA prologue
      spi: bcm2835: Speed up FIFO access if fill level is known
      spi: bcm2835: Synchronize with callback on DMA termination

Mark Brown (9):
      Merge branch 'spi-4.20' into spi-4.21 for uniphier DT
      spi: Fix core transfer waits after slave support
      Merge branch 'spi-4.20' into spi-4.21 for bcm stuff.
      Merge branch 'for-4.20' of https://git.kernel.org/.../broonie/spi int=
o spi-4.21
      spi: Fix formatting of header block
      Merge branch 'topic/3wire-gpio' of https://git.kernel.org/.../broonie=
/spi into spi-4.21 mode conflict
      Merge branch 'spi-4.20' into spi-linus
      Merge branch 'spi-4.21' into spi-next
      Merge remote-tracking branches 'spi/topic/mem' and 'spi/topic/mtd' in=
to spi-next

Mason Yang (2):
      spi: Add MXIC controller driver
      dt-binding: spi: Document Macronix controller bindings

Olof Johansson (1):
      spi: npcm: Fix uninitialized variable warning

Piotr Bugalski (6):
      mtd: spi-nor: atmel-quaspi: Typo fix
      mtd: spi-nor: atmel-quadspi: Add spi-mem support to atmel-quadspi
      mtd: spi-nor: atmel-quadspi: Use spi-mem interface for atmel-quadspi =
driver
      mtd: spi-nor: atmel-quadspi: Remove unused code from atmel-quadspi dr=
iver
      spi: Add QuadSPI driver for Atmel SAMA5D2
      dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2

Radu Pirea (1):
      spi: at91-usart: add power management support

Randy Dunlap (1):
      spi: fix spi-at91-usart.c build errors when PINCTRL is not set

Rob Herring (1):
      spi: Use of_node_name_eq for node name comparisons

Stefan Wahren (1):
      spi: bcm2835: make license text and module license match

Tomer Maimon (4):
      dt-binding: spi: add NPCM PSPI controller documentation
      spi: npcm: add NPCM PSPI controller driver
      spi: npcm: Modify pspi send function
      spi: Update NPCM PSPI controller documentation

Uwe Kleine-K=F6nig (5):
      spi: imx: add a device specific prepare_message callback
      spi: imx: mx51-ecspi: Move some initialisation to prepare_message hoo=
k.
      spi: imx: style fixes
      spi: imx: rename config callback and add useful parameters
      spi: imx: drop useless member speed_hz from driver data struct

Vignesh R (2):
      spi: omap-spi: Add compatible for AM654 SoC
      spi: Kconfig: Enable McSPI driver for K3 platforms

Wolfram Sang (3):
      spi: spi-sh-msiof: simplify getting .driver_data
      spi: spi-zynqmp-gqspi: simplify getting .driver_data
      spi: spi-rspi: simplify getting .driver_data

Yogesh Narayan Gaur (2):
      spi: add support for octal mode I/O data transfer
      spi: spi-mem: add support for octal mode I/O data transfer

kbuild test robot (1):
      spi: npcm: fix platform_no_drv_owner.cocci warnings

 .../bindings/{mtd =3D> spi}/atmel-quadspi.txt        |   0
 .../devicetree/bindings/spi/nuvoton,npcm-pspi.txt  |  43 ++
 Documentation/devicetree/bindings/spi/omap-spi.txt |   1 +
 Documentation/devicetree/bindings/spi/sh-msiof.txt |   1 +
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt      |   4 +
 .../devicetree/bindings/spi/spi-mt65xx.txt         |   2 +
 Documentation/devicetree/bindings/spi/spi-mxic.txt |  34 ++
 .../devicetree/bindings/spi/spi-pxa2xx.txt         |   3 +
 Documentation/devicetree/bindings/spi/spi-rspi.txt |   1 +
 .../devicetree/bindings/spi/spi-uniphier.txt       |   4 +
 drivers/mtd/spi-nor/Kconfig                        |   9 -
 drivers/mtd/spi-nor/Makefile                       |   1 -
 drivers/spi/Kconfig                                |  24 +-
 drivers/spi/Makefile                               |   3 +
 drivers/{mtd/spi-nor =3D> spi}/atmel-quadspi.c       | 528 +++++----------=
---
 drivers/spi/spi-at91-usart.c                       |  62 +++
 drivers/spi/spi-bcm2835.c                          | 496 ++++++++++++-----
 drivers/spi/spi-bcm2835aux.c                       |   2 +-
 drivers/spi/spi-dw-mmio.c                          |   8 +
 drivers/spi/spi-dw.c                               |   1 +
 drivers/spi/spi-fsl-dspi.c                         |   4 +-
 drivers/spi/spi-fsl-lpspi.c                        | 202 ++++---
 drivers/spi/spi-geni-qcom.c                        |  64 +--
 drivers/spi/spi-gpio.c                             |  24 +-
 drivers/spi/spi-imx.c                              | 156 ++++--
 drivers/spi/spi-mem.c                              | 278 ++++++++-
 drivers/spi/spi-mt65xx.c                           |  12 +
 drivers/spi/spi-mxic.c                             | 619 +++++++++++++++++=
++++
 drivers/spi/spi-npcm-pspi.c                        | 495 ++++++++++++++++
 drivers/spi/spi-pl022.c                            |  14 +-
 drivers/spi/spi-pxa2xx.c                           | 109 +++-
 drivers/spi/spi-pxa2xx.h                           |   3 +
 drivers/spi/spi-rockchip.c                         | 579 +++++++++--------=
--
 drivers/spi/spi-rspi.c                             |   6 +-
 drivers/spi/spi-sh-msiof.c                         |  16 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |   6 +-
 drivers/spi/spi.c                                  |  84 ++-
 include/linux/spi/pxa2xx_spi.h                     |   1 +
 include/linux/spi/spi-mem.h                        |  84 ++-
 include/linux/spi/spi.h                            |   5 +-
 40 files changed, 2885 insertions(+), 1103 deletions(-)
 rename Documentation/devicetree/bindings/{mtd =3D> spi}/atmel-quadspi.txt =
(100%)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt
 rename drivers/{mtd/spi-nor =3D> spi}/atmel-quadspi.c (53%)
 create mode 100644 drivers/spi/spi-mxic.c
 create mode 100644 drivers/spi/spi-npcm-pspi.c

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwhLzYACgkQJNaLcl1U
h9Bc0wf/Up4aEA8+s/WBk4yfj/00cfvVA+kqozLMmOqn/C3teUuMCQJuiyUyiVV6
CnAqm6kGz9girf7sJrb0mLyKGfvIl+WuyGF79GcHPyWqFt7Vbfu6hmPMb7rNErvB
DDCOJaSX2/2EVb2XERo5w1m/nPxxF08DFg2IjeKZBMjf0J4+UD3aNxe36Nbecpof
F6l11gPlUIqZqy1C7teglO16M2WxxpD350YrHfHvo+dFaPvftjnkiCqdVlH3HJul
LLQiALdXXYE3Z//IPD4idqgeBRpA/rTvVtaHcppd4BjCML+2ZgtDcX3gynoohlBe
3Kf7dV4HDxvpWIPlCpBA412ZCeEWBg==
=uHRb
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
