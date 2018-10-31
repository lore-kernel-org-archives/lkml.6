Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59BBECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D3220821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D3220821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeKAHLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:11:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57537 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeKAHLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:11:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VMB62q2561447
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:11:06 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VMB5I22561444;
        Wed, 31 Oct 2018 15:11:05 -0700
Date:   Wed, 31 Oct 2018 15:11:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-7p53ghippywz7fqkwo3nkzet@git.kernel.org>
Cc:     davem@davemloft.net, ast@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, nikolay@cumulusnetworks.com,
        acme@redhat.com, eric@regit.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: davem@davemloft.net, ast@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, nikolay@cumulusnetworks.com,
          acme@redhat.com, eric@regit.org, hpa@zytor.com,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Update linux/if_link.h header
 copy
Git-Commit-ID: 76b0b801782b34b3028dcef3de36cb634e3908a8
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

Commit-ID:  76b0b801782b34b3028dcef3de36cb634e3908a8
Gitweb:     https://git.kernel.org/tip/76b0b801782b34b3028dcef3de36cb634e3908a8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 30 Oct 2018 17:06:57 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 31 Oct 2018 09:57:54 -0300

tools headers uapi: Update linux/if_link.h header copy

To pick the changes from:

  9163a0fc1f0c ("net: bridge: add support for per-port vlan stats")

And silence this build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Leblond <eric@regit.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Link: https://lkml.kernel.org/n/tip-7p53ghippywz7fqkwo3nkzet@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/if_link.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 58faab897201..1debfa42cba1 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -287,6 +287,7 @@ enum {
 	IFLA_BR_MCAST_STATS_ENABLED,
 	IFLA_BR_MCAST_IGMP_VERSION,
 	IFLA_BR_MCAST_MLD_VERSION,
+	IFLA_BR_VLAN_STATS_PER_PORT,
 	__IFLA_BR_MAX,
 };
 
