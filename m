Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7817C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89692217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="W5I8/zja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfBDH5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:57:11 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:56758 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfBDH5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:57:11 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x147uPiK010420;
        Mon, 4 Feb 2019 16:56:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x147uPiK010420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549266986;
        bh=jPWm5Howlg9fUnsRSwXgHzsJKaeC+3wocJD/iYHZaPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=W5I8/zjaRy2BZk/wRDVTam3vpWmCqewDgLXEmW/hgCrA8Is6aVZ2ao+ye4b700mLT
         sKBH4kIDLARn3qLX0DKHT11rFzBti5RAbCWf7CJ+cdOxy+xlxJ99WRSkb5uvrGaYTu
         khdwmps2+vCB+T6P2j3qjAk9hYZFBOAQg93LVvZW/CkVe6tXQMjhjs/pJHnbU4Dzhz
         oZomNKTvZII1O9SG4qcmdcMyYQasksnnXprxT58R+qiFPYQI2SdQdI18Rbu85rjpCQ
         c4K7dr0GswnEpHLjCBqNXmIcZfDpmLTJAfe1o1WZwD/AlzYW9pIHBkxzpMAVdtC+ts
         p8fmPIyY3BYBw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] csky: remove deprecated arch/csky/boot/dts/include/dt-bindings
Date:   Mon,  4 Feb 2019 16:56:01 +0900
Message-Id: <1549266961-13765-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a symbolic link arch/*/boot/dts/include/dt-bindings was
deprecated by commit d5d332d3f7e8 ("devicetree: Move include
prefixes from arch to separate directory").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/csky/boot/dts/include/dt-bindings | 1 -
 1 file changed, 1 deletion(-)
 delete mode 120000 arch/csky/boot/dts/include/dt-bindings

diff --git a/arch/csky/boot/dts/include/dt-bindings b/arch/csky/boot/dts/include/dt-bindings
deleted file mode 120000
index 08c00e4..0000000
--- a/arch/csky/boot/dts/include/dt-bindings
+++ /dev/null
@@ -1 +0,0 @@
-../../../../../include/dt-bindings
\ No newline at end of file
-- 
2.7.4

