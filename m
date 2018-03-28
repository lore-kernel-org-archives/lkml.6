Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeC1KHH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:07:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38630 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752817AbeC1KHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:07:05 -0400
From: Colin King <colin.king@canonical.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] samples/bpf: fix spelling mistake: "revieve" -> "receive"
Date: Wed, 28 Mar 2018 11:07:01 +0100
Message-Id: <20180328100701.13289-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in error message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 samples/bpf/cookie_uid_helper_example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/cookie_uid_helper_example.c b/samples/bpf/cookie_uid_helper_example.c
index 9d751e209f31..8eca27e595ae 100644
--- a/samples/bpf/cookie_uid_helper_example.c
+++ b/samples/bpf/cookie_uid_helper_example.c
@@ -246,7 +246,7 @@ static void udp_client(void)
 		recv_len = recvfrom(s_rcv, &buf, sizeof(buf), 0,
 			     (struct sockaddr *)&si_me, &slen);
 		if (recv_len < 0)
-			error(1, errno, "revieve\n");
+			error(1, errno, "receive\n");
 		res = memcmp(&(si_other.sin_addr), &(si_me.sin_addr),
 			   sizeof(si_me.sin_addr));
 		if (res != 0)
-- 
2.15.1
