Return-Path: <mbrugger@localhost>
X-Google-Smtp-Source: AIpwx49AWkPJK1cuxBPOnFmQiQoc6KL9hezz3sI5SD5mwkxz5y3KumAN4j09ociNney1Y337V9WA
ARC-Seal: i=1; a=rsa-sha256; t=1524497543; cv=none;
        d=google.com; s=arc-20160816;
        b=nBojFFl0r8uKGTWtxwQdCZie+DovI3Y2czF2WWSu95Um2rD2K+XwxDMfS10hBtmcTs
         n6gvQGO7+qXpTZRNcOi/Lgh6nRepwKBdlIsqgo3FJNT6fcTOQMco2BTQkI0qpJLw+3wv
         IR4f71UU87RyIwLHImbUXZKpCrhVp0y+ja3QzoLBI8NxFmS3LBsM62Ml0mC1ZKD3iPNM
         3Z6TnHpWUYxHrlXbQ/LQSvA7g0Ga1Mj1WU39DW/XoLq1oTD1752rD506zBaM7q/uPjM9
         epRwsXXcyruAGwDLYLTeXrJitl2SrcdO0x5OnQYtc5O+zIyoO/HmvQ/r0LnqfbMGev+w
         mP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KYHrCaV6jF2/RRqudYnt9qxb0g660gNt3sh7wKNhBg0=;
        b=iv06VcVLmvL/0CShwgYCIYV98J1L3VZbuTmngK7qUKOEJwaWwwaNLUx7DVDS8McEvo
         zuZUoSguI7g6AXIoCvsasqONhxNOwdad8rVUj6+cYVDwv1FR5Nc8uvKgaMwxpEqwFfFP
         dRKSOjtc/7cCB+yIX3Xi9BRWNuC13PdOp6fJF/jZRlobz9GTTzltwisbtYPHN2hO3OaL
         Gy7ymT7A/3Y8/Wo5fa9vEVjA/DiA6EAlmPDTH5juRwn/c8aE+J45dCBx791vKTbCpPxO
         +oeuynQ50Lazs7G6ScM4pA3svPYO4vLBW85RaaVDkaN3Xl0DZapmddszxw1kJ8XSQeic
         hMDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
From: Matthias Brugger <mbrugger@suse.com>
To: ulrich.hecht+renesas@gmail.com,
	laurent.pinchart@ideasonboard.com,
	ck.hu@mediatek.com,
	p.zabel@pengutronix.de,
	airlied@linux.ie,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	mturquette@baylibre.com,
	sboyd@codeaurora.org,
	lee.jones@linaro.org
Cc: davem@davemloft.net,
	gregkh@linuxfoundation.org,
	mchehab@kernel.org,
	rdunlap@infradead.org,
	pi-cheng.chen@linaro.org,
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v2 10/10] MAINTAINERS: update Mediatek Soc entry
Date: Mon, 23 Apr 2018 17:32:09 +0200
Message-Id: <0fd5bf87d227fdb44bd0ddd2f83c5595380957fb.1524497268.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598551535960783123?=
X-GMAIL-MSGID: =?utf-8?q?1598551535960783123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Mediatek SoCs include several soc specific drivers as well
as a mfd device. Add these to the maintainers file.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d5a621..74f7ea345096 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1621,6 +1621,8 @@ F:	arch/arm/boot/dts/mt7*
 F:	arch/arm/boot/dts/mt8*
 F:	arch/arm/mach-mediatek/
 F:	arch/arm64/boot/dts/mediatek/
+F:	drivers/soc/mediatek/
+F:	drivers/mfd/mtk-mmsys.c
 N:	mtk
 K:	mediatek
 
-- 
2.16.3
