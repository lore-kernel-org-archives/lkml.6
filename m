Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A924C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EFF218E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550455499;
	bh=20IxQcKtvMjnGmPcHi4tb/gLtPQMwZQtDNrgo0pMoe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KeRL5j8ebZjMt3piJKM9RgwOe5GY8fKyiPagyWz0zx3YzCmIMDXJHeD+GV2Zyr4Kj
	 YLrAZtJN+++qGrQxwq5VII1zsmugL65S81zPkEbY0WZBgL4rek7h411gXpaZFtgxAf
	 2QJdboKVTME86UpS2u8HHsucHJNVLXTecCaH7wJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfBRCE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:04:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbfBRCEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:04:55 -0500
Received: from localhost.localdomain (unknown [122.234.57.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A3B218D8;
        Mon, 18 Feb 2019 02:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550455494;
        bh=20IxQcKtvMjnGmPcHi4tb/gLtPQMwZQtDNrgo0pMoe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQkA8M+/UL0OrEaKDSSwsDMwaJNYS3YWlONrGZ9MyzyeUhpCOr44ydr5ipNW9BQzO
         WMj+zmtq/t8aWv0+jDqn+H5AY0sdl+y5GZHvkxZL8/wTNMWZXgHzv5Ib6ZImung0p5
         8q+OhpKeQ7zdk9Ww/nt1e5IUXMlVgQDPue0cXL5g=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, tglx@linutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 2/7] dt-bindings: csky,apb-intc: Add dh7k SOC support
Date:   Mon, 18 Feb 2019 10:04:38 +0800
Message-Id: <1550455483-11710-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550455483-11710-1-git-send-email-guoren@kernel.org>
References: <1550455483-11710-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add C-SKY dh7k SOC description.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
index 44286dc..63bc9dc 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
@@ -23,6 +23,7 @@ intc node bindings definition
 		Definition: must be "csky,apb-intc"
 				    "csky,dual-apb-intc"
 				    "csky,gx6605s-intc"
+				    "csky,dh7k-intc"
 	- #interrupt-cells
 		Usage: required
 		Value type: <u32>
-- 
2.7.4

