Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x224Mbkq29HhaAiNHUIGpEUVLqs4Vam4H87BglJNw0/yyYnRP30S2WKq1dKWVjCrI/pDfU/2h
ARC-Seal: i=1; a=rsa-sha256; t=1519229786; cv=none;
        d=google.com; s=arc-20160816;
        b=pRODxolQgtkcqgmA3ZB/DTZU2gsIZucxJxAG4TNntdmOQPUduk1/85um989Pqi0/YD
         NuawVTP3aBBB1AgOrXanXfGVP0HRvUlzxg3+2+BBmsLi79kAwp6RF5OQ1iMXDKzz2SHq
         8+xWdXLAHLp/LSiWK/Eu8SesAJBN6/SL2Cxn0Xg+GyW5OM7u4/iHR71Nc5A4NtpFxJwc
         k5gWQ2/kZQQdHjWfptOTH5XhJCjhdhr+/EFMLlPwAR/VcZlIWyZanLS14Y4FBPM0i1UU
         D9JFwRJKS5iqfLfC92anGGLEP4zdeV80G78VXAOiP7z8x9y2RF815RekFe+XkgUvA4YN
         o42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=66GXAcM+2sV/MureZW836ChXGo0li9SbZPLoMVoZ7NE=;
        b=FZOIWmBql0vhDJ1KyKivw+/Ev/H0sMVDW3V5iYKZGI4bFrSBfOnjY6YRg51F+xJmRT
         Vxjk/jjmt8r2FCe0qzbiL6aoF3oSZrIj7pagJ2ieFvIk/FnGHg6RDSIUDAVF3T0Yjo2R
         QlpYYZEh9/h52Wfi6Wh7/GXIchIrE9ELk80DkD7r/FYlqQr6akqggrFQwPKyZj88elYh
         FxDlTmA/4tpx8VKI6wq1Kj/f02QRdNBfGfsW7Ave0omr7e4//xIApK1LAtQTcG1DMbC3
         blB4SX9wYkzfM7tJdL2xHhIcOZ/wWYWnQHOOtdBZB50JBUDxMIuovPl/G7mW2v57scBN
         n5Nw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="29617858"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: joel@jms.id.au,
	andrew@aj.id.au,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	benh@kernel.crashing.org,
	andrew@lunn.ch
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	openbmc@lists.ozlabs.org,
	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v2 8/8] [PATCH 8/8] Add a maintainer for the PECI subsystem
Date: Wed, 21 Feb 2018 08:16:06 -0800
Message-Id: <20180221161606.32247-9-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027892847299682?=
X-GMAIL-MSGID: =?utf-8?q?1593027892847299682?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds a maintainer information for the PECI subsystem.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93a12af4f180..f9c302cbb76b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10830,6 +10830,15 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/peaq-wmi.c
 
+PECI SUBSYSTEM
+M:	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/peci/
+F:	drivers/peci/
+F:	drivers/hwmon/peci-*.c
+F:	include/linux/peci.h
+F:	include/uapi/linux/peci-ioctl.h
+
 PER-CPU MEMORY ALLOCATOR
 M:	Tejun Heo <tj@kernel.org>
 M:	Christoph Lameter <cl@linux.com>
-- 
2.16.1
