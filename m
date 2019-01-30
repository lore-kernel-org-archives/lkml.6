Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5238BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC79320881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548889381;
	bh=j0owkHb3DVcvSqk90+G44AH9UDHA/o2x4AmQgr4bBzo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=f3Ob/lDyoqTwDpZgzT4VuDrU6qDeStt7C1U5W4wdvYiaYBucnZ0/lOLvHqo29VSla
	 XS1Srh8uyJ4gA3u1wi6e0h3NaiWslb2uIw6HGkZW2VhwRjRDlDFFsZLzevgE53LFHF
	 Z8jKvIVmRlZMJV2soMndxC+1jasfbiPetAqRWWGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfA3XC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:02:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56360 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfA3XC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/CZMSZMYu9YPQRrPeLXyVJNZLqkwmYr5K+jYa0xEIms=; b=rXYKwXJDGRyk
        7kBePhcLohZjkXsPHsbVSY0kpr7OjBLco49uuXNMQl3kW9LngFNBUjgHmP6RyriiUkWUiTYjT/jg3
        Mc7+Bxg2+r5P6C3FA+oz+4WukBG1GMb46G6JJv15A1n84yRhsxi6NAi8df03AZfGFZOTEPtkCU6XX
        DFg7s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goyse-0000DJ-TK; Wed, 30 Jan 2019 23:02:53 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id EC35C440082; Wed, 30 Jan 2019 23:02:50 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: support inter-word delay requirement for devices" to the spi tree
In-Reply-To:  <20190130084005.18649-2-jonas@norrbonn.se>
X-Patchwork-Hint: ignore
Message-Id: <20190130230250.EC35C440082@finisterre.ee.mobilebroadband>
Date:   Wed, 30 Jan 2019 23:02:50 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: support inter-word delay requirement for devices

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From b7bb367afa4bf9de60830683305c63030c3e581d Mon Sep 17 00:00:00 2001
From: Jonas Bonn <jonas@norrbonn.se>
Date: Wed, 30 Jan 2019 09:40:04 +0100
Subject: [PATCH] spi: support inter-word delay requirement for devices

Some devices are slow and cannot keep up with the SPI bus and therefore
require a short delay between words of the SPI transfer.

The example of this that I'm looking at is a SAMA5D2 with a minimum SPI
clock of 400kHz talking to an AVR-based SPI slave.  The AVR cannot put
bytes on the bus fast enough to keep up with the SoC's SPI controller
even at the lowest bus speed.

This patch introduces the ability to specify a required inter-word
delay for SPI devices.  It is up to the controller driver to configure
itself accordingly in order to introduce the requested delay.

Note that, for spi_transfer, there is already a field word_delay that
provides similar functionality.  This field, however, is specified in
clock cycles (and worse, SPI controller cycles, not SCK cycles); that
makes this value dependent on the master clock instead of the device
clock for which the delay is intended to provide some relief.  This
patch leaves this old word_delay in place and provides a time-based
word_delay_us alongside it; the new field fits in the struct padding
so struct size is constant.  There is only one in-kernel user of the
word_delay field and presumably that driver could be reworked to use
the time-based value instead.

The time-based delay is limited to 8 bits as these delays are intended
to be short.  The SAMA5D2 that I've tested this on limits delays to a
maximum of ~100us, which is already many word-transfer periods even at
the minimum transfer speed supported by the controller.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: linux-spi@vger.kernel.org
CC: devicetree@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 5 +++++
 include/linux/spi/spi.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0e0f2c62973c..2f7176f07591 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3050,6 +3050,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	 * it is not set for this transfer.
 	 * Set transfer tx_nbits and rx_nbits as single transfer default
 	 * (SPI_NBITS_SINGLE) if it is not set for this transfer.
+	 * Ensure transfer word_delay is at least as long as that required by
+	 * device itself.
 	 */
 	message->frame_length = 0;
 	list_for_each_entry(xfer, &message->transfers, transfer_list) {
@@ -3120,6 +3122,9 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				!(spi->mode & SPI_RX_QUAD))
 				return -EINVAL;
 		}
+
+		if (xfer->word_delay_usecs < spi->word_delay_usecs)
+			xfer->word_delay_usecs = spi->word_delay_usecs;
 	}
 
 	message->status = -EINPROGRESS;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 916bba47d156..662b336aa2e4 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -122,6 +122,8 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  *	the spi_master.
  * @cs_gpiod: gpio descriptor of the chipselect line (optional, NULL when
  *	not using a GPIO line)
+ * @word_delay_usecs: microsecond delay to be inserted between consecutive
+ *	words of a transfer
  *
  * @statistics: statistics for the spi_device
  *
@@ -169,6 +171,7 @@ struct spi_device {
 	const char		*driver_override;
 	int			cs_gpio;	/* LEGACY: chip select gpio */
 	struct gpio_desc	*cs_gpiod;	/* chip select gpio desc */
+	uint8_t			word_delay_usecs; /* inter-word delay */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
@@ -721,6 +724,8 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
+ * @word_delay_usecs: microseconds to inter word delay after each word size
+ *	(set by bits_per_word) transmission.
  * @word_delay: clock cycles to inter word delay after each word size
  *	(set by bits_per_word) transmission.
  * @transfer_list: transfers are sequenced through @spi_message.transfers
@@ -803,6 +808,7 @@ struct spi_transfer {
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
+	u8		word_delay_usecs;
 	u16		delay_usecs;
 	u32		speed_hz;
 	u16		word_delay;
-- 
2.20.1

