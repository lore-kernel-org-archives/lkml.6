Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09317C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAB420870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfAKHtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:49:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49051 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfAKHtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:49:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0B7mthL561544
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 Jan 2019 23:48:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0B7mtDB561539;
        Thu, 10 Jan 2019 23:48:55 -0800
Date:   Thu, 10 Jan 2019 23:48:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-wq410s2wuqv5k980bidw0ju8@git.kernel.org>
Cc:     acme@redhat.com, adrian.hunter@intel.com, tglx@linutronix.de,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, jolsa@kernel.org, davem@davemloft.net,
        nikolay@cumulusnetworks.com, sbrivio@redhat.com
Reply-To: mingo@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, davem@davemloft.net, sbrivio@redhat.com,
          nikolay@cumulusnetworks.com, acme@redhat.com, hpa@zytor.com,
          tglx@linutronix.de, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools include uapi: Sync linux/if_link.h copy
 with the kernel sources
Git-Commit-ID: 498c203d855eaf6571b63ea860a53862c4fe91b7
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

Commit-ID:  498c203d855eaf6571b63ea860a53862c4fe91b7
Gitweb:     https://git.kernel.org/tip/498c203d855eaf6571b63ea860a53862c4fe91b7
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 9 Jan 2019 10:02:12 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 9 Jan 2019 10:02:12 -0300

tools include uapi: Sync linux/if_link.h copy with the kernel sources

To pick the changes from:

  a428afe82f98 ("net: bridge: add support for user-controlled bool options")
  a025fb5f49ad ("geneve: Allow configuration of DF behaviour")
  b4d3069783bc ("vxlan: Allow configuration of DF behaviour")

Silencing this tools/ build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Stefano Brivio <sbrivio@redhat.com>
Link: https://lkml.kernel.org/n/tip-wq410s2wuqv5k980bidw0ju8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/if_link.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 1debfa42cba1..d6533828123a 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -288,6 +288,7 @@ enum {
 	IFLA_BR_MCAST_IGMP_VERSION,
 	IFLA_BR_MCAST_MLD_VERSION,
 	IFLA_BR_VLAN_STATS_PER_PORT,
+	IFLA_BR_MULTI_BOOLOPT,
 	__IFLA_BR_MAX,
 };
 
@@ -533,6 +534,7 @@ enum {
 	IFLA_VXLAN_LABEL,
 	IFLA_VXLAN_GPE,
 	IFLA_VXLAN_TTL_INHERIT,
+	IFLA_VXLAN_DF,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
@@ -542,6 +544,14 @@ struct ifla_vxlan_port_range {
 	__be16	high;
 };
 
+enum ifla_vxlan_df {
+	VXLAN_DF_UNSET = 0,
+	VXLAN_DF_SET,
+	VXLAN_DF_INHERIT,
+	__VXLAN_DF_END,
+	VXLAN_DF_MAX = __VXLAN_DF_END - 1,
+};
+
 /* GENEVE section */
 enum {
 	IFLA_GENEVE_UNSPEC,
@@ -557,10 +567,19 @@ enum {
 	IFLA_GENEVE_UDP_ZERO_CSUM6_RX,
 	IFLA_GENEVE_LABEL,
 	IFLA_GENEVE_TTL_INHERIT,
+	IFLA_GENEVE_DF,
 	__IFLA_GENEVE_MAX
 };
 #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)
 
+enum ifla_geneve_df {
+	GENEVE_DF_UNSET = 0,
+	GENEVE_DF_SET,
+	GENEVE_DF_INHERIT,
+	__GENEVE_DF_END,
+	GENEVE_DF_MAX = __GENEVE_DF_END - 1,
+};
+
 /* PPP section */
 enum {
 	IFLA_PPP_UNSPEC,
