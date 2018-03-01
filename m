Return-Path: <marcus.folkesson@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519890971; cv=none;
        d=google.com; s=arc-20160816;
        b=mIungqvP2xykF1t3RrPZIfpaT5ZOKyne3dXgniQYZTSae6eqVo8EGDPOQcGVXJV2/9
         vhPBnFyWPNJQ2YKWrJbSjsUPtxzM+7TUiTcpbWbCgt65LpISx0WpKQmUbVFHajRa5XzB
         qbV5Z2bY/E3AS5489MPjGSKsZUDiN/XIKeBe6ceMrgBuawEUi52O6bIfsz+81J+K6qIQ
         +kLWh0uxNcLe83ymdDE5c+kRQRnakwUJLBkBhtXrjDz6Pjmvngmt3yNaq1PHOZte8vB+
         XuNXyzqRnXOHcSOhzdV+ObxXY9UiRN/RPLe2vibJcB02ZEunsSz4EvnGcfuiQzlMf+zH
         F0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=l+P3d8iKXb80A2ZlWn2nwGWpNh7Q8lisLBB0Khmj8iY=;
        b=ujAu80y8oHj44s8nOAUD2j+1rKe2SqyFiV8F7nMpMYx/Sa1SggRdda388zwqFljUYt
         p79KNIL6jfeGihUHWFjq+GlI4VHGdOPZ9f3rzeiBFY0YRvCYDmWlevLtos+ixgJBtbB/
         OWbfYM1U+vXKQij4nxI2ZN0sZPdqSmqf4YcZihvlxyHOrM811PulRDzm1oy/zIFtBIqB
         t6XgR4np6PbVSu4DCK9kXbhLMtOP+6JHv0IakunAMa01ODtVF9JOnnZLSrLN/rmoPnxh
         l8eeodxxD0+gfQ40iD/ixvC0Ienvz88X2l9NLR7Eh3dfk4vG+SE57fWNH24mV4uW0w8U
         Wa6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RyNsT8Is;
       spf=pass (google.com: domain of marcus.folkesson@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=marcus.folkesson@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RyNsT8Is;
       spf=pass (google.com: domain of marcus.folkesson@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=marcus.folkesson@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvfUun/bg+uByegz/rtiT+zyaXvirKDabMbKyuS738K1ppiLjlvNmabadMtiBB1Nj79XI1ruQ==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: usb-skeleton: make MODULE_LICENSE and SPDX tag match
Date: Thu,  1 Mar 2018 08:55:53 +0100
Message-Id: <20180301075553.11443-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593721195867073100?=
X-GMAIL-MSGID: =?utf-8?q?1593721195867073100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

GPL v2 is the original license according to the old license text.
See f64cdd0e94f1faf3b7f2b03af71f70dc6d8da0c2.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/usb/usb-skeleton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
index 26ca0ec01fd5..c3ddd0f1f449 100644
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -640,4 +640,4 @@ static struct usb_driver skel_driver = {
 
 module_usb_driver(skel_driver);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.16.2
