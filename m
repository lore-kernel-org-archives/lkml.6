Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56447C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F202020868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F202020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=polito.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeICUx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:53:57 -0400
Received: from fm1nodo5.polito.it ([130.192.180.18]:39989 "EHLO
        fm1nodo5.polito.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbeICUx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:53:57 -0400
X-Greylist: delayed 1634 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Sep 2018 16:53:55 EDT
Received: from polito.it (frontmail2.polito.it [130.192.180.42])
        by fm1nodo5.polito.it  with ESMTP id w83G5WQc027700-w83G5WQe027700
        (version=TLSv1.0 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=CAFAIL);
        Mon, 3 Sep 2018 18:05:32 +0200
X-ExtScanner: Niversoft's FindAttachments (free)
Received: from [130.192.225.241] (account d040768@polito.it HELO localhost.localdomain)
  by polito.it (CommuniGate Pro SMTP 6.2.5)
  with ESMTPSA id 78880852; Mon, 03 Sep 2018 18:05:32 +0200
From:   Mauricio Vasquez B <mauricio.vasquez@polito.it>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf] selftests/bpf: add missing executables to .gitignore
Date:   Mon,  3 Sep 2018 18:05:27 +0200
Message-Id: <1535990727-2778-1-git-send-email-mauricio.vasquez@polito.it>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mauricio Vasquez B <mauricio.vasquez@polito.it>
---
 tools/testing/selftests/bpf/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 49938d72cf63..4d789c1e5167 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -19,3 +19,7 @@ test_btf
 test_sockmap
 test_lirc_mode2_user
 get_cgroup_id_user
+test_skb_cgroup_id_user
+test_socket_cookie
+test_cgroup_storage
+test_select_reuseport
-- 
2.7.4

