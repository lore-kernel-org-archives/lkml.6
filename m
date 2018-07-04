Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101F5C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D0120841
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x/j/75hQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D0120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934198AbeGDLpQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933296AbeGDLpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:45:12 -0400
Received: from localhost.localdomain (unknown [122.167.70.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE0BB21456;
        Wed,  4 Jul 2018 11:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530704712;
        bh=Y6e/3n+guSDc62R6uIPH9agVkOQjWphtXjwR8dgS8bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x/j/75hQqkC3KIACIHtCdbE4LvwS04VBDIW5etGas0uPLmJNX/Mmtk9i9nzIIqjXd
         lQJGjSAIZUsTGp7nbFQsCyAJP1WRdYWkIhqpZLhBGVH4kEbOZNA/rH39iwpS4AWF7X
         kT5Jip62XoNm7VjHwEXw6kIZuMImuIh1RctvCICw=
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
Subject: [PATCH v4 2/6] dt-bindings: crypto: Move prng binding to crypto
Date:   Wed,  4 Jul 2018 17:14:23 +0530
Message-Id: <20180704114427.29953-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180704114427.29953-1-vkoul@kernel.org>
References: <20180704114427.29953-1-vkoul@kernel.org>
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

