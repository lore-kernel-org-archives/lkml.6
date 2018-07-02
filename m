Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75039C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B71253A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B71253A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbeGBJMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:12:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:19055 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752068AbeGBJM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:12:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 02:12:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,298,1526367600"; 
   d="scan'208";a="68936126"
Received: from shawn-bm6650-bm6350.itwn.intel.com ([10.5.253.27])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jul 2018 02:12:24 -0700
From:   alanx.chiang@intel.com
To:     linux-i2c@vger.kernel.org
Cc:     andy.yeh@intel.com, sakari.ailus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com,
        rajmohan.mani@intel.com, andy.shevchenko@gmail.com,
        tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Alan Chiang <alanx.chiang@intel.com>
Subject: [RESEND PATCH v4 0/2] Add a property in at24.c
Date:   Mon,  2 Jul 2018 17:12:18 +0800
Message-Id: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Chiang <alanx.chiang@intel.com>

This RESEND PATCH only adds the Acked-by and Reviewed-by,
no other patch for the codes.

In at24.c, it uses 8-bit addressing by default. In this patch,
add a property address-width that provides a flexible method to
pass the information to the driver.

Alan Chiang (2):
  dt-bindings: at24: Add address-width property
  eeprom: at24: Add support for address-width property

 Documentation/devicetree/bindings/eeprom/at24.txt |  2 ++
 drivers/misc/eeprom/at24.c                        | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

-- 
2.7.4

