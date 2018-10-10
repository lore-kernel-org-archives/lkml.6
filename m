Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE72BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0272098A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxhBc3gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0272098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJKBtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbeJKBtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:49:39 -0400
Received: from localhost.localdomain (unknown [178.38.103.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 439F02150C;
        Wed, 10 Oct 2018 18:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539195978;
        bh=/Bq3uWh4l+xbfCJS+T+8tE8UcLIsAMQ+fKt+d1bjrA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qxhBc3gczZzwfzzVeatTuZ5kT0dwQE179qmY7sk/E2u4UWKiXNBNUBknrXX3nWg8N
         2dfsF+cFV6gkUtREryzaCl0GmTSeiYZwc9MSnQODk0b/SdSOqfcpDsxBCQqgkdRx64
         yQt6Hk/2qI78Lr9rBKwfmYTw8dBC2ECr7YUADqWE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/4] ARM: exynos: soc/mach for v4.20, second round
Date:   Wed, 10 Oct 2018 20:25:57 +0200
Message-Id: <20181010182558.7034-4-krzk@kernel.org>
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


The following changes since commit f30858439e7db9ce9847eaedf440635fc6349c6e:

  ARM: s3c24xx: Restore proper usage of pr_info/pr_cont (2018-09-19 19:11:17 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.20-2

for you to fetch changes up to 6862fdf2201ab67cd962dbf0643d37db909f4860:

  ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos platforms (2018-10-01 18:42:48 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v4.20, second round

1. Disable SAMSUNG_PM_CHECK Kconfig feature incompatible with Exynos.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos platforms

 arch/arm/plat-samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
