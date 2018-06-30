Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72562C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233FC254E2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linuxvaults.com header.i=@linuxvaults.com header.b="IxRuTNtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233FC254E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxvaults.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbeF3PJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 11:09:59 -0400
Received: from crystal.urlnameserver.com ([99.198.127.110]:34640 "EHLO
        crystal.urlnameserver.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750802AbeF3PJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 11:09:57 -0400
X-Greylist: delayed 2344 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Jun 2018 11:09:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linuxvaults.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sWCW2tODdhfKYmdSuSUzwg5LRsm9CeXCF7JIneIBLMU=; b=IxRuTNtSl7n4JzFhijltwMilEK
        nEDtS/7S6y9ZSD6yEtZWF6ZQ7n8jGxQtIGaA+sygAw0fZLNNhbD1l0X69BU3BRRTy0rnXtQ3xk5mL
        B1w7Qj9lcXovRcCp/eA8rqHBtMpqlrl7hLwMf2gDXAUYUW2beatABF8brGXeYwPH3f5cj6HsleZEY
        1sNJ8SBfp43I7+3tmUEkASVlJ3KHFRG0XTkFXW9kP9F7DMeRvjF683T4cpN+cpzHC/xcQxBvYGe0n
        O3LrXJ53KvKF2C5B1f74MinwlorqeytCwU23nWEHneLR/58k0DE1H3i0RQddneZAe9i9b65yzvp2E
        ciBid7kg==;
Received: from [206.189.122.65] (port=34074 helo=kernel.local.domain)
        by crystal.urlnameserver.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <tsuliman@linuxvaults.com>)
        id 1fZGtf-000586-Sp; Sat, 30 Jun 2018 09:30:44 -0500
From:   Tamir Suliman <tsuliman@linuxvaults.com>
To:     ganesanr@broadcom.com, gregkh@linuxfoundation.org
Cc:     jchandra@broadcom.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, tsuliman@linuxvaults.com
Subject: [PATCH 2/2] NETLOGIC: Kconfig: Fixed help  and coding style warnings
Date:   Sat, 30 Jun 2018 14:30:44 +0000
Message-Id: <1530369044-23734-1-git-send-email-tsuliman@linuxvaults.com>
X-Mailer: git-send-email 1.8.3.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - crystal.urlnameserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxvaults.com
X-Get-Message-Sender-Via: crystal.urlnameserver.com: authenticated_id: tsuliman@linuxvaults.com
X-Authenticated-Sender: crystal.urlnameserver.com: tsuliman@linuxvaults.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed Coding style issues

Signed-off-by: Tamir Suliman <tsuliman@linuxvaults.com>
---
 drivers/staging/netlogic/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/netlogic/Kconfig b/drivers/staging/netlogic/Kconfig
index d660de5..6e8e56a 100644
--- a/drivers/staging/netlogic/Kconfig
+++ b/drivers/staging/netlogic/Kconfig
@@ -2,6 +2,8 @@ config NETLOGIC_XLR_NET
 	tristate "Netlogic XLR/XLS network device"
 	depends on CPU_XLR
 	select PHYLIB
-	---help---
+	help
 	This driver support Netlogic XLR/XLS on chip gigabit
-	Ethernet.
+	Ethernet.The XLR/XLS NAE blocks can be configured as one 10G
+	interface or four 1G interfaces. This driver supports blocks
+	with 1G ports.
-- 
1.8.3.1

