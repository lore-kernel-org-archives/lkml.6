Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606A0C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155A021486
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA+8xNZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155A021486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbeGLQ5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732453AbeGLQ5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:57:32 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA9F20BF2;
        Thu, 12 Jul 2018 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531414032;
        bh=B75ZcA72qhjKsG1oTV2YqileQdDlk5P6oLNYFJlvoZc=;
        h=From:To:Cc:Subject:Date:From;
        b=GA+8xNZhwGI59d96XJV80o37Ljot8F5IMXvlLwLcIjL8B25Ir0DAXS56T+rRBV4dU
         GpEpXFhSFyAFmf5KCVN6tI1uEtqYQuerV1ZvjsRBq6ZZU2sKZ3ZuxaT/7WnxGg1YGv
         +85abKjpPvS5vYD6krcIls9r13Orq5UjAE6oSPzI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 0/3] ARM: exynos: Pull for v4.19
Date:   Thu, 12 Jul 2018 18:46:38 +0200
Message-Id: <20180712164641.19925-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Only one unusual about this pull-request - it is based on v4.18-rc2
because at v4.18-rc1 the NFS root boot, which I use at my testing
setup (https://krzk.eu), was broken.

Best regards,
Krzysztof


