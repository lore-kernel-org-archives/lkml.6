Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AIpwx49N5blLrDAu7a8IFrqc8usMWfi7m5DdGmmKJ0vr73FqCgEfwbXDgYOfVE+mnyK7dElew4V6
ARC-Seal: i=1; a=rsa-sha256; t=1524563292; cv=none;
        d=google.com; s=arc-20160816;
        b=NE2JBPUJ5oEGSFOyhfl2zXO7ptLFloIyQ+nT4ikpKowJ6OSkXVJ1RvEZYX2/SIw1tu
         Ausvn9u90dSkZD4EpZb0rYPI66GZYP0SHWgsl7t1E2hKz4a0tawQlrrvY6lJFn171Gdr
         vWxiNdU94eUvzmuoNA2lKyh9bKQsh4Y+zWb5Wc85T0vJiFqGDnVzr82gJaXsC9VBhqoO
         T4aMZ9kKFcduzZZO30Q4BxLCRwX1MLXaFH8XR8mlx0wFEVwEG+FFUr8R+17spzFU4QPx
         zQqZhOKzIoHsbMQBhIIeTv0pU/ysR3FPMMkUhadF+YQd9/dxmvghUtJZ0XsySvMx3e2c
         SPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=vVFGwb1CcACXnsfB+FBpGhLM1ucyCT1aA8qotLT23XE=;
        b=JsFaxCqrskBPsw+2Ir4r2HZAG8dmhx8lSGRynP7n2FbAgC3sqvEzBX+3rmzZdUreDV
         SB8w5/Kd6VGbQ/9ISjPp5DNEzrDstZbSlae/uRLg+aVvBm7AqhF9IUe/KHafOnQHCzC2
         TQbCbhjMn1cz3JDDdD7kNxmyfR8tlowzWtQtLYfQwkFmai7ppaJbUZ06InrJa9BKUswz
         cL+MG6IIeiolJk7n8LA6hD7jBEbZ5amu5ymmcG57Q6aHR/Fg6hHfODN75nRGII8HLc2F
         jiC16fnXCpOzdvn50GPFDppaYR5KmTy9hzCJrD5EX+O0W1G/vzmNEf0TIJ5yKWmzj4sz
         E6Cw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2892183E
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
Subject: [v2 resend 10/10] MAINTAINERS: update Mediatek Soc entry
Date: Tue, 24 Apr 2018 11:47:07 +0200
Message-Id: <0fd5bf87d227fdb44bd0ddd2f83c5595380957fb.1524563001.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598620479276938864?=
X-GMAIL-MSGID: =?utf-8?q?1598620479276938864?=
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
