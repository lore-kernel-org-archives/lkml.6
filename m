Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFC9C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636922098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636922098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeJRVcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:32:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37550 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeJRVcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:32:11 -0400
Received: by mail-ot1-f68.google.com with SMTP id o14so29755593oth.4;
        Thu, 18 Oct 2018 06:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ez9pwcIpeVxI+VRAUZ/iqJaAuyH+/72R71vkBIRO1s8=;
        b=ayENDpLCMSPnJ4fMxwVH29WIc4tN8aIXkZcasSdFUK2Ecf8/NV/hongBvdhDaOKC+c
         6bj2gN06EXeVRka5sFOArGlrQnyXPzwtWYnoZG9v/bw3b+uE0f8V1OYwTqL2zwhi8KyS
         20+cfqiLpZHDMSZ+f1EyFeVusIvu3xDKxduJ3xIzKiHERgvO7DtBKjG5PzwCvS/JLVCT
         xOpfUpEOHF67m9IoqbHvvzKS3Ji9pJfga6f1Qau540j1EFbxETEfoD3pnADcmqG+lqeZ
         Dc6P7zjDY8ArCfGqvlOoLSD/YhP71WJ61tEsYg85plqFdnWFaAV9Yq6Cy6p89X0uSEel
         YwCQ==
X-Gm-Message-State: ABuFfoiO/61HHOFuyQuv8GZYhwXsEP+8a6xJ5enS1K2j/DvPRvIzOpab
        wv5FYks8QLsh2keDuE/g0Q==
X-Google-Smtp-Source: ACcGV63CGbUI9Mn1GTCEm8qu5mw5emszPPcbpfm2393aLVrftWDm9lw3rkzO+h3VBkRp2LPBnZiwBQ==
X-Received: by 2002:a9d:74d:: with SMTP id 71mr19789602ote.239.1539869466818;
        Thu, 18 Oct 2018 06:31:06 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id p129-v6sm6037671oia.21.2018.10.18.06.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 06:31:06 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] MAINTAINERS: Add Kishon as maintainer of PHY bindings
Date:   Thu, 18 Oct 2018 08:31:05 -0500
Message-Id: <20181018133105.3720-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings normally go in via subsystem maintainers, so add PHY
bindings under generic PHY framework.

Reported-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052aeac39..b01e77ae79c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6132,6 +6132,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git
 S:	Supported
 F:	drivers/phy/
 F:	include/linux/phy/
+F:	Documentation/devicetree/bindings/phy/
 
 GENERIC PINCTRL I2C DEMULTIPLEXER DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
-- 
2.17.1

