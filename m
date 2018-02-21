Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AH8x22790EwbCHqENKey669K627HXs4Hn+X0kGIAQnBHRTMggGKoeoBhk1OZ19f3Sl2YgklH4jJJ
ARC-Seal: i=1; a=rsa-sha256; t=1519209585; cv=none;
        d=google.com; s=arc-20160816;
        b=lvbg9R/nL5sUITk2TjyeFq5ssHGpBj3dxUtq2AHITX5HflmV4fd1achpLYvqGlqJAG
         daTxTcYlXDO+boNwwKoUWsCVRGf1Zpnzr3dAtpRhDrCoo3uR3EPQFXNtmsJqow5QBBAV
         lCuIdirFGAMC8Hoj7IBEHAP14QMSqpefJJX0DJBsna+qE5atWL6SY9oDJjKtOteZADrE
         Z+Xt25jKSQ12X1FEqrKifKqQ0fOfig6hLtuc2s45QRMZJm4pd6EA9okm4nXyvcf0NMqT
         SKGCSGLNNdbkK6AEfkI69nHj7mvyttqQY04MK/zJD9gXIFgpDxpE0o6deSddo6Un7nJE
         suzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=gqFkM6tLXbIWR/1StCcEHk3BSlxRXFJ9BQOyidEv0Ek=;
        b=PtHF3kM8bt2gn2ZyMda33dqD+L00HvXCBhjH1nm1r32vJbJdGNku6l4JmScASIvf/Y
         vmnoDoWOopvnZAB2Tdy6UTIQunymjhfTU4fb1tGzyEs9OlZ1+IjlXNpzymuJEBxRmltc
         YR/a+kqfhKH2WgGg+AaHMBAk5Gme+m52fww6XPIdoFQ6FfvqmbVh9WDxOdMufGzzab/8
         lanDvWXAP/j5VYXNeBDjMAFliLKKTBfkD2UvpEs9UMRwS6JbYHBITMyLBN2jPL9vMWT2
         M7VN6OpB0LO/dGvt0dZzFgMXnhDTnbFCRQ+tgHFkJ335N6OsUrPyHpxvtzBAWKdZLiMU
         FWFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	jonathankim@gctsemi.com,
	deanahn@gctsemi.com,
	dan.carpenter@oracle.com
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>,
	Quytelda Kahja <quytelda@gmail.com>
Subject: [PATCH] Staging: gdm724x: hci: Changed camel-case to snake-case.
Date: Wed, 21 Feb 2018 02:39:28 -0800
Message-Id: <20180221103928.19599-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:Te1WrJXnXUOWRQStest5303pcFZXj2hB2pdlbDWeK3Mc/XlZ6bH
 5Frchhf82DMcCB74iKTvS5b7S3JiBPjP1ZWmJK5j/3vQA8IgoqIyS+mcr1l9oXvOevRwFnC
 pAlS1368UR+AVrEVV2MXhSRAaxISthIOl0FCvW37s9pZTfAzq6T23TxWLCEEXItI0E5CadU
 UXVhDDuuBV0Ns6gyikCzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yOrDBp1mxcc=:CYY5yYcUJZVLUgCZmfdwtr
 r0XgjUcrcHPfdIvyKKcZifHHQGqGKNaL4ZpS8EP59+ZTyk9s3qvo7otngyUOAHwMLcx/jJs/8
 Od3BfJZEwyvACB7qLQymnMNg+IN+Jq7dk9bhxsTrtVHwK4Tml757WRBHlGbJkiSYBMRGugR8l
 QPp3BIqsM/OyU2r80EUSrhfWHbZT+TSEzMEZHX9Jub+pEqnlbUnSwcITdt04jjkX7BK8HMZxR
 GyR8/Egzmkr0jf4GnnKUbFVdYkhspVw8IePb6M6/osbpXXgMV/kR9bGQ55uhFJyrUWAu47K/z
 mqUoR9DaXE2LLLardDHjtzlSUFTeK31c8oXnSucLGhk8eMR30rHgafDznejw+B1Zz7W+5sl5d
 4E/7OE7tDsXFZrIum9Dh1LdrFNHihLEDNF+ZxpBy7fMiYy/7A0eIDKtGPqFWFxiFWB1uh2h1h
 u4xkJEpfvV6mxqC9jO2nr2HPa+roO2vuvk175DLB4QMP0dLyW3NbLbycnL8l7K333pjkSE0eA
 GOlJNjCXIY0DCjr17ie7qUuLMeFiBR5nzGbuA3YsiOTjrsU7qEjsJfdJRdox9df6e/1VN+nMV
 2ygeUpI5J4jUja2d0gGCYUH3lJPxDO4tQ85fqIx5MpGu2MRjHCDG/jCRaMG1FqsCNu4oETsbi
 +og0bz5op5eifT1rOocuziibqFQadJZL7ruAikITGbp0KkcyoH120DRUsA0Ov13ezSuVh7vYe
 Ww4vADy+UjJtRoVedci40pswLWbSugS4i7Khjw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593006710117877151?=
X-GMAIL-MSGID: =?utf-8?q?1593006710117877151?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changed a variable name from camel to snake case to fix a coding style
issue.

Signed-off-by: Quytelda Kahja <quytelda@gmail.com>
---
 drivers/staging/gdm724x/hci_packet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gdm724x/hci_packet.h b/drivers/staging/gdm724x/hci_packet.h
index 22ce8b9477b6..f8837c7103ac 100644
--- a/drivers/staging/gdm724x/hci_packet.h
+++ b/drivers/staging/gdm724x/hci_packet.h
@@ -50,7 +50,7 @@ struct tlv {
 struct sdu_header {
 	__dev16 cmd_evt;
 	__dev16 len;
-	__dev32 dftEpsId;
+	__dev32 dft_eps_ID;
 	__dev32 bearer_ID;
 	__dev32 nic_type;
 } __packed;
-- 
2.16.2
