Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2372ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7A02075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7A02075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeGRKhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:37:21 -0400
Received: from ozlabs.org ([203.11.71.1]:40805 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbeGRKhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:37:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Vt1S187Jz9s0w;
        Wed, 18 Jul 2018 20:00:10 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michael Hanselmann <linux-kernel@hansmi.ch>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: [PATCH] Mark ams driver as orphaned in MAINTAINERS
In-Reply-To: <8fe08e4d44c56ee0b70517fc8609ab5a116bc407.1517265227.git.linux-kernel@hansmi.ch>
References: <8fe08e4d44c56ee0b70517fc8609ab5a116bc407.1517265227.git.linux-kernel@hansmi.ch>
Date:   Wed, 18 Jul 2018 20:00:10 +1000
Message-ID: <877elsq2xh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hanselmann <linux-kernel@hansmi.ch> writes:

> I no longer have any hardware with the Apple motion sensor and thus
> relinquish maintainership of the driver.

Thanks. I think I'll just remove the whole entry, meaning it will be
caught under the "LINUX FOR POWER MACINTOSH" entry.

Unless you object. Full patch below.

cheers

commit 19fe15338d6935c1a61a24b83dd315970b1ba162
Author:     Michael Hanselmann <linux-kernel@hansmi.ch>
AuthorDate: Mon Jan 29 22:40:09 2018 +0000
Commit:     Michael Ellerman <mpe@ellerman.id.au>
CommitDate: Wed Jul 18 19:57:42 2018 +1000

    MAINTAINERS: Remove the entry for the orphaned ams driver
    
    I no longer have any hardware with the Apple motion sensor and thus
    relinquish maintainership of the driver.
    
    Remove the maintainers entry entirely, meaning the code will now fall
    under "LINUX FOR POWER MACINTOSH".
    
    Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
    [mpe: Drop the entry entirely, munge change log]
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

diff --git a/MAINTAINERS b/MAINTAINERS
index 07d1576fc766..50e398a463f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -791,11 +791,6 @@ S:	Supported
 F:	drivers/net/ethernet/amd/xgbe/
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 
-AMS (Apple Motion Sensor) DRIVER
-M:	Michael Hanselmann <linux-kernel@hansmi.ch>
-S:	Supported
-F:	drivers/macintosh/ams/
-
 ANALOG DEVICES INC AD5686 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-pm@vger.kernel.org

