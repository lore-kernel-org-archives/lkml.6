Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B983AC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7282E20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dUfWyphF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7282E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbeGIMPt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:15:49 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60970 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932568AbeGIMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EckGojGkS2pDoQG1LNsCXKGCD+1DRrfA7OmGofV+UAM=; b=dUfWyphF4mb/5nK4KPT3mxd6x
        QzMpkBiKZg1CRPEtfdLQlM4EX/UCyNoU4pAXBSUWyWfOQZdQnjt4ZFS8ecH7l0Q1iZXYvOVuALxAU
        bt7LHHgtXTd7VrUqHz92GZAdidYSyhtVwqhd1FiHZOXzE/aicvwnuachV+iTD4Ur84m04=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:43273)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fcV4p-0005d0-Qv; Mon, 09 Jul 2018 13:15:35 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fcV4n-0000So-Bs; Mon, 09 Jul 2018 13:15:33 +0100
Date:   Mon, 9 Jul 2018 13:15:32 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Update TDA998x maintainer entry
Message-ID: <20180709121511.GF6920@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my TDA998x HDMI encoder MAINTAINERS entry to include the
dt-bindings header, and a keyword pattern to catch patches containing
the DT compatible.  Also change the status to "maintained" rather than
"supported".

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Andrew, Linus,

Please queue this trivial maintainer patch, thanks.

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e950b8b4a41..8101638ae61d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9935,11 +9935,13 @@ F:	sound/soc/codecs/sgtl5000*
 
 NXP TDA998X DRM DRIVER
 M:	Russell King <linux@armlinux.org.uk>
-S:	Supported
+S:	Maintained
 T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git drm-tda998x-devel
 T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git drm-tda998x-fixes
 F:	drivers/gpu/drm/i2c/tda998x_drv.c
 F:	include/drm/i2c/tda998x.h
+F:	include/dt-bindings/display/tda998x.h
+K:	"nxp,tda998x"
 
 NXP TFA9879 DRIVER
 M:	Peter Rosin <peda@axentia.se>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
