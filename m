Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E9EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CAA217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="bLg0Lq0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfBEDww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 22:52:52 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:54440 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBEDww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 22:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549338770; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=OiDLL6/XkCX4PH5wOG5uANFiN9Hh85FWVObphrnvWNU=;
        b=bLg0Lq0jh6yjc0YaXwEKaHbUMflff5uhzxWzSdFU44ZrnJM1kU99QxVgh/JDsOp5GKb/rQ
        fmKSEp7HPqcVAd/WL4YthYvUif16cv6YjvvXlkQnuaaE37AdPPQ/PSTTCXre4KZPBNLsx5
        jVQf+22JD0gpz11hazQGKodFQN3zcB8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Ingenic JZ47xx NEMC patchset V3
Date:   Tue,  5 Feb 2019 00:52:36 -0300
Message-Id: <20190205035240.31410-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since the V2 of my patchset I could test it on the JZ4740, and see
that the hardware is the exact same as on the JZ4725B.

As the JZ4740 is already fully upstream, and also older, I now add
support for the JZ4740 instead of the JZ4725B.

The only patches modified since v2 are the 1/4 and 4/4, and the change
is a dumb rename of '4725b' into '4740', so I kept the Reviewed-by: for
these two. I hope it's OK.

Cheers,
-Paul

