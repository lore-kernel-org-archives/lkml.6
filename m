Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2E9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAD9214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9jRDzR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAD9214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeJKBt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeJKBt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:49:28 -0400
Received: from localhost.localdomain (unknown [178.38.103.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FCB42098A;
        Wed, 10 Oct 2018 18:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539195967;
        bh=miTSO3Rbker/U+ecoSQKe1yt3lse3WnKfLq3gexgOLs=;
        h=From:To:Cc:Subject:Date:From;
        b=o9jRDzR50wZJaVowBlJJDyjog3gAfwEYtbJHJMddDpmfmC86sU5HSec8vk5OL9REG
         7p4TDOjxsqtWjaN7uBRFqmpL4ohaM81FKoV2w3d8Mdjey4GBiqYr3ltV7IGyyGgMxM
         HSEoarhnkNY8FIFOS0oiNQPRqF33TsuoZHdlyCT4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 0/4] arm: exynos: Last round for v4.20
Date:   Wed, 10 Oct 2018 20:25:54 +0200
Message-Id: <20181010182558.7034-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just few left-overs. The last mail (4/4) is a patch directly, not a pull request.

Best regards,
Krzysztof

