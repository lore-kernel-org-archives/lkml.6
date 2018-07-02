Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60287C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3E5258D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3E5258D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbeGBDyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 23:54:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:43408 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751675AbeGBDyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 23:54:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2018 20:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,297,1526367600"; 
   d="scan'208";a="63693710"
Received: from keunhyun-mobl1.amr.corp.intel.com (HELO haswell-OptiPlex-9020.ccr.corp.intel.com) ([10.255.29.56])
  by orsmga003.jf.intel.com with ESMTP; 01 Jul 2018 20:54:02 -0700
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH 0/3] fix selftests compiling errors and warnings
Date:   Mon,  2 Jul 2018 11:53:51 +0800
Message-Id: <1530503634-32241-1-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Li Zhijian (3):
  selftests/android: fix compiling error
  selftests/android: initialize heap_type to avoid compiling warning
  selftests/gpio: unset OUTPUT for build tools/gpio

 tools/testing/selftests/android/ion/Makefile        | 5 ++++-
 tools/testing/selftests/android/ion/ionapp_export.c | 7 +++++++
 tools/testing/selftests/gpio/Makefile               | 2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.7.4

