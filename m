Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2373C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7FA20652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7FA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeICRxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:53:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:11417 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeICRxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:53:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 06:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,325,1531810800"; 
   d="scan'208";a="229822752"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 03 Sep 2018 06:33:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A4033BB; Mon,  3 Sep 2018 16:33:04 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 0/3] thunderbolt: Miscellaneous cleanups
Date:   Mon,  3 Sep 2018 16:33:01 +0300
Message-Id: <20180903133304.70362-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a couple of changes which have been in my TODO list some time
already but have not had time to make a proper patch out of them until now.

Mika Westerberg (3):
  thunderbolt: Make the driver less verbose
  thunderbolt: Convert rest of the driver files to use SPDX identifier
  thunderbolt: Add Intel as copyright holder

 drivers/thunderbolt/cap.c      |  3 +-
 drivers/thunderbolt/ctl.c      |  9 ++---
 drivers/thunderbolt/ctl.h      |  3 +-
 drivers/thunderbolt/dma_port.c |  5 +--
 drivers/thunderbolt/dma_port.h |  5 +--
 drivers/thunderbolt/domain.c   |  7 ++--
 drivers/thunderbolt/eeprom.c   |  5 +--
 drivers/thunderbolt/icm.c      |  5 +--
 drivers/thunderbolt/nhi.c      | 33 ++++++++++---------
 drivers/thunderbolt/nhi.h      |  3 +-
 drivers/thunderbolt/nhi_regs.h |  1 +
 drivers/thunderbolt/path.c     | 26 +++++++--------
 drivers/thunderbolt/property.c |  5 +--
 drivers/thunderbolt/switch.c   | 60 ++++++++++++++++------------------
 drivers/thunderbolt/tb.c       | 10 +++---
 drivers/thunderbolt/tb.h       |  9 +++--
 drivers/thunderbolt/tb_msgs.h  |  5 +--
 drivers/thunderbolt/tb_regs.h  |  3 +-
 drivers/thunderbolt/xdomain.c  |  5 +--
 include/linux/thunderbolt.h    |  5 +--
 20 files changed, 96 insertions(+), 111 deletions(-)

-- 
2.18.0

