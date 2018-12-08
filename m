Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D30C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B0420837
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B0420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeLHMao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 07:30:44 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56921 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeLHMan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 07:30:43 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DB11220797; Sat,  8 Dec 2018 13:30:41 +0100 (CET)
Received: from localhost.localdomain (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 89D7B20711;
        Sat,  8 Dec 2018 13:30:41 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Liu Xiang <liu.xiang6@zte.com.cn>, linux-mtd@lists.infradead.org
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        marek.vasut@gmail.com, richard@nod.at,
        linux-kernel@vger.kernel.org, liuxiang_1999@126.com,
        computersforpeace@gmail.com, dwmw2@infradead.org
Subject: Re: mtd: spi-nor: Add 4B_OPCODES flag to is25lp256
Date:   Sat,  8 Dec 2018 13:30:40 +0100
Message-Id: <20181208123040.10013-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: d4a390b7325d0cb9406f2204b1a01264bfe5483a
In-Reply-To: <1542200118-3024-1-git-send-email-liu.xiang6@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-14 at 12:55:18 UTC, Liu Xiang wrote:
> The is25lp256 supports 4-byte opcodes and quad output.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris
