Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539CCECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092A22086B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092A22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeIRSnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:43:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:13543 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbeIRSnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:43:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 06:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="87121846"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Sep 2018 06:11:01 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 0/3] intel_th: Fixes for v4.19
Date:   Tue, 18 Sep 2018 16:10:46 +0300
Message-Id: <20180918131049.74840-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are fixes that I'd like to get into v4.19. Both bugfixes are
backportable. Individual patches follow. Please consider pulling
or applying.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-fixes-for-greg-20180918

for you to fetch changes up to 7f97d5f35010ae88d004ae64dc00e6e27638e2c9:

  intel_th: pci: Add Ice Lake PCH support (2018-09-18 15:48:08 +0300)

----------------------------------------------------------------
intel_th: Fixes for v4.19

These are:
  * a fix for ACPI glue layer
  * a fix for host mode (also applicable to ACPI)
  * a new PCI ID.

The fixes are both backportable.

----------------------------------------------------------------
Alexander Shishkin (3):
      intel_th: Fix device removal logic
      intel_th: Fix resource handling for ACPI glue layer
      intel_th: pci: Add Ice Lake PCH support

 drivers/hwtracing/intel_th/core.c | 16 +++++++++++++---
 drivers/hwtracing/intel_th/pci.c  |  5 +++++
 2 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.18.0

