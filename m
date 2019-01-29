Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DE8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C0E20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762263;
	bh=eJ74j1a/X2zkh8XJkQeLBnNUKHaYd3osDOYuC4Uzq74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vHKmlY23UJhDigmdhQwzpwZcnrqC29AfxOYbWcJFooamLcIol+tMd4mNg27Dgv7Bk
	 VUYTFoplIlo2NHn270eRM1YG6XUdmWR1c2LK77WFIojTyjwaB/F+nxUFSbRGUxGMAN
	 8cq0xS1RNejaQKEpDacDIyiU7l/7PrzEbAuQPkXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfA2LoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:44:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbfA2LoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:44:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCCD02083B;
        Tue, 29 Jan 2019 11:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762257;
        bh=eJ74j1a/X2zkh8XJkQeLBnNUKHaYd3osDOYuC4Uzq74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gzh9/yo8f7xKrJGl94aq3yIR+IAyrav1a5CQ8oyaREEm3IuPNrE09CcI1USmZrenN
         Q5/d8DJ62cD9M6zVY/oKqS90PuDigDGIlHFMwMYWDjNvS6rculCc0gNHZW+RWo+mib
         G5wwbk9Yr0LbiPsk4agQvIABLevS0V4Stqdl2cTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woods <dwoods@mellanox.com>,
        Liming Sun <lsun@mellanox.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 044/103] mmc: dw_mmc-bluefield: : Fix the license information
Date:   Tue, 29 Jan 2019 12:35:21 +0100
Message-Id: <20190129113202.134708713@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liming Sun <lsun@mellanox.com>

commit f3716b8ae9347797b73896725f192c3a7b0069b5 upstream.

The SPDX license identifier and the boiler plate text are
contradicting. Only the SPDX license identifier is needed. The
other one is removed.

Fixes: 86958dcc5ad7 ("mmc: dw_mmc-bluefield: Add driver extension")
Cc: stable@vger.kernel.org
Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/dw_mmc-bluefield.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/drivers/mmc/host/dw_mmc-bluefield.c
+++ b/drivers/mmc/host/dw_mmc-bluefield.c
@@ -1,11 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2018 Mellanox Technologies.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #include <linux/bitfield.h>


