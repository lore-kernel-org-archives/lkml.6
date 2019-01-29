Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEB9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1272175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfA2PKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:10:00 -0500
Received: from mout.gmx.net ([212.227.15.15]:42325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfA2PKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:10:00 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHX0m-1grmme1aAO-003LrS; Tue, 29
 Jan 2019 16:08:28 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH] init/Kconfig: Fix grammar by moving a closing parenthesis
Date:   Tue, 29 Jan 2019 16:08:11 +0100
Message-Id: <20190129150813.15785-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mhK0VgKWQ50WpXvhe58ASygqu0ppNJO2UEWxtqdfRM5muFSbm5x
 DkAvdMqUUolW7wEsdtZhwwXOUScBZtaDyNLUQcuShj5yVLupYXkkAT2p7w8uvO3rY8o1TLP
 D4ecIOdMWq4qTa0HX3J91nCQQk6+GqhiKpkGaEhvNfpSzwhUDmKlhVyW1yT+zqubCq45Ixi
 b6IiUVTtCKEmz6uwUSNZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZXoioK8+kQ0=:KBMyKdFKMDjgFjrtBkkj62
 bEFSpnPhfeVVkb9hoAPskpYvAY339QA5BZ3hrMc9P3LX1ndQq9Cbm/FP8xOgp7+lsMvlVZ1jt
 xo4A6k8Z0QD0WvfwizVYgRfA55i5Waa25Ea/ypXRAUlFiT7uHUCPiSPOd0KfTIAh3l702ghZG
 wvrURSa7pjRvz6uaRhr8ISPEObDl2fYNBS0bCOhxk1UI1W8CBvFOe0bjHuu2MIEH6WgmkHn+e
 7h2B0bs/hncUEObxxoUbCXT/YTMMvCcuJrbMyoyG5ipJX0bZodd9EiXo5b2dmKgEFq0fcHdWu
 VJXuBEKcsYKy3AkbwngdJGL7N0Xpkuw3eyTaHD3lGolLa4fn8cBj5ccvf86oBa4srKDw0DQGD
 ZEqwUWML6Ur3ShKHGOI3NVTq/XvOrNt+PZHSlQ93UjQ9XmMnjsMIKvVDoGZD+VffIuQSQPimy
 wLq0hrRIdiF0Uif68DhF9cowWgxZpN4QPfm0QZMswVR5qULsiiEW+YJWj80VD9HVNazuLP53p
 gYND0CLA2aGtjPoGUvIrw2OH9PCw9owGpWTObQmxrFq57fl50lG7JPITc8QQJCfRjHI6DxQAu
 rg2uIw5Sz8CmL28P/0kaDFyFvHYxF5t41kUchWXGtgIn3jz+j9P413PuwNjMz6O/sEUT5ysIE
 4d32SwzKMKuj5dNmGgLNFeguSkHZm9UGopOrg46V/dXJt+CtO4L9lriRW+ac1OshtT2NFJdJk
 weoTQjvxqu1A2AeVxBQ59Lj95wlvZZj1+nrbzv6GdUhfJu3zsGgUMwoJQQnthtDANvLJZACfP
 K48DCtZWiXXasPjadG58SVjrz2T72jk1lmxOMjh84UC26Z1oMD96cOQRI8cpF5k5pFi2IPS3a
 MGcJzfLTgwT1jpT8h6wGcqj5G/In8DueA+7DG+js3CBtkLqL5hhyNw8sc+iGJsYWCYcDzGcCC
 yuJV10dlzaA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 513fa544a134..354146666d97 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -825,7 +825,7 @@ config CGROUP_PIDS
 	  PIDs controller is designed to stop this from happening.
 
 	  It should be noted that organisational operations (such as attaching
-	  to a cgroup hierarchy will *not* be blocked by the PIDs controller),
+	  to a cgroup hierarchy) will *not* be blocked by the PIDs controller,
 	  since the PIDs limit only affects a process's ability to fork, not to
 	  attach to a cgroup.
 
-- 
2.20.1

