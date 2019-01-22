Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C88BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F192085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfAVKOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:14:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50545 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfAVKOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:14:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MAEQ4h2906571
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:14:26 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MAEQre2906568;
        Tue, 22 Jan 2019 02:14:26 -0800
Date:   Tue, 22 Jan 2019 02:14:26 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-cf5c6c211b7e9eb4f4219f83671432c9ef257187@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        peterz@infradead.org, jolsa@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, acme@redhat.com, yuehaibing@huawei.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com
Reply-To: hpa@zytor.com, alexander.shishkin@linux.intel.com,
          acme@redhat.com, yuehaibing@huawei.com, tglx@linutronix.de,
          mingo@kernel.org, jolsa@redhat.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org
In-Reply-To: <20190117072504.14428-1-yuehaibing@huawei.com>
References: <20190117072504.14428-1-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf: Remove duplicated workqueue.h include from
 perf_event.h
Git-Commit-ID: cf5c6c211b7e9eb4f4219f83671432c9ef257187
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cf5c6c211b7e9eb4f4219f83671432c9ef257187
Gitweb:     https://git.kernel.org/tip/cf5c6c211b7e9eb4f4219f83671432c9ef257187
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Thu, 17 Jan 2019 15:25:04 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 15:15:57 -0300

perf: Remove duplicated workqueue.h include from perf_event.h

It is already included a little bit higher up in that file.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190117072504.14428-1-yuehaibing@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/linux/perf_event.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index cec02dc63b51..f8ec36197718 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -53,7 +53,6 @@ struct perf_guest_info_callbacks {
 #include <linux/atomic.h>
 #include <linux/sysfs.h>
 #include <linux/perf_regs.h>
-#include <linux/workqueue.h>
 #include <linux/cgroup.h>
 #include <asm/local.h>
 
