Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFA9C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C47206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C47206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeI2EXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:23:00 -0400
Received: from smtprelay0222.hostedemail.com ([216.40.44.222]:34696 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbeI2EW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:22:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4AE8D180A8862;
        Fri, 28 Sep 2018 21:57:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: music40_7995bf7af8c31
X-Filterd-Recvd-Size: 1627
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:57:15 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        linux-media@vger.kernel.org
Subject: Bad MAINTAINERS pattern in section 'MICROCHIP ISC DRIVER'
Date:   Fri, 28 Sep 2018 14:57:14 -0700
Message-Id: <20180928215714.30346-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	9542	MICROCHIP ISC DRIVER
	9543	M:	Eugen Hristev <eugen.hristev@microchip.com>
	9544	L:	linux-media@vger.kernel.org
	9545	S:	Supported
	9546	F:	drivers/media/platform/atmel/atmel-isc.c
	9547	F:	drivers/media/platform/atmel/atmel-isc-regs.h
-->	9548	F:	devicetree/bindings/media/atmel-isc.txt

Commit that introduced this:

commit 71fb2c74287d186938cde830ad8980f57a38b597
 Author: Songjun Wu <songjun.wu@microchip.com>
 Date:   Wed Aug 17 03:05:29 2016 -0300
 
     [media] MAINTAINERS: atmel-isc: add entry for Atmel ISC
     
     Add the MAINTAINERS' entry for Microchip / Atmel Image Sensor Controller.
     
     Signed-off-by: Songjun Wu <songjun.wu@microchip.com>
     Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
     Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
     Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
 
  MAINTAINERS | 8 ++++++++
  1 file changed, 8 insertions(+)

No commit with devicetree/bindings/media/atmel-isc.txt found

