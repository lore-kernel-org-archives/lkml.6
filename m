Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uc++MeK4GltLQwAAmS7hNA
	; Fri, 08 Jun 2018 17:13:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 35BE2607E4; Fri,  8 Jun 2018 17:13:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1X4ti/Vi"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6082560590;
	Fri,  8 Jun 2018 17:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6082560590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeFHRND (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:13:03 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:19844 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751846AbeFHRNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:13:01 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w58HCbWD008555;
        Sat, 9 Jun 2018 02:12:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w58HCbWD008555
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528477959;
        bh=Sd1Qm6teZwiLGXhmsz3xxi5lf/RE2OzLHlD/svAXNgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1X4ti/ViTRN2s8Nu38NgXgI4zrDwizOminDyNHlH7gQl3OgFnzHpt+MHohh7vaYLu
         Jij8VoIjpOS/cZKbG3eCFhr+6SP8GpTTHDWfVxF7HHc671pwQAap36LF/tJLuCppTi
         tBBQQ0GoqexokPrtfeVRuOIYzLCesOzAorxk9lO/ANHpKtQuuFXZY6p5Jo6mc2Llhv
         QQqnJSNwRdSNPOxRSxd+OqfW7MIexM48uSkIXMbfIhJjuU0D9WjzAgA4XFmjXv6sN0
         Dy4EBMJTNVDkqpZKf9muTlaZeThG10338kHp/E6N/4GIVY4HhZdqBm2BuxWFQLEsG5
         m8A6D1e6terGw==
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/3] bpfilter: add bpfilter_umh to .gitignore
Date: Sat,  9 Jun 2018 02:12:08 +0900
Message-Id: <1528477930-7342-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528477930-7342-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528477930-7342-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bpfilter_umh is a generated file.  It should be ignored by git.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

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
