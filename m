Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A601CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74553206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74553206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeI2Eai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:30:38 -0400
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:60404 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726569AbeI2Eai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:30:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 61A71100E806B;
        Fri, 28 Sep 2018 22:04:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: snail70_2a755c297550b
X-Filterd-Recvd-Size: 1906
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:04:51 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Bad MAINTAINERS pattern in section 'SYNOPSYS DESIGNWARE AXI DMAC DRIVER'
Date:   Fri, 28 Sep 2018 15:04:50 -0700
Message-Id: <20180928220450.31731-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	14171	SYNOPSYS DESIGNWARE AXI DMAC DRIVER
	14172	M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
	14173	S:	Maintained
-->	14174	F:	drivers/dma/dwi-axi-dmac/
	14175	F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt

Commit that introduced this:

commit 1fe20f1b84548bbcf48b6659ea171cd46618ea3a
 Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 Date:   Tue Mar 6 14:46:14 2018 +0300
 
     dmaengine: Introduce DW AXI DMAC driver
     
     This patch adds support for the DW AXI DMAC controller.
     DW AXI DMAC is a part of HSDK development board from Synopsys.
     
     In this driver implementation only DMA_MEMCPY transfers are
     supported.
     
     Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
     Signed-off-by: Vinod Koul <vinod.koul@intel.com>
 
  MAINTAINERS                                    |    6 +
  drivers/dma/Kconfig                            |   10 +
  drivers/dma/Makefile                           |    1 +
  drivers/dma/dw-axi-dmac/Makefile               |    1 +
  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 1008 ++++++++++++++++++++++++
  drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  334 ++++++++
  6 files changed, 1360 insertions(+)

No commit with drivers/dma/dwi-axi-dmac/ found

