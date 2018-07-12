Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0031AECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B1F20841
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="OM9ew+Ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B1F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbeGLTpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:45:08 -0400
Received: from mout01.posteo.de ([185.67.36.65]:58640 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732195AbeGLTpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:45:08 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id E0C24212A8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 21:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1531424048; bh=HzXnyTbjgNTn1U4q8VbHhbLiNvNNHetxbCxymzMpBCM=;
        h=From:To:Cc:Subject:Date:From;
        b=OM9ew+UghfnoRjl4DpupfQRhWOz2JU6LiyZ44YnYbgZX5SmMC6LsD/1bB97nPtIKn
         0Jh+7riK7snJC9eTLnckS74TlTJ6yDvKL9okJQnJP9rcuWhlD8FLS9TguXp5IxzZCW
         hSjdibr3NquHplrkpv/4G3c2Dw1XZHATiv1ynogWC5p1WhmQiM8hg4bCpv2F+aJaJe
         RG7l7DKfu/74/LWTyjrGiwvziQ4XguMabYWkuypLFGKRdAKoW780qlERIukmc74Dus
         ccBr2OzK3972GOBucyt+yCzBm+QZ1Y1mucPItt0M2OHZjFlePaztlIiZZGFKEBPP/M
         RpkWOiwVibwxg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41RR2S2MPkz9rxN;
        Thu, 12 Jul 2018 21:34:08 +0200 (CEST)
From:   Felix Siegel <felix.siegel@posteo.de>
To:     devel@driverdev.osuosl.org
Cc:     Felix Siegel <felix.siegel@posteo.de>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: gasket: Move open-curly brace to match kernel code style
Date:   Thu, 12 Jul 2018 21:27:13 +0200
Message-Id: <1531423694-22478-2-git-send-email-felix.siegel@posteo.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531423694-22478-1-git-send-email-felix.siegel@posteo.de>
References: <1531423694-22478-1-git-send-email-felix.siegel@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move open open-curly brace to the next line following function
definition to match the kernel's coding style

Signed-off-by: Felix Siegel <felix.siegel@posteo.de>
---
 drivers/staging/gasket/gasket_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 24e85fb..d7fdfa1 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1895,7 +1895,8 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 EXPORT_SYMBOL(gasket_reset_nolock);
 
 gasket_ioctl_permissions_cb_t gasket_get_ioctl_permissions_cb(
-	struct gasket_dev *gasket_dev) {
+	struct gasket_dev *gasket_dev)
+{
 	return gasket_dev->internal_desc->driver_desc->ioctl_permissions_cb;
 }
 EXPORT_SYMBOL(gasket_get_ioctl_permissions_cb);
-- 
2.7.4

