Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD72C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0703620652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfAQRCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:02:47 -0500
Received: from mout.gmx.net ([212.227.15.18]:41299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbfAQRCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:02:46 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJjOu-1glGzL1jDo-001BJF; Thu, 17
 Jan 2019 18:02:31 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     netdev@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        David Ahern <dsa@cumulusnetworks.com>,
        Matteo Croce <mcroce@redhat.com>,
        Tobias Regnery <tobias.regnery@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: Fix typo in NET_FAILOVER help text
Date:   Thu, 17 Jan 2019 18:02:18 +0100
Message-Id: <20190117170220.32239-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:w0zNVhslHIHTujFpnceXI3pOoHo7o63dZmpP0Q2v3GzY60l6z+u
 WvYMvwQJLZfSy4fltodHv7dCGEA/cb8RdaazSt5h5V0ZezC8oG1uG9/lGdS5s6EDq1KRtwP
 TJIy8iJOYKpb/XZeb3PRr5McjDNaRNQml97NpD6Y8vDKrkcxQGOi9a7GoQX9U5L0K3SoLWB
 Acrn+4vTWpTzR1ywjCCNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HnmPvvnCU14=:WFeTRCcMuxW+qFvkXiafsA
 l1Usqpb7YMhp+kDfSQJcpegOkSLrFM3oOP2nFL1ZqwFWJ92wziPE/hy0cPoONYrAQ5eGd5W99
 2xt1k7/WffgS5zfTDyQHWBxtXLfNgWQoH4bUWshacImvQ62FES6Jb40xZB8y4PzTTpHKFAEri
 k1FDdgNQwFqiu4EGx4l6frdi+phTca3k0cGXkKWwPLT3G8zytn/liQRRtaVmBcBlhZ/vVlVW2
 NVBjp5kAnrp+U3PuAYneTRSwA6CvCqEhsWgF3jmjTuwhDmO+ArRNqtpoKwqBmUos9JhM7n4eW
 0hVLbCujRZKWK3DAijKT0tk9Hpxmuj1GiLQEO2gJ8vHc8fAax0cHTiZ36qf9prcrqkDeVcBea
 SGk+XRAkQGCPlIrErj2BT1l6IUwloKWhZM1kdsxOFBoU7pbmuWpoqnn+jggMw8IZ4QZ0L07yP
 sS9U7sdCYBcxpqjuFRVtvd7hhZ28aWjPiFxO0ecjcur/2a34K+ISTWV2t0jfhgfmyX3WZnzDF
 yp2CmRhkjfjgKVyLPw8R1TlytmqlMbx2jFl1dOMMI2oIxVEgfoUyUF77UhoL3KESYsSrXFBzQ
 4RjeTSCtHvySrckhhjwFBq0G9t+PR7JeUlj6ji6QXnAc4dwzwjY4c0nuOSogIG28YQSLJAxvm
 40Bt6Xv8C2innrA87AltkYSDAYfCcKOkjwuyKQy5ZWWVBZUKSIb6Q/+Mc8p/dPlK72J8hBo+7
 o+SUz4PwZou15tPTOJ3Q4NqiYgs4fK1jsQntxiNRw+ofGgxA9zyRqY9JFi4FcpanXrgHpm6tA
 Xs4AVi2ejONsqhSGdbgUpj3hZ6HrnHXl4wwRJKgMRe22aXYBf4o9zDCy/DJxl+vsceLG/2pQM
 R4gQpnnfuBZPSRK3nCVS3A9VyUqtwgqBn4e55tme8qplLa2gUIoY7PTmgxyAYAFXYpMrPIip7
 KnsT9BVtg5w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"also enables" should not be spelled as one word.

Fixes: cfc80d9a1163 ("net: Introduce net_failover driver")
Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 drivers/net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d03775100f7d..853cc108b57e 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -519,7 +519,7 @@ config NET_FAILOVER
 	  and destroy a failover master netdev and manages a primary and
 	  standby slave netdevs that get registered via the generic failover
 	  infrastructure. This can be used by paravirtual drivers to enable
-	  an alternate low latency datapath. It alsoenables live migration of
+	  an alternate low latency datapath. It also enables live migration of
 	  a VM with direct attached VF by failing over to the paravirtual
 	  datapath when the VF is unplugged.
 
-- 
2.17.1

