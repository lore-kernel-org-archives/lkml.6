Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELsiT+4T81JsawOeAXveFLmSX6di1DwSUUfx3/VYSmVwvsdZWFiqsPPaTC7aZsfJ0OEjRvM4
ARC-Seal: i=1; a=rsa-sha256; t=1520281692; cv=none;
        d=google.com; s=arc-20160816;
        b=cZT6Br5dhaKSLss3YfBRbBVwzNrFVRP/tEyfb8ZJ8LZUoSe0CvTUyWFLfcm3dRdmhV
         4jD+39yPdv94/0pATVtzOerTkYqwL+6iGdWrnt5/ntCYClivtwVWw4k35UHHKR4HRjdm
         P3zN6c4az4jXX3DvXiAnFoF+bYAmP9l1femVi658VRszXpxPC9I1H/UPF4DEU9/WH4Pt
         Nh+76CaeQ47rPtVAJAVFZ4SeWvEROy8odRIQl4l+NaTD1+t+ug8iEs9ZZfut/Bh5vIS5
         dAHwlWklNvfrNU6pN8Sh06rc2XgUAa+hQ5oz6+hKBScVPPhgGiGkmM59MUgoSjaMKAw8
         vmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=qLC5+mtpsE8WtQLo06npyBDERaEtE9FkiC+hdmDPP4w=;
        b=d7fLzGOswo2MYmijF4uhDjnzVeeVl9TwHq3gNS4NArJFT6L9EAiSUn2ZIRVYgZtkaN
         zli227H8pA732WldSQeildKhh+MIor6MhC2nBsmnvsnoChp/Gwyw2Toeeo2PRnt/kIf0
         TrcsT5Lw0H7XA2NOF7zMscNFCO6Z324DJzpaMrkY9dqqY6j54n+nCuuB5iDYS3VKCzVC
         9d3CX4VYtQyxIRsVwN1qaCG9K7buyXcTl0qC0OMz8O381Vz3byi7CZrRBGU5mIY1E4hO
         KY26VpWp/Qr2cyagIsiG/QKBStfNBGYkrTQaMWVSdeLTnZIPfoA4ddVi7n0t/+RJ1sZN
         5RMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/5] staging: vc04_services: Remove dead FRAGMENTS_T
Date: Mon,  5 Mar 2018 12:28:02 -0800
Message-Id: <20180305202806.21219-2-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180305202806.21219-1-eric@anholt.net>
References: <20180305202806.21219-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594130895367523113?=
X-GMAIL-MSGID: =?utf-8?q?1594130895367523113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It's not used in-tree, or in the downstream tree.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
index 926c247fd9d3..a6c5f7cc78f0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
@@ -49,9 +49,4 @@ typedef struct pagelist_struct {
 			 */
 } PAGELIST_T;
 
-typedef struct fragments_struct {
-	char headbuf[CACHE_LINE_SIZE];
-	char tailbuf[CACHE_LINE_SIZE];
-} FRAGMENTS_T;
-
 #endif /* VCHIQ_PAGELIST_H */
-- 
2.16.2
