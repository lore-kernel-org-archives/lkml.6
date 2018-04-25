Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756000AbeDYRmM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:42:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756035AbeDYRlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:41:12 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH 2/3] tools bpf: Sync bpf.h uapi header
Date: Wed, 25 Apr 2018 19:41:07 +0200
Message-Id: <20180425174108.6586-3-jolsa@kernel.org>
In-Reply-To: <20180425174108.6586-1-jolsa@kernel.org>
References: <20180425174108.6586-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syncing the bpf.h uapi header with tools.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e6679393b687..da8801860c7d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1060,6 +1060,7 @@ struct bpf_prog_info {
 	__aligned_u64 map_ids;
 	char name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
+	__u32 gpl_compatible:1;
 	__u64 netns_dev;
 	__u64 netns_ino;
 } __attribute__((aligned(8)));
-- 
2.13.6
