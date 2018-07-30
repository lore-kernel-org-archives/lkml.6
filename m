Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C006C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D36208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="Eytpj+Gj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D36208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbeGaAsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:48:53 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:55676 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731947AbeGaAsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:48:53 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id B9947B00AA4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 01:11:35 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1532992295; x=1533856296; bh=uS
        4mquzPW+OIVvvbgzK+ZZm7R1j8RHYCY3R/TeFWrmg=; b=Eytpj+GjcRK2wERqgC
        KpkxRR9VZOKcrXuSo2Uu6UM2RAfmlSAhvoUuV9FuVhkmEUobh1ipyTbg2OIiPJ5q
        jvY+RJdsNFVTt6/zdXC5epjYC2i+RC/44awv98b6LUOH6+0isoCc58D6DqtLKFQB
        1fFnhXmkgwflhmgWsKuva2spg=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NlPIb-ziKGbF for <linux-kernel@vger.kernel.org>;
        Tue, 31 Jul 2018 01:11:35 +0200 (CEST)
Received: from ubuntu.localdomain (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id DA2E5B00A99;
        Tue, 31 Jul 2018 01:11:33 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 1/5] dt-bindings: Add vendor prefix for CDTech(H.K.) Electronics Limited
Date:   Tue, 31 Jul 2018 01:11:13 +0200
Message-Id: <20180730231117.5631-2-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
References: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a vendor prefix "cdtech" for CDTech(H.K.) Electronics Limited

Website: www.cdtech-lcd.com

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 760d1c11458c..29894c628e00 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -64,6 +64,7 @@ capella	Capella Microsystems, Inc
 cascoda	Cascoda, Ltd.
 cavium	Cavium, Inc.
 cdns	Cadence Design Systems Inc.
+cdtech	CDTech(H.K.) Electronics Limited
 ceva	Ceva, Inc.
 chipidea	Chipidea, Inc
 chipone		ChipOne
-- 
2.17.1

