Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE0DC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659DF21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfACNQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:16:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57527 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbfACNQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:16:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DFsDC1384493
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:15:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DFsPg1384490;
        Thu, 3 Jan 2019 05:15:54 -0800
Date:   Thu, 3 Jan 2019 05:15:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3vrm9b55tdhzn8sw9qazh4z5@git.kernel.org>
Cc:     namhyung@kernel.org, lclaudio@redhat.com, tglx@linutronix.de,
        acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        wangnan0@huawei.com, jolsa@kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com,
          lclaudio@redhat.com, tglx@linutronix.de, namhyung@kernel.org,
          adrian.hunter@intel.com, hpa@zytor.com, jolsa@kernel.org,
          wangnan0@huawei.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Grab a copy of usbdevice_fs.h
Git-Commit-ID: 2bd71d11a86e8419a33a131d194fd735a8f74400
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

Commit-ID:  2bd71d11a86e8419a33a131d194fd735a8f74400
Gitweb:     https://git.kernel.org/tip/2bd71d11a86e8419a33a131d194fd735a8f74400
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 27 Dec 2018 14:18:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:33:04 -0300

tools headers uapi: Grab a copy of usbdevice_fs.h

Will be used to generate the string table for the USBDEVFS_ prefixed
ioctl commands.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-3vrm9b55tdhzn8sw9qazh4z5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 {include => tools/include}/uapi/linux/usbdevice_fs.h | 0
 tools/perf/check-headers.sh                          | 1 +
 2 files changed, 1 insertion(+)

diff --git a/include/uapi/linux/usbdevice_fs.h b/tools/include/uapi/linux/usbdevice_fs.h
similarity index 100%
copy from include/uapi/linux/usbdevice_fs.h
copy to tools/include/uapi/linux/usbdevice_fs.h
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 8e811ea0cf85..6cb98f8570a2 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -14,6 +14,7 @@ include/uapi/linux/perf_event.h
 include/uapi/linux/prctl.h
 include/uapi/linux/sched.h
 include/uapi/linux/stat.h
+include/uapi/linux/usbdevice_fs.h
 include/uapi/linux/vhost.h
 include/uapi/sound/asound.h
 include/linux/bits.h
