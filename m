Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A84C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EED421779
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="uI4ZPCV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EED421779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbeHGN40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:56:26 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:50250 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeHGN4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:56:24 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v4 00/18] JZ47xx DMA patchset v4
Date:   Tue,  7 Aug 2018 13:42:00 +0200
Message-Id: <20180807114218.20091-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533642145; bh=Gu/eO+hMxepg6IBh/SyeupsplejTZ/UFq8rkOBCNUYM=; h=From:To:Cc:Subject:Date:Message-Id; b=uI4ZPCV8UaVu52KaqTKrov4PKCpsx3qS0HhVvYMbQXT0isX3+t3VEk80nweAc/PNkPQn3iJJCcR5fMmjhITdYrbb3mKp8BdqCacr0evotMw9WLVn2SOnX5jgrYuqT70BpbOtQR+d6wrdhcwXE8qh91pw65OYbtqWuCkWNt38ncc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the V4 of my Ingenic JZ47xx DMA patchset.

Changelog:

- Added my Signed-off-by on Daniel's patches

- Removed the jz_version enum and IDs; add a 'flags' field with
  corresponding macros instead

Regards,
-Paul

