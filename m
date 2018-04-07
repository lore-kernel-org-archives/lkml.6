Return-Path: <ctatlor97@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523109634; cv=none;
        d=google.com; s=arc-20160816;
        b=vwNfmXM1HlOIB2syJ9aCWisit8UczvwXYmZWbrfEESnfQJ595K0pN/yatKV5stKdYg
         UkDA2ZlyhiJEBnhM+YahMFJMVk3pF9fa15Wa2GqmJHxGwmWJIb6+O/CPNm2qWWAF9SoK
         1J61P+4N2g87V4mSxzKh0mIF+Lxpzv7Hl2HuYIMHjmryijRZ/YbRNjMFhrAPggBgnjDq
         lZ9oI/tW4AMR7btRDVKdvmXPDcJR7W5VWncpIWHP8nVa+8JiGY9PNGinwfr2a7I+JJly
         s70e9lipPZP8GGKMlieruE4YQyok1uTZsXxETQH/6iGYq6cN0Hi6U3QuPs2T7eD7qNPj
         8n3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=3+Lu1cuPv2KAGUypxiz9BeQF3GGrzqjytzvVMKn4Xd8=;
        b=SZwa6IWUGSe+YDMt+1f6eqdXsnCuRihprjXnshvCTxMt5TRtMXZB01jt1H29Dzo/Vd
         k1IAoETcXbZ1RflJgDztQu3gdPvzN6yEo1X4jcW/+RLzFOkoks7enAW0/V17PZXhSPru
         gx5+txkQNy5Xtx27UfSEt0EgEv+6D56Dv3bbmGstM8EZPPCUo0JFkWD6N0Rdl0OmGpIR
         VmCVfFkga2zLhJqVEgXbuURqr7vrO7d12OmF450l95DpJG/Q9lV3vc6/1AQbrOhctvNy
         1aG1zoQXSSRxozjmXtOH9FuAme4eFTgQULzpuj8tmYTKA2JH273UZt/HLUDaJuPH2qR7
         qreg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lRjpUAw1;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lRjpUAw1;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49d92YRnxTcNesFsCH9xw8F3/ZTwa12C98nZnFpzHRUgvY2wkrpShXwxzVzyrNCiayOo4E8tQ==
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
Subject: [PATCH v3 3/3] MAINTAINERS: Add entry for the Qualcomm BMS
Date: Sat,  7 Apr 2018 14:59:21 +0100
Message-Id: <20180407135934.26122-3-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180407135934.26122-1-ctatlor97@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597095411222216578?=
X-GMAIL-MSGID: =?utf-8?q?1597096208064591134?=
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
