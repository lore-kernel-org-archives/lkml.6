Return-Path: <ctatlor97@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523108874; cv=none;
        d=google.com; s=arc-20160816;
        b=RoLQEyc2MLrTJstRhUj+uG6eqOPOWAPyr0/K48oTAv9/f1mR6THXcUqS9Xyy43Rm9Q
         XsGWSdCaBw6s4vcU5PV0Fds+AqXyFiKpAA6SvqJ5BS+sjUCDVlT1cVunJ5+s72FjWl/a
         3KN6EKfDTBPcsL1+hpLrEg5GatimNUbBL89lHCb0zYR2ZJrg4QrZLNVXNAiLOt/3oGt3
         DNPWCff5EUcpFzReF4y2b65/IU5kTGR1gxFFrdkNgpTjo/GUA38UE3cwfs2utN98LF25
         dQymAJ9rQTk+iMTUEZgpnr0xjtiJBjfgPH/HHE0Eliu9cuBD42zB33sCF/1GXHOw5KY4
         885A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Nvl0e/b7lpD/yDUtsjNcdrv712xSMFi2IjIaSnprKs0=;
        b=YAvqr03JMLArErsIdRaiKqueFWI4gHsRuTKwuFkuGEmsRNFrNunpxlexP7PMA4q7rr
         vg0Yx7D7VxVIkAu77JD75V+SZit+EWjCfpT7m65rp6nGpAtGRAeuR/HSPMi3DIZnZp5N
         MDb7o2QtMbYFALS83SsNY0gGGyw4JMhuYDkuvm2nrYgWKorW8SC3GPugTetqt/JjkN62
         9QR+EOqE+3tiO2Lj+TOnb2MeJ+wnflmxicHgSiA101HqNX00xtHYnfrACzd91FWxGRbE
         ecPNidXvFCQEiretZ60LsJz6F/ZiULW9I88wmGTN3DVKCpajjCfANeEABY5vlWZlv65g
         uqcg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=K/Xsjb4+;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=K/Xsjb4+;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48GuonhMwBxb19+SPbSpQ+mdgsVS6K8mNGPNnb1eujdzWF6VYFcZ3EChHinmVNTi1Kho1f0YQ==
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
Subject: [PATCH 3/3] MAINTAINERS: Add entry for the Qualcomm BMS
Date: Sat,  7 Apr 2018 14:46:58 +0100
Message-Id: <20180407134712.23131-3-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180407134712.23131-1-ctatlor97@gmail.com>
References: <20180407134712.23131-1-ctatlor97@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597095411222216578?=
X-GMAIL-MSGID: =?utf-8?q?1597095411222216578?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c3ad62c638c..b7ffa9268384 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11605,6 +11605,12 @@ W:	http://wireless.kernel.org/en/users/Drivers/ath9k
 S:	Supported
 F:	drivers/net/wireless/ath/ath9k/
 
+QUALCOMM BATTERY MEASUREMENT SYSTEM
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
