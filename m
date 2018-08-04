Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DD0C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AFC2177A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AFC2177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389195AbeHDLL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:11:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732670AbeHDLL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:11:29 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2FF2BC6;
        Sat,  4 Aug 2018 09:11:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Engestrom <eric.engestrom@imgtec.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vinod.koul@intel.com>,
        Andrea Adami <andrea.adami@gmail.com>
Subject: [PATCH 4.4 100/124] dmaengine: pxa_dma: remove duplicate const qualifier
Date:   Sat,  4 Aug 2018 11:01:29 +0200
Message-Id: <20180804082706.218123491@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Engestrom <eric.engestrom@imgtec.com>

commit 4e0def887d717598ae8062b46e55f9e00d3a5783 upstream.

Signed-off-by: Eric Engestrom <eric.engestrom@imgtec.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Cc: Andrea Adami <andrea.adami@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/pxa_dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1321,7 +1321,7 @@ static int pxad_init_phys(struct platfor
 	return 0;
 }
 
-static const struct of_device_id const pxad_dt_ids[] = {
+static const struct of_device_id pxad_dt_ids[] = {
 	{ .compatible = "marvell,pdma-1.0", },
 	{}
 };


