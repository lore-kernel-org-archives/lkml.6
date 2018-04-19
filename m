Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+QQC+nwyWx77cVNmH5qF9YTRHHySffLnNZHrPQywLyc/K17rq2eWSoqO2j2WZxme0P59TV
ARC-Seal: i=1; a=rsa-sha256; t=1524151270; cv=none;
        d=google.com; s=arc-20160816;
        b=YiX+6h8ccoMCF2tMZS7ZPIQGlGsqOq+HG0IYnPx5jngiLScjN/U2N1FUANuwq3znxR
         fIfRjVhKOwnPGH+k4v/ejrEuLxF3Cv8zZhw3rhwdueKagbj58n8LRnkOlPxBhX4CFeBI
         HjVT6niN4smnRm4STxN3kKdwSrGesLQMVhN3UFQMNY1iCMzhiBS+/mxRqMl34DAW88LK
         Ai/J85L/n5JH8ke7pYAe72BlJxALx6JCWJ3rOpSqoGqpYdIVeRG4xzVJSBvooWPxcceN
         QdiWWABphjsq404ujpndW02ngsXXfkogWBMKL8EdvGtgh52dcwxrJ3PqQusY2m8yGzH5
         q85g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=UMLigqAxBeanJOmY+w6m2DrM+2kYI8rP5egVbJZ7ZFs=;
        b=YajAljnafa9iHxinyDUYan7xjO+cgevP/j5XJ+JZritKqpZeaQzxwaM+w4142A3a7v
         qOQs0nnWEiDqXbXyD5zS4/0yk/eGOND4ZFenPm8IdBcIO+/gDHePb2JBjHLl7O/YVvpM
         82O2sDdHhJP8kXCXOfWnvX6693Xv7/lEyJbzGfy2FOyD/kFIHIaoNd3dSRDJMWZevS3I
         gG1y0ujDx7o0LoUd1TL2br2paENdLM1PX3Hz/VpRSsh4n3PR4EWnqVmCyrHFFtkoQfAD
         LvK2VGhyvRiTaMJN9026SsNbihw2k5y3HvXCHhYN1sD/CS9hzvpMI/YFIhOlqdRYXmx9
         gRBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=S/iNTAPS;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=b0SNtZYq;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=S/iNTAPS;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=b0SNtZYq;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88C71602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: dmaengine@vger.kernel.org,
	timur@codeaurora.org,
	sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sinan Kaya <okaya@codeaurora.org>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MAINTAINERS: add maintainer for Qualcomm HIDMA drivers
Date: Thu, 19 Apr 2018 11:20:32 -0400
Message-Id: <1524151261-13461-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598188443339699993?=
X-GMAIL-MSGID: =?utf-8?q?1598188443339699993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

drivers/dma/qcom directory is being shared by multiple QCOM dmaengine
drivers. Separate ownership by filenames.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff14894..111dd8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11669,6 +11669,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.g
 S:	Supported
 F:	arch/hexagon/
 
+QUALCOMM HIDMA DRIVER
+M:	Sinan Kaya <okaya@codeaurora.org>
+L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-msm@vger.kernel.org
+L:	dmaengine@vger.kernel.org
+S:	Supported
+F:	drivers/dma/qcom/hidma*
+
 QUALCOMM IOMMU
 M:	Rob Clark <robdclark@gmail.com>
 L:	iommu@lists.linux-foundation.org
-- 
2.7.4
