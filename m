Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AB8JxZp+HAto9woKoBX65i3orrREvXasFHlwN3IZrs6RECr8QKD+mun60ObgDRopkgYdAHNTyRMy
ARC-Seal: i=1; a=rsa-sha256; t=1524821107; cv=none;
        d=google.com; s=arc-20160816;
        b=KDrrjtorJXAYKF8OQ5lFT7ACH1ne7osJag/+VJurn2MuKMdQNmDBIL5sZvz2bd3hcO
         LpjOJeh1I2x2XNsx7KPoH3WbFi6/zlAjdU3JOuI0juAsi0GbaKoQnBgfymfoep4mtkqP
         UAhEb60yDDMr38AV853ayCPwkmpE0aIIRBLQozYOhdDjUJ3HshNQrjUzP63SeZiCUJgS
         8boE6pXgIvGUxCTrZFgD0X+av0nvE+aZsQ8RwpEwi1NfSijjcejuSrA68ARylMFP180K
         jniFhQ9gobFwdnq99tq0RBWkQfCT/S55ivUWfug1HO/AoxFLeHVPCm36GoM/+CCW0icQ
         SOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=vVFGwb1CcACXnsfB+FBpGhLM1ucyCT1aA8qotLT23XE=;
        b=YsoV6e9gLzvcnLvoV1GPGhy9eEmx0tfMBe8NdOdJGelbMvEQSeeoKREx3NThzaLyKo
         +3nXHwoQnhDEDdMy45YAz7E1FUIrwk3F0d/8IE8TPCDS7YIoKxEhf2j+KkZ00/FDy8ZY
         nK7nW4bsOdPuzQZrj/buD1+RtF7XohCfcXYKL2Ici7iugsFx0inb7kUfiuC9OlVP2G8b
         vzC0/TO7cLXukSYM7XGeZ/zimEkNMcMFrYFesRiarJTCp94DQ8BXP1Y5cmQulKYlXb/J
         7x5jGcYD5GzoPiskRuAL+vIF+b35ytUgi1hHClEuKzAJPV3Z8qkdDvXHLpvA81MA760M
         cnTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0C92187C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=matthias.bgg@kernel.org
From: matthias.bgg@kernel.org
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
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v3 10/10] MAINTAINERS: update Mediatek Soc entry
Date: Fri, 27 Apr 2018 11:24:02 +0200
Message-Id: <d4283880be7689a83affbd8548a999731cb7c031.1524820923.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598890817331198711?=
X-GMAIL-MSGID: =?utf-8?q?1598890817331198711?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Brugger <mbrugger@suse.com>

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
