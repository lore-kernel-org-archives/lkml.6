Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93E9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECDE2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="beXKfLRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECDE2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJKBtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeJKBtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:49:31 -0400
Received: from localhost.localdomain (unknown [178.38.103.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB95B214C4;
        Wed, 10 Oct 2018 18:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539195971;
        bh=KOxhfdnQoRBiQjS1n+KX2tgmxCyU3vxKOoUG53r0h/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beXKfLRengWUPIJ/TxvM+LDNrijSGBU1TD0l1+LHfHTGu7XBL9I+qq85NIgS0lNmg
         so+/auZZkEhX4adq3RtW9koL065d2xow3Sql6bfOROzU4X/ysOvNZcGrCi+/osm62y
         LteZCixGPcf38SKVxtnOGxJFCiNv12Hs6sZI9dLU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/4] ARM: dts: exynos: Second round for v4.20
Date:   Wed, 10 Oct 2018 20:25:55 +0200
Message-Id: <20181010182558.7034-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181010182558.7034-1-krzk@kernel.org>
References: <20181010182558.7034-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit ff1e37c6809daab75f7b2dea1efe69330e8eb65b:

  ARM: dts: exynos: Correct audio subsystem parent clock on Peach Chromebooks (2018-09-24 18:55:16 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.20-3

for you to fetch changes up to 48ab742ce3b0312f2ee23ed825d3c8820eda7acf:

  ARM: dts: exynos: Add pin configuration for SD write protect on Odroid XU (2018-10-01 18:51:51 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v4.20, second round

Add proper configuration for Odroid XU SD write-protect pin.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: dts: exynos: Add pin configuration for SD write protect on Odroid XU

 arch/arm/boot/dts/exynos5410-odroidxu.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)
