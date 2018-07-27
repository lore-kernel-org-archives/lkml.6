Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0530BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28BE20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28BE20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbeG0Bvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 21:51:36 -0400
Received: from trent.utfs.org ([94.185.90.103]:34210 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731855AbeG0Bvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 21:51:36 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jul 2018 21:51:35 EDT
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id DD43660145;
        Fri, 27 Jul 2018 02:25:26 +0200 (CEST)
Date:   Thu, 26 Jul 2018 17:25:26 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Gao Xiang <gaoxiang25@huawei.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] staging: erofs: introduce erofs file system
In-Reply-To: <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
Message-ID: <alpine.DEB.2.21.999.1807261707460.11672@trent.utfs.org>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com> <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
User-Agent: Alpine 2.21.999 (DEB 277 2018-05-20)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018, Gao Xiang wrote:
> EROFS file system is a read-only file system with compression
> support designed for certain devices (especially embeded
> devices) with very limited physical memory and lots of memory

Out of curiousity, and as Richard already asked[0] - what about existing 
file system, why can't they be used or extended instead of introducing yet 
another file system into the kernel? JFFS2? UBIFS? CramFs? SquashFS? 
ROMFS? F2FS? YAFFS?

Christian.

[0] https://marc.info/?l=linux-kernel&m=152783930418348&w=2
-- 
BOFH excuse #247:

Due to Federal Budget problems we have been forced to cut back on the number of users able to access the system at one time. (namely none allowed....)
