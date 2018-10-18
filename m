Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2B8ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF26B21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF26B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeJRQ4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:56:17 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:56151 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727360AbeJRQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:56:16 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id w9I8coKS003544
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:38:50 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9I8cibm003507;
        Thu, 18 Oct 2018 16:38:44 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 18 Oct 2018
 16:36:49 +0800
From:   Nickhu <nickhu@andestech.com>
To:     <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <deanbo422@gmail.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>
CC:     Nickhu <nickhu@andestech.com>, <green.hu@gmail.com>
Subject: [PATCH 0/1] Perf: Compile failed when compile with libelf.
Date:   Thu, 18 Oct 2018 16:36:45 +0800
Message-ID: <cover.1539654517.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9I8cibm003507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix perf failed when compile with libelf.

Nickhu (1):
  Perf: Compile failed when compile with libelf.

 tools/perf/util/symbol-elf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.0

