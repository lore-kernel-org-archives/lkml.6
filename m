Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0308ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C6720848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNf//Rz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C6720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeJYTnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbeJYTnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:43:50 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E22112075D;
        Thu, 25 Oct 2018 11:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465892;
        bh=T1HEm7Dqgdw6/I5Av9gICFUzPuFs9VjulyfCwdY94TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNf//Rz65HPnpL1qCX88Si5EDmqYX3x8JwmxaaQLrqzIyHS6Jaa0OMOg72GcGVbCf
         L0s2X/NOVPmPcm8zWE2FU5gM7+04f4smZ+V6KqrBEA1FTDFFWLvLTWWJWwBV2ARxSg
         ulPNU8cFhjTOpCi40XDjkC0hRcX654myCTh1K3Kg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/37] perf scripts python: call-graph-from-sql.py: Use SPDX license identifier
Date:   Thu, 25 Oct 2018 08:10:10 -0300
Message-Id: <20181025111031.3440-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Use SPDX license identifier in call-graph-from-sql.py.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index b494a67a1c67..ce1b91fcd6b8 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -1,15 +1,7 @@
 #!/usr/bin/python2
-# call-graph-from-sql.py: create call-graph from sql database
-# Copyright (c) 2014-2017, Intel Corporation.
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms and conditions of the GNU General Public License,
-# version 2, as published by the Free Software Foundation.
-#
-# This program is distributed in the hope it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-# more details.
+# SPDX-License-Identifier: GPL-2.0
+# exported-sql-viewer.py: view data from sql database
+# Copyright (c) 2014-2018, Intel Corporation.
 
 # To use this script you will need to have exported data using either the
 # export-to-sqlite.py or the export-to-postgresql.py script.  Refer to those
-- 
2.14.4

