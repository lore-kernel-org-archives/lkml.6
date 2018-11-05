Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF47DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8854120827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8854120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbeKEQzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:55:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:52102 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbeKEQzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:55:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 23:36:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="105448754"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by orsmga001.jf.intel.com with ESMTP; 04 Nov 2018 23:36:51 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf intel-pt: Add more information to debug log
Date:   Mon,  5 Nov 2018 09:35:03 +0200
Message-Id: <20181105073505.8129-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a couple of small patches to add more information to the Intel PT
debug log.


Adrian Hunter (2):
      perf intel-pt: Add more event information to debug log
      perf intel-pt: Add MTC and CYC timestamps to debug log

 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |  4 ++++
 tools/perf/util/intel-pt-decoder/intel-pt-log.c     |  5 +++++
 tools/perf/util/intel-pt-decoder/intel-pt-log.h     |  1 +
 tools/perf/util/intel-pt.c                          | 16 +++++++++++++---
 4 files changed, 23 insertions(+), 3 deletions(-)


Regards
Adrian
