Return-Path: <standby24x7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519048580; cv=none;
        d=google.com; s=arc-20160816;
        b=dqpisJT1ZNpIbesiXTkVBjCBb/9zSvf1vVfiuooZ2pHMrn9tQR+QxnHY0//N65zZv+
         riDgEZY39cuIN9NrIJVoB+fgLMWpjrGrMEDrBJ91aC438I+EPGOj2DKYtcMTGkkg0Tzh
         lNPdWGvgMKfzGQWu9Gc7K1MaxTR6Fu1bhM3UHWcil4XJMiGX4mVTzGfe9+gIF+Bt9kYy
         d69d7Gwr1MCe60Wl8g2NVOV8yGS4+y/cW2mQDWDBpwi6LvWaR8CbuaFwvcitGA8Q370T
         S5iCeBzCzcmKAaOfjVcBgkkKf22UC17OaPNM1gtjeDielJ2BPC80lUfACVhlACgpPy6f
         WRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=AboG706p+GH0sK7Z5+aZ22KfNuVVDMAXS+qEmGjeB9o=;
        b=c7JlEZlecs7t2XKumyRuiudlPxYhsdGjxAwgRB9TvtH2V9NGYiA//dDn09ZITFeClr
         fBMwG4ghIeSPdbrYndRj4qAd0QWSeUdBUA2MRqVB5DIGSJtSazi3DF1klKSNj5+1sfJ6
         HJk3g8K+wRMIXciV3iWFXyEV8NaaDLKc+j16ulHX3LM692dTstSjUh8+FFhtMFLreWRd
         px9Y6OX8CV4OQkICIKfEy72KeNYKYF4pH6M3ichQAT/YtOsBl3vmLYHOjYv/Y+mwn3/Q
         HTdWG+09vDBnL6IV5DspmP/VowbG8b2iR/xuUDKXc5l96cXWUGctOjN33Isc+A2cowDg
         46Rw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=u8B9jbTj;
       spf=pass (google.com: domain of standby24x7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=standby24x7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=u8B9jbTj;
       spf=pass (google.com: domain of standby24x7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=standby24x7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2277EBJVEHGz3/W/Z/hNheR7Xrlkt2/whfZ3bZXuBPSDqvQpEGZzD0WUHBuucI03I7lEpqO/Rw==
From: Masanari Iida <standby24x7@gmail.com>
To: sdharia@codeaurora.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] linux-next: SLIMbus: doc: Fix a warning "Title underline too short"
Date: Mon, 19 Feb 2018 22:55:50 +0900
Message-Id: <20180219135550.28627-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448fe9
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592837884320180932?=
X-GMAIL-MSGID: =?utf-8?q?1592837884320180932?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes a warning during "make xmldocs"

Documentation/driver-api/slimbus.rst:93:
WARNING: Title underline too short.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/driver-api/slimbus.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/slimbus.rst b/Documentation/driver-api/slimbus.rst
index 7555ecd538de..a97449cf603a 100644
--- a/Documentation/driver-api/slimbus.rst
+++ b/Documentation/driver-api/slimbus.rst
@@ -90,7 +90,7 @@ controller resets the bus. This notification allows the driver to take necessary
 steps to boot the device so that it's functional after the bus has been reset.
 
 Driver and Controller APIs:
---------------------------
+---------------------------
 .. kernel-doc:: include/linux/slimbus.h
    :internal:
 
-- 
2.16.2.246.ga4ee44448fe9
