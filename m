Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524673549; cv=none;
        d=google.com; s=arc-20160816;
        b=VmjBOz6j0J+gVVCb4x+mPG0rP/sb7Z7iOrLP6Tg7Ke4jd7J+m5j+t27p2wQZdxJINJ
         k8OBKqemnIaKz3hCGUmmCD0BUsYUupuRuSwJtRWHzgh4WUHf1pFCpDRPZfokfw0yGL9p
         4rhrA9EJeLyWsH1Z8rgL2buc+/5qAI4lfGcjFkHB60q8VZgR8zerX0tit0tbm/yRR12b
         AJV+gryAtD/vSmC/fFzK2FWoNKWBDd42426IuEgu9hJhVnRXuOQE12podMuustwAMW9A
         z8OeeqFjHnO3HRNVJQavP9flXrtV9OsFpQ5KUkz7wT2d7vry1g2vzfJ5FGk2+8umboQ7
         EVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=JIPUvrBRVlNrUk62Lfp7nf++cNeQm0Wp+aJBtPLxY5E=;
        b=AhwRaX71wSqNk621du+tKvNch6uaO/uyhUbC6wWwAWSbAxep7BXC0wop9oWQfWfKxJ
         d9wd1US/SdA0oG/b7DadMb0qXhwL+/9Td0ma+06zS1A9BgWBzjcYVfUBfKTz6qUkAEB6
         fLcdHLzh66VAW5/quk3HRli095hw56Ae9W7MrmAnzMAEE9JzKYp1Ukthh3nk4oR8SB/w
         FJkHaZJlRtHHxXVUyltty4M5TxqOn8pPoMTdRpx3S3gJ+qanHMdKHdyWQwKPrDOIM1T6
         mOiXF0Pc7XgljlEURIsk6rU/HRLkCjH9XRxvVHkMidzRQ9ONTCUSyc1ChKNt5vaxaZRJ
         Ip1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=N6LMdbAy;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=N6LMdbAy;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrmR2Tn3cU7RKn7eyTTMW0Xt4dqXR2KXcVzFM1f+/Sf7Thglv3fMRbiJH8ziBLsyvVDpS1dow==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	christian.koenig@amd.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	hdegoede@redhat.com
Subject: [PATCH 2/2] usb: typec: fix formatting errors that cause build breakage
Date: Wed, 25 Apr 2018 12:25:40 -0400
Message-Id: <20180425162540.11574-2-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180425162540.11574-1-andresx7@gmail.com>
References: <20180425152617.GA5058@kroah.com>
 <20180425162540.11574-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598736091158653779?=
X-GMAIL-MSGID: =?utf-8?q?1598736091158653779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ASCII art illustration should be marked as a preformatted text
block. Otherwise the build will fail when attempting to parse it.

Fixes: bdecb33af34f ( "usb: typec: API for controlling USB ..." )
Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 Documentation/driver-api/usb/typec.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
index feb31946490b..48ff58095f11 100644
--- a/Documentation/driver-api/usb/typec.rst
+++ b/Documentation/driver-api/usb/typec.rst
@@ -210,7 +210,7 @@ If the connector is dual-role capable, there may also be a switch for the data
 role. USB Type-C Connector Class does not supply separate API for them. The
 port drivers can use USB Role Class API with those.
 
-Illustration of the muxes behind a connector that supports an alternate mode:
+Illustration of the muxes behind a connector that supports an alternate mode::
 
                      ------------------------
                      |       Connector      |
-- 
2.14.1
