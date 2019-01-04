Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F9CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8B42184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfADBlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 20:41:03 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35889 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfADBlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 20:41:02 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so38986768qtn.3;
        Thu, 03 Jan 2019 17:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=HHhbR5UARcBdfKhvEAPMhhHPIp3au6k3s9rssxoZ9to=;
        b=fu8rLJtB1t8mgYgvnOEHnSw2esVa+PLgWdmFUZ//CMMcFznlSpK90KHUmI+ZbgdJvh
         kzdNnTUCkudLZRviZHYspDORoBMmAj/iuDA8M7GX3gxT1AIkYpe/OocM/1ydbjEeQ/2/
         ZsnbMbhr2VKRmqSq7xnP1wn9P8x6kh8O84/hkfpYNVuAbHcZmcDKcmIyVamvfOny1Gpg
         ZQVIkfkz1OYmFK8AdFZlk7LZN+XJjJgbTElU3mOmx00t8NuakupE/zJ3k/00k2lZg07C
         nSU3dyLMr79eylcmYBM7ssjELHB9hsuOUD/lNVx/NIO7FQnSzViNigutnnlfRiJcUJ0b
         oUlQ==
X-Gm-Message-State: AJcUukfAq9vsX57+IHs+Li9cA9ZVIuDK2M1E83zRFVOqG4Yvw3h//EGp
        pc9nJooHVt3fg3nony73x8M=
X-Google-Smtp-Source: ALg8bN4YKFnO2BIypTRVe7fgo+ncLx3xkY2gdJVGuqep2jzBlktOQJ+0yMgFzoftayZLi5MXhfl6hQ==
X-Received: by 2002:ac8:468f:: with SMTP id g15mr48038697qto.363.1546566061726;
        Thu, 03 Jan 2019 17:41:01 -0800 (PST)
Received: from localhost.localdomain ([181.220.84.254])
        by smtp.gmail.com with ESMTPSA id l73sm30882443qkl.16.2019.01.03.17.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 17:41:00 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 03 Jan 2019 23:40:54 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Jason Zhu <jason.zhu@rock-chips.com>,
        Vicent Chi <vicent.chi@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/4] dt-bindings: Add vendor prefix for elgin
Date:   Thu,  3 Jan 2019 23:40:22 -0200
Message-Id: <20190104014023.17973-3-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104014023.17973-1-otavio@ossystems.com.br>
References: <20190104014023.17973-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add elgin vendor definition as 'Elgin S/A.'

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 3bbe3b87a1ff..b2c3d7ca1722 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -113,6 +113,7 @@ eckelmann	Eckelmann AG
 edt	Emerging Display Technologies
 eeti	eGalax_eMPIA Technology Inc
 elan	Elan Microelectronic Corp.
+elgin	Elgin S/A.
 embest	Shenzhen Embest Technology Co., Ltd.
 emlid	Emlid, Ltd.
 emmicro	EM Microelectronic
-- 
2.20.1

