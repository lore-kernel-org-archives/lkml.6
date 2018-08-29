Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18CDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681E82083A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="mgn5JYt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681E82083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeH2LPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:15:42 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:31316 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH2LPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1535527207;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=5T7KiArVHHXAooAYmhu1zxMw5LwQLOzWkyY52A8YvW0=;
        b=mgn5JYt229RE15yEcjCMoJQMxS9lpPlZAwYgThMZ33aEhpbqVOUpwI5P6pCl4Q6u4l
        ZnbLZcEUH9NdQhbimklELlivclhCNOKuO2D/5q1cqhjO8L6ZXeOOMRwV0EFFp4Nw0qc2
        LKPhcpGijnsBdTXEVWVT1CIBrP8JnT8iavbFBsmnsIyBGhQ/l/p+MuImFwTQUsba0FKl
        1cyJzYM1kJBIF678BkqA3nUiqeDzrm0H/y7D8cnXUG8rnp95v7mHlllWNTizwbaZZ98p
        X+cOBofiy/1ZAkuJSKvFgLJGFuPay1UoySbtgIdxxYtotud2WDeAr52MkKhd39X7k1eH
        Eerg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5gpw91kgwllU1BqC6ek="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.21 DYNA|AUTH)
        with ESMTPSA id n0b6a3u7T7Jx3Ph
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 29 Aug 2018 09:19:59 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 00/32] Device Tree Updates for GTA04 (A3/A4/A5 variants)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
Date:   Wed, 29 Aug 2018 09:19:59 +0200
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <25356247-C081-4B9E-9CE2-2D10EFE56F6C@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
To:     Ladislav Michl <ladis@linux-mips.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Marek Belisko <marek@goldelico.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi OMAP3 DTS Maintainers,
is there any progress in merging this patch series?

We have some more patches in our queue which depend on them.

BR and thanks,
Nikolaus Schaller


> Am 31.07.2018 um 09:11 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> * Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>  asked why we have reg=3D<0> for port@1.
>  Based on his comment we have removed the change for
>  the opa362 reg property in the DT, but worked out a correct
>  fix in the opa362 driver which solves the issue better.
>  See: https://lore.kernel.org/patchwork/patch/968407/
> * Ladislav Michl <ladis@linux-mips.org>
>  has found a typo and we discussed NAND/OneNAND and
>  how the partitions should be setup. A better solution
>  would be to do it completely by u-boot, but unless we have
>  that, we must fix it here.
> * we omit the patch that replaces ti,non-removable by non-removable
>  since additional internal tests have shown that it makes
>  problems with finding the rootfs boot partition.
> * instead we add a patch that explicitly sets broken-cd for mmc1.
>=20
> PATCH V1 2018-07-25 09:00:42:
> We have not upstreamed significant improvements collected
> in the GTA04 vendor kernel tree for some years. The result
> is that distribution kernels derived from upstream (e.g.
> Debian) lag behind and miss significant features and fixes.
>=20
>=20
> H. Nikolaus Schaller (32):
>  ARM: dts: omap3-gta04: fix typo in backlight pins node name
>  ARM: dts: omap3-gta04: fix some whitespace and tab style errors
>  ARM: dts: omap3-gta04: give spi_lcd node a label so that we can
>    overwrite in other DTS files
>  ARM: dts: omap3-gta04: fixes for tvout / venc
>  ARM: dts: omap3-gta04: add devconf1 setup for correct tvout pins
>  ARM: dts: omap3-gta04: tvout: enable as display1 alias
>  ARM: dts: omap3-gta04: fix touchscreen tsc2007
>  ARM: dts: omap3-gta04: add pinmux for bmp085 EOC interrupt
>  ARM: dts: omap3-gta04: make NAND partitions compatible with recent
>    U-Boot
>  ARM: dts: omap3-gta04: update gpmc NAND setup
>  ARM: dts: omap3-gta04: keep vpll2 always on
>  ARM: dts: omap3-gta04: add a comment how to reference the tca6507 =
gpio
>  ARM: dts: omap3-gta04: add warning comment to vaux2 regulator
>  ARM: dts: omap3-gta04: explicitly describe that mmc1 has no CD/WP
>  ARM: dts: omap3-gta04: make use of input event include file and
>    constants
>  ARM: dts: omap3-gta04: map antenna detect GPIO to SW_LINEIN_INSERT =
key
>    event
>  ARM: dts: omap3-gta04: add camera interface parallel port
>  ARM: dts: omap3-gta04: add camera pinmux
>  ARM: dts: omap3-gta04: add mcbsp (audio subsystem) pinmux
>  ARM: dts: omap3-gta04: add devconf0 setup for mcbsp1 clock pins
>  ARM: dts: omap3-gta04: add mcbsp (audio subsystem) nodes
>  ARM: dts: omap3-gta04a3: fix model name for A3 variant
>  ARM: dts: omap3-gta04a4: fix model name for A4 variant
>  ARM: dts: omap3-gta04a5: fix copyright of A5 variant
>  ARM: dts: omap3-gta04a5: fix model name
>  ARM: dts: omap3-gta04a5: fix whitepsace and tab style
>  ARM: dts: omap3-gta04a5: add support for PPS
>  ARM: dts: omap3-gta04a5: disable IrDA receiver to save power
>  ARM: dts: omap3-gta04a5: add support for ti,wl1837 module
>  ARM: dts: omap3-gta04a5: uses different sensors than gta04a4
>  ARM: dts: omap3-gta04a5: define pinmux for bluetooth enable of
>    ti,wl1837 module
>  ARM: dts: omap3-gta04a5one: define GTA04A5 variant with OneNAND
>=20
> arch/arm/boot/dts/omap3-gta04.dtsi     | 248 =
+++++++++++++++++++++++++++++----
> arch/arm/boot/dts/omap3-gta04a3.dts    |   2 +-
> arch/arm/boot/dts/omap3-gta04a4.dts    |   2 +-
> arch/arm/boot/dts/omap3-gta04a5.dts    | 129 ++++++++++++++++-
> arch/arm/boot/dts/omap3-gta04a5one.dts | 114 +++++++++++++++
> 5 files changed, 462 insertions(+), 33 deletions(-)
> create mode 100644 arch/arm/boot/dts/omap3-gta04a5one.dts
>=20
> --=20
> 2.12.2
>=20

