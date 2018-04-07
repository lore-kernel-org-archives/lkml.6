Return-Path: <ctatlor97@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523123959; cv=none;
        d=google.com; s=arc-20160816;
        b=PBXLA3AsYmBm6SGIFK3jhes0qTKAuYscnFZchPpHxXPhAx9xcb1q9f024l8tRykrkQ
         AhXTB6aR+2P+d11h4tw+i92vAMCStMmlHoddBcmrbEsHzVM0GZFOtyJM1zvQDw5gFqlR
         8Cs9BynD3vxPh3t+nKSGGu3iKxCoIMsqdE/9wo+9qmqvfl2xnxM/LwDuthy8Zy9hSmVv
         CJkmjCBCB7FLs2K9eCTR/7uv6+rORJyv4dJl6JVFi0cwPbnM9bKDTodZphLpC6lSlFPr
         6+aXVBOXhzknqbazOVPoXoV8LtzXCiYN5QLPL1H8A3uNxY2+AqqRaHZXu4htmmoRqapQ
         kHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=3+Lu1cuPv2KAGUypxiz9BeQF3GGrzqjytzvVMKn4Xd8=;
        b=w/lQoSXlvXd7W1m+2SG3cWm/qPGYZ5860nIC9Giuu9qsdRKb9TnF9TvObMgW+3yLkx
         9v3/9JQ1kVU/3z+zxmr1J2+T/3fuX5I/suV+OWJAENpZmRjf/QlqmZpuSdfI1cudj2/x
         8vk9YQY9/VYVI6gD8uLQo8s8NANPnkaR9zhiGFOsK7N2ZnbBxGqWuHwbyYolMo5WWfqN
         QqghtKH69hqI8F8BY2z/ahCJuh+V1EF6Hgq8XGuXqpmBZDhyIJe3u3JWMpDlnp8xtnof
         rhl5zz4x6bbYhr9+j2a+Exv1lCanJnBqrPU6pfbNtCwY4A4AUA6cGjeyHOAEbiUjf2Ww
         AckQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ye00NFhW;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ye00NFhW;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48V+X1gEv1MMEJSa8TfHZ5bbOkp570vEGhv6Ib4IlrhtSM4pRYp7wsNvJDVPA+GoXJdv0NLog==
From: Craig Tatlor <ctatlor97@gmail.com>
To: 
Cc: ctatlor97@gmail.com,
	linux-arm-msm@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] MAINTAINERS: Add entry for the Qualcomm BMS
Date: Sat,  7 Apr 2018 18:57:46 +0100
Message-Id: <20180407175802.29444-3-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180407175802.29444-1-ctatlor97@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180407175802.29444-1-ctatlor97@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597095411222216578?=
X-GMAIL-MSGID: =?utf-8?q?1597111229221758159?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c3ad62c638c..aaf54b665f86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11605,6 +11605,12 @@ W:	http://wireless.kernel.org/en/users/Drivers/ath9k
 S:	Supported
 F:	drivers/net/wireless/ath/ath9k/
 
+QUALCOMM BATTERY MONITORING SYSTEM
+M:	Craig Tatlor <ctatlor97@gmail.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/power/supply/qcom_bms.c
+
 QUALCOMM CAMERA SUBSYSTEM DRIVER
 M:	Todor Tomov <todor.tomov@linaro.org>
 L:	linux-media@vger.kernel.org
-- 
2.17.0
