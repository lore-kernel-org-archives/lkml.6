Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70682C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4352246B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw/ZFIXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4352246B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932910AbeGCGGT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754291AbeGCGFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:05:15 -0400
Received: from localhost.localdomain (unknown [171.61.87.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55A6C2246B;
        Tue,  3 Jul 2018 06:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530597915;
        bh=Y6e/3n+guSDc62R6uIPH9agVkOQjWphtXjwR8dgS8bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aw/ZFIXthVKFpCx6O/mLP9BRiURxoUiJV0ulPN9y0F3LkhmigbHwXqGdqr/f529lU
         xOmJhLzT/V5Jt5gkRdbGD+so4jHkgSMEzdhLASvgCQuFi3/w47tuvLBojZFdrl0K+6
         639c9Kl1JDo2wbXETY2o+aiu61D23IdAf1PVSb2g=
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 2/6] dt-bindings: crypto: Move prng binding to crypto
Date:   Tue,  3 Jul 2018 11:34:30 +0530
Message-Id: <20180703060434.19293-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180703060434.19293-1-vkoul@kernel.org>
References: <20180703060434.19293-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we are adding new driver for prng in crypto, move the
binding as well.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/{rng => crypto}/qcom,prng.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{rng => crypto}/qcom,prng.txt (100%)

diff --git a/Documentation/devicetree/bindings/rng/qcom,prng.txt b/Documentation/devicetree/bindings/crypto/qcom,prng.txt
similarity index 100%
rename from Documentation/devicetree/bindings/rng/qcom,prng.txt
rename to Documentation/devicetree/bindings/crypto/qcom,prng.txt
-- 
2.14.4

