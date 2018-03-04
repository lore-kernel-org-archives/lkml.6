Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeCDCaM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 21:30:12 -0500
Received: from mout.gmx.net ([212.227.17.21]:55633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751309AbeCDCaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 21:30:10 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 1/3] net: core: dst_cache: Fix a typo in a comment
Date: Sun,  4 Mar 2018 03:29:51 +0100
Message-Id: <20180304022953.4508-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:prrSDsyYumpL8hk8Vp0cRurG7cdM/0nR3vMd3mL5vYzu2Sij5z5
 LEZVvMccZxHiDF5JYegJEskg1Iu5u2V1eZ5K3Die2PnNvG4VEh7mZXC2cvevDWrpw6X2AE4
 UR6ivwhwcXKl05v11EWcprHX7aoJ7uToe2/ZqnWmULQvIp3dylBJzcI+2lp6FaMcOdWCJEB
 yxBdVC720PTfkHrL3iWIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rhh74UpawhA=:hcn0nUZLKdep2uGpmlbZRk
 itFlYFdKsubOcBdcHB5KhAI74YcIKiT3PeeIM58ba55bk3vBSE2wF4eyPZzgiWLQH/DC/1Pxq
 8ocaW8SlE/qGl8F/goM4Th2q2IHWpV5dKJ28A1nnEbRQc7gTdxeGNEBsphaPflVWtyS2dWBM1
 +o7mdhmpmtw8mabjoat81u7YBxpw9G7B7qoi4vhAEb9RO+305t43XZK37yrluzMA7Mday1w/R
 0wTmJpV3dz7vDxaSOqX3PH57DqaGFgUxUvw2WiGi8XwSATiDobXGldEh9AhARKMa+U4OTyj6t
 mWgYe2nzASA8t/pkSc2sRJTu/YLpMmvLZXqjPkJOvPhDdnX8+XmFsh3IqKDJ1ZgFuQ7YlBmvq
 /ePhS8pAXPaFVvyZgdSamUV9ZGfnZxjeBEKAQcEAyCt3ezvEMnU4gqGKRLTbhD/GayTRQkqz6
 rDtokt7FLixG7QOWA1fMwujqCt35vGuX9qMIQSttUnUYC+jrTkypTUW1zIt/LJ1X7zSJw3V1F
 rYbKRIowl4Uti8yI+sOjLT1tIyas6YF3yQp/UJZkuYqi0L7EDDxf8MDwgp1nOff687AEZg2Vb
 492DRFf6ZQiuS3AudswYmHGB7AIkEK1OV+WWcHGbegCaQFgi/T+FpxKwaWtbwXuMDb5h+26BR
 03ZkZNxTxiy/GiGaz5QNhAXzxZu0sYdmaHMiYSnBdw5zPUDlj+r3RD5zpwkxW77G5tpUDRpo+
 HODh76svOtlAOqGLtsqLGiHlZlzx9UQmhN1/vXeiUoNSS0eUFLUoU83dLy5I14ZjdeDCmB0Hc
 XLaeBJG7McPtsEueHkb3axlefp0SAyvXMh196RxF0Xlvw1xZwk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 include/net/dst_cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index 72fd5067c353..844906fbf8c9 100644
--- a/include/net/dst_cache.h
+++ b/include/net/dst_cache.h
@@ -71,7 +71,7 @@ struct dst_entry *dst_cache_get_ip6(struct dst_cache *dst_cache,
  *	dst_cache_reset - invalidate the cache contents
  *	@dst_cache: the cache
  *
- *	This do not free the cached dst to avoid races and contentions.
+ *	This does not free the cached dst to avoid races and contentions.
  *	the dst will be freed on later cache lookup.
  */
 static inline void dst_cache_reset(struct dst_cache *dst_cache)
-- 
2.16.1
