Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8D945C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F9B208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="t/FYBFqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F9B208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965740AbeFNOk1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:40:27 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:29199 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965543AbeFNOkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:40:23 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w5EEdw8n010795;
        Thu, 14 Jun 2018 23:39:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w5EEdw8n010795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528987200;
        bh=D1feyA0aAgxTbyIZhn4z5vUaXyZWPFRT9A14nU4K6N8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/FYBFqL4wb7e7xtsxvpOXpXfmRWZpAnNS7F+6DsvMVyT3v9iaOlbNdrlAzACVAbx
         YVYHB9JtZt4m78eAymLkL5nwPa1iEVvdrobWWddxwobTpikrY3dQ12OKLp85jlXBxP
         FyK2XSr2IL9/Q17ipFHEj1/uJfCFyTIwKspBX4i1TGBZjqNS/ZvvPqY2VwQP67w9WQ
         lav8Z331PUnjfSnT77l+4TfJZ33vQQz7A+peTWWab/cFuv1IPyB3k+FcQ7I3RzDAHq
         l8OXcih7geE/QkFsF2yPOC3VZS5nFnl+sHP9dpZ0it59xvl6Nnqo5w7qd2velvKrvw
         XqXircJX8ab6g==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 1/3] bpfilter: add bpfilter_umh to .gitignore
Date:   Thu, 14 Jun 2018 23:39:30 +0900
Message-Id: <1528987172-19810-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528987172-19810-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528987172-19810-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bpfilter_umh is a generated file.  It should be ignored by git.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 net/bpfilter/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 net/bpfilter/.gitignore

diff --git a/net/bpfilter/.gitignore b/net/bpfilter/.gitignore
new file mode 100644
index 0000000..e97084e
--- /dev/null
+++ b/net/bpfilter/.gitignore
@@ -0,0 +1 @@
+bpfilter_umh
-- 
2.7.4

