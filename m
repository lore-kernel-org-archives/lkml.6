Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A39FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE87218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545163818;
	bh=a1bfEZsI4yWUP/xuJWMQJY1H78hazjgTE7mf64t6iYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hOMMRZx8S3s5snHToYrw4HKuD3sX+Gm3aubW/GKPQQyJ5kb/BV229vJwlM3iyZBle
	 3cMsDQn3M/+FDHAypvE0XMHGP6RuQqNzwuIELNy0cKXUbA8AgbIyCz560MkAQa0ZxA
	 pOlAjlGqrF5RnwCzh1c2dgmQzyNYtvOXOgu8l9Zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeLRUKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:10:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeLRUKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:10:14 -0500
Received: from localhost.localdomain (unknown [178.38.170.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10786218AC;
        Tue, 18 Dec 2018 20:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545163813;
        bh=a1bfEZsI4yWUP/xuJWMQJY1H78hazjgTE7mf64t6iYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vtPE5pMMk5GvfdLIhH9oGgQ1WjDbzW1Bu1COTU2WtVE1r2O0B5+4fL956D9gbyL3F
         7YQwBdvNr5bKkO/btrkXRNdiKq7+Fm63rXHqT8VVU3Dj5Gz/xvV3igzNL5VUa1MD7R
         Sy7h6AcavMG99sg+Ch7mPfVm/p1j++bLinJBjyik=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/2] arm64: dts: exynos: Second round for v4.21
Date:   Tue, 18 Dec 2018 21:10:03 +0100
Message-Id: <20181218201003.12806-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218201003.12806-1-krzk@kernel.org>
References: <20181218201003.12806-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 9deffb5ee78e41e2a5d6c448874a24caec6467d0:

  arm64: dts: exynos: Add all CPUs in cooling maps (2018-11-18 15:18:42 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.21-2

for you to fetch changes up to 74ebbdda7cecf789661c208faccbeef10a7f05da:

  arm64: dts: exynos: Add Bluetooth chip to TM2(e) boards (2018-12-17 20:23:32 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v4.21, part 2

Add IMEM clock controller (for Security SubSystem) and Bluetooth chip to
Exynos5433 TM2(e) boards.

----------------------------------------------------------------
Kamil Konieczny (1):
      arm64: dts: exynos: Add IMEM clock controller to Exynos5433

Marek Szyprowski (1):
      arm64: dts: exynos: Add Bluetooth chip to TM2(e) boards

 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi            | 15 +++++++++++++++
 2 files changed, 29 insertions(+)
