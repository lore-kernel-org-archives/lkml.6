Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165691AbeE1O1G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161787AbeE1Kdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:33:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joey Pabalinas <joeypabalinas@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 167/329] net/tcp/illinois: replace broken algorithm reference link
Date: Mon, 28 May 2018 12:01:36 +0200
Message-Id: <20180528100256.319620583@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joey Pabalinas <joeypabalinas@gmail.com>

[ Upstream commit ecc832758a654e375924ebf06a4ac971acb5ce60 ]

The link to the pdf containing the algorithm description is now a
dead link; it seems http://www.ifp.illinois.edu/~srikant/ has been
moved to https://sites.google.com/a/illinois.edu/srikant/ and none of
the original papers can be found there...

I have replaced it with the only working copy I was able to find.

n.b. there is also a copy available at:

http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.296.6350&rep=rep1&type=pdf

However, this seems to only be a *cached* version, so I am unsure
exactly how reliable that link can be expected to remain over time
and have decided against using that one.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 net/ipv4/tcp_illinois.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_illinois.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/tcp_illinois.c
+++ b/net/ipv4/tcp_illinois.c
@@ -6,7 +6,7 @@
  * The algorithm is described in:
  * "TCP-Illinois: A Loss and Delay-Based Congestion Control Algorithm
  *  for High-Speed Networks"
- * http://www.ifp.illinois.edu/~srikant/Papers/liubassri06perf.pdf
+ * http://tamerbasar.csl.illinois.edu/LiuBasarSrikantPerfEvalArtJun2008.pdf
  *
  * Implemented from description in paper and ns-2 simulation.
  * Copyright (C) 2007 Stephen Hemminger <shemminger@linux-foundation.org>
