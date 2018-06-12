Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 63EE0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C02208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C02208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934025AbeFLKYF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:24:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:34386 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933919AbeFLKXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:23:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 03:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,214,1526367600"; 
   d="scan'208";a="66322106"
Received: from hao-dev.bj.intel.com ([10.238.157.61])
  by orsmga002.jf.intel.com with ESMTP; 12 Jun 2018 03:23:29 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v6 29/29] MAINTAINERS: add entry for FPGA DFL drivers
Date:   Tue, 12 Jun 2018 18:10:43 +0800
Message-Id: <1528798243-2029-30-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for FPGA Device Feature List (DFL) drivers.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 448957c..98fc5ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5619,6 +5619,14 @@ F:	drivers/fpga/
 F:	include/linux/fpga/
 W:	http://www.rocketboards.org
 
+FPGA DFL DRIVERS
+M:	Wu Hao <hao.wu@intel.com>
+L:	linux-fpga@vger.kernel.org
+S:	Maintained
+F:	Documentation/fpga/dfl.txt
+F:	include/uapi/linux/fpga-dfl.h
+F:	drivers/fpga/dfl*
+
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
 W:	http://floatingpoint.sourceforge.net/emulator/index.html
-- 
1.8.3.1

