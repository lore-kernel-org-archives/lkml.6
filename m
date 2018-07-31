Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71986C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B43208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B43208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbeGaHlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:41:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38497 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeGaHlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:41:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6V61xK92594279
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 23:01:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6V61xWL2594276;
        Mon, 30 Jul 2018 23:01:59 -0700
Date:   Mon, 30 Jul 2018 23:01:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-yei494y6b3mn6bjzz9g0ws12@git.kernel.org>
Cc:     tglx@linutronix.de, wangnan0@huawei.com, jolsa@kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, dsahern@gmail.com, hpa@zytor.com,
        daniel@iogearbox.net, linux-kernel@vger.kernel.org
Reply-To: jolsa@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
          wangnan0@huawei.com, dsahern@gmail.com, hpa@zytor.com,
          daniel@iogearbox.net, linux-kernel@vger.kernel.org,
          mingo@kernel.org, namhyung@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Refresh linux/bpf.h copy
Git-Commit-ID: fc73bfd6005c7fe5c3a2f04d4db7fa5d37cd3ebd
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

Commit-ID:  fc73bfd6005c7fe5c3a2f04d4db7fa5d37cd3ebd
Gitweb:     https://git.kernel.org/tip/fc73bfd6005c7fe5c3a2f04d4db7fa5d37cd3ebd
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 30 Jul 2018 11:56:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 30 Jul 2018 12:35:45 -0300

tools headers uapi: Refresh linux/bpf.h copy

To get the changes in:

  4c79579b44b1 ("bpf: Change bpf_fib_lookup to return lookup status")

That do not entail changes in tools/perf/ use of it, elliminating the
following perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-yei494y6b3mn6bjzz9g0ws12@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/bpf.h | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 59b19b6a40d7..b7db3261c62d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1857,7 +1857,8 @@ union bpf_attr {
  *		is resolved), the nexthop address is returned in ipv4_dst
  *		or ipv6_dst based on family, smac is set to mac address of
  *		egress device, dmac is set to nexthop mac address, rt_metric
- *		is set to metric from route (IPv4/IPv6 only).
+ *		is set to metric from route (IPv4/IPv6 only), and ifindex
+ *		is set to the device index of the nexthop from the FIB lookup.
  *
  *             *plen* argument is the size of the passed in struct.
  *             *flags* argument can be a combination of one or more of the
@@ -1873,9 +1874,10 @@ union bpf_attr {
  *             *ctx* is either **struct xdp_md** for XDP programs or
  *             **struct sk_buff** tc cls_act programs.
  *     Return
- *             Egress device index on success, 0 if packet needs to continue
- *             up the stack for further processing or a negative error in case
- *             of failure.
+ *		* < 0 if any input argument is invalid
+ *		*   0 on success (packet is forwarded, nexthop neighbor exists)
+ *		* > 0 one of **BPF_FIB_LKUP_RET_** codes explaining why the
+ *		*     packet is not forwarded or needs assist from full stack
  *
  * int bpf_sock_hash_update(struct bpf_sock_ops_kern *skops, struct bpf_map *map, void *key, u64 flags)
  *	Description
@@ -2612,6 +2614,18 @@ struct bpf_raw_tracepoint_args {
 #define BPF_FIB_LOOKUP_DIRECT  BIT(0)
 #define BPF_FIB_LOOKUP_OUTPUT  BIT(1)
 
+enum {
+	BPF_FIB_LKUP_RET_SUCCESS,      /* lookup successful */
+	BPF_FIB_LKUP_RET_BLACKHOLE,    /* dest is blackholed; can be dropped */
+	BPF_FIB_LKUP_RET_UNREACHABLE,  /* dest is unreachable; can be dropped */
+	BPF_FIB_LKUP_RET_PROHIBIT,     /* dest not allowed; can be dropped */
+	BPF_FIB_LKUP_RET_NOT_FWDED,    /* packet is not forwarded */
+	BPF_FIB_LKUP_RET_FWD_DISABLED, /* fwding is not enabled on ingress */
+	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
+	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
+	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
+};
+
 struct bpf_fib_lookup {
 	/* input:  network family for lookup (AF_INET, AF_INET6)
 	 * output: network family of egress nexthop
@@ -2625,7 +2639,11 @@ struct bpf_fib_lookup {
 
 	/* total length of packet from network header - used for MTU check */
 	__u16	tot_len;
-	__u32	ifindex;  /* L3 device index for lookup */
+
+	/* input: L3 device index for lookup
+	 * output: device index from FIB lookup
+	 */
+	__u32	ifindex;
 
 	union {
 		/* inputs to lookup */
