Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XWXmJPfKHVuxFQAAmS7hNA
	; Mon, 11 Jun 2018 01:16:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8564460795; Mon, 11 Jun 2018 01:16:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7BA27600D0;
	Mon, 11 Jun 2018 01:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BA27600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753765AbeFKBQA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 21:16:00 -0400
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:37886 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753699AbeFKBP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 21:15:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E87CDAE840
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:15:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rifle31_6e368d1497c2d
X-Filterd-Recvd-Size: 7355
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:15:57 +0000 (UTC)
Message-ID: <aaceb61167066638053effca274df6cf409c65db.camel@perches.com>
Subject: Bad MAINTAINERS patterns
From: Joe Perches <joe@perches.com>
To: LKML <linux-kernel@vger.kernel.org>
Date: Sun, 10 Jun 2018 18:15:55 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given various renames and removals, the MAINTAINERS
file patterns get out of sync with the actual files.

It'd be nice if the various maintainers could fix
these file patterns.

$ ./scripts/get_maintainer.pl --self-test=patterns
./MAINTAINERS:1733: warning: no file matches	F:	include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
./MAINTAINERS:1958: warning: no file matches	F:	arch/arm/plat-samsung/s5p-dev-mfc.c
./MAINTAINERS:2056: warning: no file matches	F:	arch/arm64/boot/dts/marvell/berlin*
./MAINTAINERS:2435: warning: no file matches	F:	include/media/atmel-isi.h
./MAINTAINERS:2973: warning: no file matches	F:	arch/arm64/boot/dts/broadcom/ns2*
./MAINTAINERS:3082: warning: no file matches	F:	Documentation/sound/alsa/Bt87x.txt
./MAINTAINERS:3378: warning: no file matches	F:	Documentation/module-signing.txt
./MAINTAINERS:3800: warning: no file matches	F:	drivers/media/i2c/cs3308.h
./MAINTAINERS:3831: warning: no file matches	F:	include/media/cx2341x*
./MAINTAINERS:3938: warning: no file matches	F:	include/uapi/scsi/cxlflash_ioctls.h
./MAINTAINERS:3981: warning: no file matches	F:	drivers/input/dlink-dir685-touchkeys.c
./MAINTAINERS:4516: warning: no file matches	F:	Documentation/devicetree/bindings/display/ili9225.txt
./MAINTAINERS:4602: warning: no file matches	F:	Documentation/devicetree/bindings/display/st7586.txt
./MAINTAINERS:4608: warning: no file matches	F:	Documentation/devicetree/bindings/display/st7735r.txt
./MAINTAINERS:4641: warning: no file matches	F:	Documentation/devicetree/bindings/video/
./MAINTAINERS:4686: warning: no file matches	F:	Documentation/devicetree/bindings/drm/atmel/
./MAINTAINERS:4717: warning: no file matches	F:	Documentation/devicetree/bindings/display/panel/nec,nl4827hc19_05b.txt
./MAINTAINERS:4827: warning: no file matches	F:	Documentation/devicetree/bindings/display/brcm,bcm-v3d.txt
./MAINTAINERS:5635: warning: no file matches	F:	Documentation/fpga/
./MAINTAINERS:5738: warning: no file matches	F:	Documentation/devicetree/bindings/powerpc/fsl/fman.txt
./MAINTAINERS:6144: warning: no file matches	F:	drivers/staging/greybus/fw-managament.c
./MAINTAINERS:6157: warning: no file matches	F:	drivers/staging/greybus/timesync.c
./MAINTAINERS:6158: warning: no file matches	F:	drivers/staging/greybus/timesync_platform.c
./MAINTAINERS:6504: warning: no file matches	F:	Documentation/vm/hmm.txt
./MAINTAINERS:6796: warning: no file matches	F:	drivers/crypto/nx/nx_debugfs.h
./MAINTAINERS:6817: warning: no file matches	F:	arch/powerpc/include/uapi/asm/vas.h
./MAINTAINERS:6969: warning: no file matches	F:	Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
./MAINTAINERS:7031: warning: no file matches	F:	Documentation/devicetree/bindings/i2c/ina209.txt
./MAINTAINERS:7313: warning: no file matches	F:	arch/x86/include/asm/pmc_core.h
./MAINTAINERS:7404: warning: no file matches	F:	Documentation/trace/intel_th.txt
./MAINTAINERS:7428: warning: no file matches	F:	Documentation/devicetree/bindings/iio/gyroscope/inv,mpu3050.txt
./MAINTAINERS:7499: warning: no file matches	F:	drivers/staging/ipx/
./MAINTAINERS:7951: warning: no file matches	F:	include/linux/keyctl.h
./MAINTAINERS:8426: warning: no file matches	F:	arch/*/include/asm/mutex*.h
./MAINTAINERS:8572: warning: no file matches	F:	linux/platform_data/mv88e6xxx.h
./MAINTAINERS:8680: warning: no file matches	F:	drivers/hwmon/max20751.c
./MAINTAINERS:8703: warning: no file matches	F:	Documentation/devicetree/bindings/i2c/max6697.txt
./MAINTAINERS:9083: warning: no file matches	F:	Documentation/devicetree/bindings/video/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
./MAINTAINERS:9151: warning: no file matches	F:	drivers/net/ethernet/mellanox/mlx5/core/en_ipsec/*
./MAINTAINERS:9152: warning: no file matches	F:	drivers/net/ethernet/mellanox/mlx5/core/ipsec*
./MAINTAINERS:9346: warning: no file matches	F:	devicetree/bindings/media/atmel-isc.txt
./MAINTAINERS:9462: warning: no file matches	F:	arch/mips/loongson64/*{2e/2f}*
./MAINTAINERS:9465: warning: no file matches	F:	drivers/*/*/*loongson2*
./MAINTAINERS:9474: warning: no file matches	F:	drivers/*/*loongson3*
./MAINTAINERS:9475: warning: no file matches	F:	drivers/*/*/*loongson3*
./MAINTAINERS:9666: warning: no file matches	F:	Documentation/ABI/testing/mux/sysfs-class-mux*
./MAINTAINERS:9668: warning: no file matches	F:	include/linux/dt-bindings/mux/
./MAINTAINERS:9697: warning: no file matches	F:	Documentation/devicetree/bindings/display/mxsfb-drm.txt
./MAINTAINERS:9733: warning: no file matches	F:	drivers/staging/ncpfs/
./MAINTAINERS:9768: warning: no file matches	F:	driver/net/net_failover.c
./MAINTAINERS:9919: warning: no file matches	F:	net/core/flow.c
./MAINTAINERS:10245: warning: no file matches	F:	Documentation/accelerators/ocxl.txt
./MAINTAINERS:10729: warning: no file matches	F:	Documentation/misc-devices/lcd-panel-cgram.txt
./MAINTAINERS:10730: warning: no file matches	F:	drivers/misc/panel.c
./MAINTAINERS:11069: warning: no file matches	F:	Documentation/devicetree/bindings/pci/pcie-kirin.txt
./MAINTAINERS:12114: warning: no file matches	F:	drivers/iio/adc/rcar_gyro_adc.c
./MAINTAINERS:12443: warning: no file matches	F:	include/media/saa7146*
./MAINTAINERS:12460: warning: no file matches	F:	Documentation/devicetree/bindings/crypto/samsung,exynos-rng4.txt
./MAINTAINERS:12467: warning: no file matches	F:	Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
./MAINTAINERS:13058: warning: no file matches	F:	kernel/rcu/srcu.c
./MAINTAINERS:13191: warning: no file matches	F:	include/linux/sdei.h
./MAINTAINERS:13192: warning: no file matches	F:	include/uapi/linux/sdei.h
./MAINTAINERS:13294: warning: no file matches	F:	Documentation/sound/alsa/compress_offload.txt
./MAINTAINERS:13315: warning: no file matches	F:	Documentation/sound/alsa/soc/
./MAINTAINERS:13471: warning: no file matches	F:	drivers/staging/ft1000/
./MAINTAINERS:13557: warning: no file matches	F:	drivers/staging/media/st-cec/
./MAINTAINERS:13728: warning: no file matches	F:	drivers/dma/dwi-axi-dmac/
./MAINTAINERS:13797: warning: no file matches	F:	Documentation/trace/stm.txt
./MAINTAINERS:14082: warning: no file matches	F:	include/dt-bindings/genpd/k2g.h
./MAINTAINERS:14474: warning: no file matches	F:	Documentation/trace/ftrace.txt
./MAINTAINERS:14943: warning: no file matches	F:	Documentation/usb/typec.rst
./MAINTAINERS:15019: warning: no file matches	F:	fs/hppfs/
./MAINTAINERS:15143: warning: no file matches	F:	drivers/media/v4l2-core/videobuf2-*
./MAINTAINERS:15177: warning: no file matches	F:	drivers/vhost/vsock.h
./MAINTAINERS:15773: warning: no file matches	F:	Documentation/input/yealink.rst
