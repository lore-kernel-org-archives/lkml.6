Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5FEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BB8208B9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BB8208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932922AbeFTInW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:43:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60000 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753918AbeFTInT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:43:19 -0400
Received: from 79.184.254.22.ipv4.supernova.orange.pl (79.184.254.22) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id f14872fb8361ec6f; Wed, 20 Jun 2018 10:43:17 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation: intel_pstate: Fix typo
Date:   Wed, 20 Jun 2018 10:42:07 +0200
Message-ID: <1536315.piAVWLTAmD@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fix a typo in the intel_pstate admin-guide documentation.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
@@ -410,7 +410,7 @@ argument is passed to the kernel in the
 	That only is supported in some configurations, though (for example, if
 	the `HWP feature is enabled in the processor <Active Mode With HWP_>`_,
 	the operation mode of the driver cannot be changed), and if it is not
-	supported in the current configuration, writes to this attribute with
+	supported in the current configuration, writes to this attribute will
 	fail with an appropriate error.
 
 Interpretation of Policy Attributes

