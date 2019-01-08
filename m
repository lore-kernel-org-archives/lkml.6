Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E76EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A1F2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eKKSwlCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfAHUuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:50:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfAHUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hII5hqjpPDygDvjgb+X6H2WtdAk+TY22x4uXJlQwkoE=; b=eKKSwlCU0EbfKeNTyHG/6e9VDj
        8ISVQGdHnoeKwT432I/twykMzbpVrm7wsADH8/T5Dx5tWR0fS/iMfogyUxlWgVaI+Ou5apHiOG/2n
        HD62kVuXfSIqQJLRI49++1QtCCiYv3KilVmsmqKIeDn74jZTsDtXCTwHlBM1pZgHxIRbKTLySKLyH
        k6No3dg2t1gz0K2ocXr3tkqOVYfvGn/C03dngBREp9MUHWy+bMEDyFH8Oh4Hu8QvzaxigX7xYL+bb
        abVYvnvSE9M29UMgXKtk2zt27APwSuWFZ4B81l0dNCNaCwy+I4UVR1HteGOHC95gWRJTN3CPFH5G2
        IIwsalVg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggyK1-0006V0-GL; Tue, 08 Jan 2019 20:50:01 +0000
Date:   Tue, 8 Jan 2019 12:50:01 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] etnaviv mailing list is moderated
Message-ID: <20190108205001.GG6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Matthew Wilcox <willy@infradead.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 32d444476a90..44888eb121d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5141,7 +5141,7 @@ DRM DRIVERS FOR VIVANTE GPU IP
 M:	Lucas Stach <l.stach@pengutronix.de>
 R:	Russell King <linux+etnaviv@armlinux.org.uk>
 R:	Christian Gmeiner <christian.gmeiner@gmail.com>
-L:	etnaviv@lists.freedesktop.org
+L:	etnaviv@lists.freedesktop.org (moderated for non-subscribers)
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 F:	drivers/gpu/drm/etnaviv/
