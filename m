Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058EEC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 04:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEF42086C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 04:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BsBfSa/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfAMEaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 23:30:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfAMEaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 23:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Dy+0b9UXhNoCmQhCXWQVvnll7Mzz2rsBUuo208VxTt8=; b=BsBfSa/DpZBwR39HiThH3c1eje
        Doi+mGSgSJKVUvwhf7Azi0ivg+htY5DZ03xAyUly/EOkHv1N3r51wdybSuo720brSreypOHDPqC/5
        WkmojzEVKwMCddQv+aQVSoVjNHqdtlkrJBA2SpGAAdvG/8qu5a7nrhJDvj1v6rUwSoEcq5Gu16xBA
        cr1+k5tgTbm+MyhqRzCvP4fwZPdyp9kmXDQU3kgKaoyLsQLWvdPEXqm93WcRzU+XyWRo9j/0+7KxL
        p56KQtuzwIV04BX/NhGyIHtzel7xtuTTCgsEk0PATRo/oRE+sYU8quqfifkVLleSrdR/jAbVdKRwt
        YLcQ30AA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giXPY-0000Si-5I; Sun, 13 Jan 2019 04:30:12 +0000
Date:   Sat, 12 Jan 2019 20:30:10 -0800
From:   "Darren Hart (VMware)" <dvhart@infradead.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Cc:     Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH] Documentation/ABI: Correct mlxreg-io KernelVersion for 5.0
Message-ID: <a15008d9dcde1653c22393e64eb83a07d4750caa.1547353746.git.dvhart@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mlxreg-io for the merge window assumed 4.21 as the next kernel
version. Replace 4.21 with 5.0.

Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
 Documentation/ABI/stable/sysfs-driver-mlxreg-io | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
index 9b642669cb16..169fe08a649b 100644
--- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -24,7 +24,7 @@ What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
 							cpld3_version
 
 Date:		November 2018
-KernelVersion:	4.21
+KernelVersion:	5.0
 Contact:	Vadim Pasternak <vadimpmellanox.com>
 Description:	These files show with which CPLD versions have been burned
 		on LED board.
@@ -35,7 +35,7 @@ What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
 							jtag_enable
 
 Date:		November 2018
-KernelVersion:	4.21
+KernelVersion:	5.0
 Contact:	Vadim Pasternak <vadimpmellanox.com>
 Description:	These files enable and disable the access to the JTAG domain.
 		By default access to the JTAG domain is disabled.
@@ -105,7 +105,7 @@ What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
 						reset_voltmon_upgrade_fail
 
 Date:		November 2018
-KernelVersion:	4.21
+KernelVersion:	5.0
 Contact:	Vadim Pasternak <vadimpmellanox.com>
 Description:	These files show the system reset cause, as following: ComEx
 		power fail, reset from ComEx, system platform reset, reset
-- 
2.17.2


-- 
Darren Hart
VMware Open Source Technology Center
