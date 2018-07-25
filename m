Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC2FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753E020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yI3/axgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753E020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbeGYRgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728542AbeGYRgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:36:32 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 733F420891;
        Wed, 25 Jul 2018 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532535850;
        bh=He4b6slkT3vxHcc6mvTwXYYrCHVAkNQKDDYcg2w2nOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yI3/axgrD1QIlfdUdat03BI+e0Z+AyApz3B9TM49NRVd/ZtexhMmFaW7VYrfdxfYs
         /X9E4evKeX9exfnGzwLiC6EwMrzTfFsrzG5Bps36PgwEQngMnOOzXMg9xoYzmIzsZm
         QSse/cPXB9GWqrqk+adCE/NJK+YsdW0Upecly8jo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/3] ARM: samsung: Mach/soc for v4.19
Date:   Wed, 25 Jul 2018 18:23:40 +0200
Message-Id: <20180725162340.7488-3-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180725162340.7488-1-krzk@kernel.org>
References: <20180725162340.7488-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rebased on v4.18-rc2, because at v4.18-rc1 the NFS root boot, which I use at my
testing setup (https://krzk.eu), was broken.

Best regards,
Krzysztof


The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.19

for you to fetch changes up to cd4806911cee3901bc2b5eb95603cf1958720b57:

  ARM: exynos: Clear global variable on init error path (2018-07-24 18:52:14 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v4.19

Minor cleanups and fixes.

----------------------------------------------------------------
Denis Efremov (1):
      ARM: s3c24xx: Fix typo in guard macro of s3c2412.h

Krzysztof Kozlowski (2):
      ARM: exynos: Remove outdated maintainer information
      ARM: exynos: Clear global variable on init error path

 arch/arm/mach-exynos/exynos.c                | 2 --
 arch/arm/mach-exynos/suspend.c               | 1 +
 arch/arm/mach-s3c24xx/include/mach/s3c2412.h | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)
