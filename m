Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32534ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075F221479
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075F221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeJ0CDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:03:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37590 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJ0CDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:03:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gG5rq-0005GI-9y; Fri, 26 Oct 2018 17:25:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jeremy Kerr <jk@ozlabs.org>, Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: fix spelling mistake, EACCESS -> EACCES
Date:   Fri, 26 Oct 2018 18:25:49 +0100
Message-Id: <20181026172549.3628-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to a spelling mistake of the error access name EACCESS,
rename to EACCES

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 Documentation/filesystems/spufs.txt | 2 +-
 Documentation/gpu/drm-uapi.rst      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/spufs.txt b/Documentation/filesystems/spufs.txt
index 1343d118a9b2..eb9e3aa63026 100644
--- a/Documentation/filesystems/spufs.txt
+++ b/Documentation/filesystems/spufs.txt
@@ -452,7 +452,7 @@ RETURN VALUE
 
 
 ERRORS
-       EACCESS
+       EACCES
               The  current  user does not have write access on the spufs mount
               point.
 
diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index a2214cc1f821..f2f079e91b4c 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -190,11 +190,11 @@ ENOSPC:
 
         Simply running out of kernel/system memory is signalled through ENOMEM.
 
-EPERM/EACCESS:
+EPERM/EACCES:
         Returned for an operation that is valid, but needs more privileges.
         E.g. root-only or much more common, DRM master-only operations return
         this when when called by unpriviledged clients. There's no clear
-        difference between EACCESS and EPERM.
+        difference between EACCES and EPERM.
 
 ENODEV:
         Feature (like PRIME, modesetting, GEM) is not supported by the driver.
-- 
2.19.1

