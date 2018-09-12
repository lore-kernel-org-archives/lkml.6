Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7049C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FC620880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FC620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeIMA2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:28:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60001 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbeIMA2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:28:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8CJLcPQ2744359
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Sep 2018 12:21:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8CJLbJn2744356;
        Wed, 12 Sep 2018 12:21:37 -0700
Date:   Wed, 12 Sep 2018 12:21:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-xd9ztioa894zemv8ag8kg64u@git.kernel.org>
Cc:     jakub.kicinski@netronome.com, daniel@iogearbox.net,
        stephen@networkplumber.org, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
        tglx@linutronix.de, wangnan0@huawei.com, acme@redhat.com,
        nikolay@cumulusnetworks.com, steffen.klassert@secunet.com,
        davem@davemloft.net
Reply-To: jakub.kicinski@netronome.com, daniel@iogearbox.net,
          dsahern@gmail.com, stephen@networkplumber.org, hpa@zytor.com,
          tglx@linutronix.de, namhyung@kernel.org, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@kernel.org,
          wangnan0@huawei.com, steffen.klassert@secunet.com,
          acme@redhat.com, nikolay@cumulusnetworks.com, davem@davemloft.net
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Update tools's copy of
 linux/if_link.h
Git-Commit-ID: 5db48a8d01319620d390bf6d9da5410be14f98e3
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

Commit-ID:  5db48a8d01319620d390bf6d9da5410be14f98e3
Gitweb:     https://git.kernel.org/tip/5db48a8d01319620d390bf6d9da5410be14f98e3
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 11 Sep 2018 14:10:52 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 11 Sep 2018 14:10:52 -0300

tools headers uapi: Update tools's copy of linux/if_link.h

To get the changes in:

	3e7a50ceb11e ("net: report min and max mtu network device settings")
	2756f68c3149 ("net: bridge: add support for backup port")
	a25717d2b604 ("xdp: support simultaneous driver and hw XDP attachment")
	4f91da26c811 ("xdp: add per mode attributes for attached programs")
	f203b76d7809 ("xfrm: Add virtual xfrm interfaces")

Silencing this libbpf build warning:

	Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-xd9ztioa894zemv8ag8kg64u@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/if_link.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index cf01b6824244..43391e2d1153 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -164,6 +164,8 @@ enum {
 	IFLA_CARRIER_UP_COUNT,
 	IFLA_CARRIER_DOWN_COUNT,
 	IFLA_NEW_IFINDEX,
+	IFLA_MIN_MTU,
+	IFLA_MAX_MTU,
 	__IFLA_MAX
 };
 
@@ -334,6 +336,7 @@ enum {
 	IFLA_BRPORT_GROUP_FWD_MASK,
 	IFLA_BRPORT_NEIGH_SUPPRESS,
 	IFLA_BRPORT_ISOLATED,
+	IFLA_BRPORT_BACKUP_PORT,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
@@ -459,6 +462,16 @@ enum {
 
 #define IFLA_MACSEC_MAX (__IFLA_MACSEC_MAX - 1)
 
+/* XFRM section */
+enum {
+	IFLA_XFRM_UNSPEC,
+	IFLA_XFRM_LINK,
+	IFLA_XFRM_IF_ID,
+	__IFLA_XFRM_MAX
+};
+
+#define IFLA_XFRM_MAX (__IFLA_XFRM_MAX - 1)
+
 enum macsec_validation_type {
 	MACSEC_VALIDATE_DISABLED = 0,
 	MACSEC_VALIDATE_CHECK = 1,
@@ -920,6 +933,7 @@ enum {
 	XDP_ATTACHED_DRV,
 	XDP_ATTACHED_SKB,
 	XDP_ATTACHED_HW,
+	XDP_ATTACHED_MULTI,
 };
 
 enum {
@@ -928,6 +942,9 @@ enum {
 	IFLA_XDP_ATTACHED,
 	IFLA_XDP_FLAGS,
 	IFLA_XDP_PROG_ID,
+	IFLA_XDP_DRV_PROG_ID,
+	IFLA_XDP_SKB_PROG_ID,
+	IFLA_XDP_HW_PROG_ID,
 	__IFLA_XDP_MAX,
 };
 
