Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9957FC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D835208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpvenMzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D835208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754624AbeGIGUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754405AbeGIGUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:20:15 -0400
Received: from localhost.localdomain (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B84A5208DB;
        Mon,  9 Jul 2018 06:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531117210;
        bh=Y6e/3n+guSDc62R6uIPH9agVkOQjWphtXjwR8dgS8bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpvenMzxPatKzvwzi8DUZdbGN5+afan21SV9TOUs1UWhPolCZj1jELWNq+LC+4G3H
         BP3zt106XYo9HVy48zOsgnBqF6rOponL8rKECs45b5uGC9QWdweNLlHOTsqN3GgnLd
         zcxnGFLfBlG/admE64HQr4pYoE/ASeRxZS0OwMok=
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 2/6] dt-bindings: crypto: Move prng binding to crypto
Date:   Mon,  9 Jul 2018 11:49:21 +0530
Message-Id: <20180709061925.20276-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180709061925.20276-1-vkoul@kernel.org>
References: <20180709061925.20276-1-vkoul@kernel.org>
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

