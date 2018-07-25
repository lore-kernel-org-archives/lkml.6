Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBDAC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CC420852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CC420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeGYEaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 00:30:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:47669 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbeGYEaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 00:30:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 20:20:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="69673636"
Received: from shawn-bm6650-bm6350.itwn.intel.com ([10.5.253.27])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2018 20:20:50 -0700
From:   alanx.chiang@intel.com
To:     linux-i2c@vger.kernel.org
Cc:     andy.yeh@intel.com, sakari.ailus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com,
        rajmohan.mani@intel.com, andy.shevchenko@gmail.com,
        tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        rpjday@crashcourse.ca, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alan Chiang <alanx.chiang@intel.com>
Subject: [RESEND PATCH v4 0/2] Add aproperty in at24.c
Date:   Wed, 25 Jul 2018 11:20:20 +0800
Message-Id: <1532488822-5622-1-git-send-email-alanx.chiang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Chiang <alanx.chiang@intel.com>

The RESEND PATCH modifies the commit message and adds the Reviewed-by.

In at24.c, it uses 8-bit addressing by default. In this patch add a
property address-width that provides a flexible method to pass the
information to the driver.

Alan Chiang (2):
  dt-bindings: at24: Add address-width property
  eeprom: at24: Add support for address-width property

 Documentation/devicetree/bindings/eeprom/at24.txt |  2 ++
 drivers/misc/eeprom/at24.c                        | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

-- 
2.7.4

