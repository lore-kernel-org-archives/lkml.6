Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E10C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D012073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D012073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeI2E1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:27:39 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:54590 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726393AbeI2E1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:27:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 75EC0837F243;
        Fri, 28 Sep 2018 22:01:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: birds42_108e3d31b503d
X-Filterd-Recvd-Size: 1888
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:01:53 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Vasut <marek.vasut@gmail.com>, linux-iio@vger.kernel.org
Subject: Bad MAINTAINERS pattern in section 'RENESAS R-CAR GYROADC DRIVER'
Date:   Fri, 28 Sep 2018 15:01:52 -0700
Message-Id: <20180928220152.31151-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	12496	RENESAS R-CAR GYROADC DRIVER
	12497	M:	Marek Vasut <marek.vasut@gmail.com>
	12498	L:	linux-iio@vger.kernel.org
	12499	S:	Supported
-->	12500	F:	drivers/iio/adc/rcar_gyro_adc.c

Commit that introduced this:

commit 059c53b3232960cfd38cc46de0a7bedd642021f5
 Author: Marek Vasut <marek.vasut+renesas@gmail.com>
 Date:   Sat Jan 28 00:08:37 2017 +0100
 
     iio: adc: Add Renesas GyroADC driver
     
     Add IIO driver for the Renesas RCar GyroADC block. This block is a
     simple 4/8-channel ADC which samples 12/15/24 bits of data every
     cycle from all channels.
     
     Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
     Cc: Geert Uytterhoeven <geert+renesas@glider.be>
     Cc: Simon Horman <horms+renesas@verge.net.au>
     Cc: Jonathan Cameron <jic23@kernel.org>
     Cc: linux-renesas-soc@vger.kernel.org
     Cc: Wolfram Sang <wsa@the-dreams.de>
     Signed-off-by: Jonathan Cameron <jic23@kernel.org>
 
  MAINTAINERS                    |   6 +
  drivers/iio/adc/Kconfig        |  13 +
  drivers/iio/adc/Makefile       |   1 +
  drivers/iio/adc/rcar-gyroadc.c | 631 +++++++++++++++++++++++++++++++++++++++++
  4 files changed, 651 insertions(+)

No commit with drivers/iio/adc/rcar_gyro_adc.c found

