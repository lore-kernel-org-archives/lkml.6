Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B50C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A5C2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548764690;
	bh=NCNZiwcAMXp5eT1QLTX3PXstBfiARNQg8uYM23DcSyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QdFSrVC1PR5oUk2bHV9DFTBLCFB6MNPPSoMe1oU6yj8A4z+awxW4MQPKEUEb/KKYx
	 w9ukv333wx6aj2sWJYaPlQ6uHb4lXXIzI90muoznOJj0d3eQfmHGXvVVMPDwO5fnyA
	 Usd20vUXb5okO5CVwXvR5kVh+KU0k8VgUwSoxYCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfA2MYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:24:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbfA2MYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:24:47 -0500
Received: from localhost.localdomain (unknown [60.186.218.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A213B2087E;
        Tue, 29 Jan 2019 12:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548764686;
        bh=NCNZiwcAMXp5eT1QLTX3PXstBfiARNQg8uYM23DcSyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kkMemsYEqxlYgvWW3TV/9l/7pgpx1Ib/TQKBM/N7BoVhLQAl7louIYjpLt3dU+tZn
         a2MvJ3VSXgGfwqHFgKDVYmvna3nYv30xsqaDOmLZ949XkybS3bek2gooEuUqsHdgVj
         dg/569DRhsv0jPRRKndDMUJnvRdB/t1XeP+I+QaY=
From:   guoren@kernel.org
To:     arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 02/10] dt-bindings: csky,apb-intc: Add dh7k SOC support
Date:   Tue, 29 Jan 2019 20:24:21 +0800
Message-Id: <1548764669-16656-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548764669-16656-1-git-send-email-guoren@kernel.org>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add C-SKY dh7k SOC description.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
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

