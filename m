Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D935ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F111B21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0B8zrdRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F111B21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeJSShR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:37:17 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:26773 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeJSShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:37:17 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w9JAUbDg007220;
        Fri, 19 Oct 2018 19:30:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w9JAUbDg007220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539945040;
        bh=qHzzC87LyyMvLEwNc/emQhrm9tW7Qb54buTdXDMWtHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0B8zrdRmrjPDekV+DyRdGqqN80rznNT1I6GSlMHr9syZnRa2g1sgOvzolFkdbNyji
         E7xEtr4W+PYP3EG8Rl0fbRhfYM0k4ci+8+qJ4/5WNpbwekObduQKm7w4VL3d4Y/ZcW
         RW7/qyERBJCVXUp2fmRg0y44PPp6R1+5+bVpvmbjNXrdnA6Ym4b5dAoCO5vqYFN41D
         HFvdQmty6H+6Vx9I0bXzOeEgS0Hl14BkWIohFqgA2yR9tQnnqyQFSei+M2PPbwKVP0
         BAA1tcKJpHc8lsaJpFJEbkAA8amAlSQOX5hvASX0xw2vHK6bdW6q6GaZH4AjRjjcdo
         JA/t44xE/doZA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 2/2] dt-bindings: uniphier: move cache-uniphier.txt to vendor directory
Date:   Fri, 19 Oct 2018 19:30:18 +0900
Message-Id: <1539945019-24950-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539945019-24950-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539945019-24950-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, the Socionext vendor directory is available at
Documentation/devicetree/bindings/arm/socionext/

Move cache-uniphier.txt over to it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3: None
Changes in v2:
  - New patch

 .../devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt    | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt (100%)

diff --git a/Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt b/Documentation/devicetree/bindings/arm/socionext/cache-uniphier.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt
rename to Documentation/devicetree/bindings/arm/socionext/cache-uniphier.txt
-- 
2.7.4

