Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8DFC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DA920883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfAHPlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:41:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60793 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfAHPlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:41:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x08Fea3i3566653
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 07:40:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x08FeZpK3566646;
        Tue, 8 Jan 2019 07:40:35 -0800
Date:   Tue, 8 Jan 2019 07:40:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-mdw7ta6qz7d2rl77gf00uqe8@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        joonas.lahtinen@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, lionel.g.landwerlin@intel.com, mingo@kernel.org,
        acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        chris@chris-wilson.co.uk
Reply-To: linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          lionel.g.landwerlin@intel.com, joonas.lahtinen@linux.intel.com,
          namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
          acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
          chris@chris-wilson.co.uk
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Update i915_drm.h
Git-Commit-ID: 8858ecb5a28d871b79aa5b4eed45414b553a5b6e
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

Commit-ID:  8858ecb5a28d871b79aa5b4eed45414b553a5b6e
Gitweb:     https://git.kernel.org/tip/8858ecb5a28d871b79aa5b4eed45414b553a5b6e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 4 Jan 2019 11:36:10 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 4 Jan 2019 12:54:49 -0300

tools headers uapi: Update i915_drm.h

To get the changes in these csets:

  fe841686470d Revert "drm/i915/perf: add a parameter to control the size of OA buffer"
  cd956bfcd0f5 drm/i915/perf: add a parameter to control the size of OA buffer
  4bdafb9ddfa4 drm/i915: Remove i915.enable_ppgtt override

Not one of them result in any changes in tools/perf/, this is just to
silence this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mdw7ta6qz7d2rl77gf00uqe8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index a4446f452040..298b2e197744 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -412,6 +412,14 @@ typedef struct drm_i915_irq_wait {
 	int irq_seq;
 } drm_i915_irq_wait_t;
 
+/*
+ * Different modes of per-process Graphics Translation Table,
+ * see I915_PARAM_HAS_ALIASING_PPGTT
+ */
+#define I915_GEM_PPGTT_NONE	0
+#define I915_GEM_PPGTT_ALIASING	1
+#define I915_GEM_PPGTT_FULL	2
+
 /* Ioctl to query kernel params:
  */
 #define I915_PARAM_IRQ_ACTIVE            1
