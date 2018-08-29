Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECF8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD1C20652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nR0Vo3tu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD1C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeH3Bbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:31:55 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51950 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeH3Bby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:31:54 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v5 00/18] JZ4780 DMA patchset v5
Date:   Wed, 29 Aug 2018 23:32:42 +0200
Message-Id: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578385; bh=P2zeDZ4eN3KanGl3b1TYQQanGGSDgw+wuqlU89HN4+U=; h=From:To:Cc:Subject:Date:Message-Id; b=nR0Vo3tuk8JsqrlHf2zPs2woWWISPLVHJAt7d74IVtieGgHmlP1XX908cS5TX5IEI3jQcKB21Lpkb3SBa6Cr2lWiwvNxc+5JkUuDEdNZNzIpgot3YTr1m0SGYsE3aeXn38KJoNkDp6kIov+ExESnRBMsRpUlt4SOZ/mAll3QNiA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

This is the V5 of my Ingenic JZ4780 DMA patchset.

- Patch [01/18] dropped the "doc:" in the patch title;
- Patches [11/18] and [12/18] now use the GENMASK() macro.
- The rest is untouched.

Thanks,
-Paul Cercueil

