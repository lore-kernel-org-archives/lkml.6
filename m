Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AB8JxZozef+coMyQwxPJraX5xKX2rZbkuDkkC5llBKfPA5TluDcooQU1CYBd6Q1ACAJd2kDQd8eN
ARC-Seal: i=1; a=rsa-sha256; t=1525097988; cv=none;
        d=google.com; s=arc-20160816;
        b=pMrMZaIul3+VQP88brSr5DzWwTw3xJ0ZZjyOdAb2IgmFEROYh6JwI0R2rC49w6UHc/
         wXSuV/Fy+Gz2dpgMFB93FAJTtQJ3oH3m0LYns8y5U4fYbNJsUYwMebWoqyVMP3tDEiov
         Xfe8owVu0GTJgFww2vmrsx+Q3gbOIer1R2Gwn7BOCPV5ZGzXB6kUmPHvlkWRWbGkt7PA
         rmfQ3Vkyd9gUK0Qz9IeOgpYxYfTR88gzVd5J3kwferuwSMYORXT9kaeW0qJm/wANC5W/
         UF45Jz8pUtCFaSiaMq1LFjvFubU6pTtZnJmnbXjimIvPKNGkjbnmslCcR08Z7Mkq1NOW
         zzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=GsWsqIat2KbeSMhPD30pQJ+uGDsEajUx6IlnabFYm94=;
        b=xKDF0JMOiOrFiK6ZZySeyl6Nv0pOm2prFjqJhoRnIa7vbA4dCL4sVZVCxYQUtyJe8R
         nBVE6iggsVv5+ezg9lkjlDgnjDYW1rOJoiNYFfOsXOtZ95MnrtbNeg+4WbspM545SLRY
         pT9kYrdFTLf/u1oRxBZcigPp7jxF05R7zgDDMRDUqA7s0mPHFMP9zXXDKV0Jlf6/J0cf
         40qacpVXv0st3DzFLjCvA/HLcs3vZG7aNn8v8xfpafcf1V3fbrcwvBSczEbRKy5UfZp8
         +0vKhhhh9lXbXcJ6/PYkR4+UanMI6oYJb9NW4SaN36WV3QHHEa3E4JoTk9S/EerUMExZ
         ZExA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Justin Vreeland <justin@jvreeland.com>,
	Bastien Nocera <hadess@hadess.net>,
	devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][staging-next] staging: rtl8723bs: spelling mistake: "dismatch" -> "mismatch"
Date: Mon, 30 Apr 2018 15:19:46 +0100
Message-Id: <20180430141946.12186-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599181148446215126?=
X-GMAIL-MSGID: =?utf-8?q?1599181148446215126?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in message text and comment

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c | 2 +-
 drivers/staging/rtl8723bs/include/wifi.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
index 33610d39333f..828bc0d045a0 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
@@ -2198,7 +2198,7 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 			BTC_MSG_ALGORITHM,
 			ALGO_TRACE_FW_DETAIL,
 			(
-				"[BTCoex], PsTdma type dismatch!!!, curPsTdma =%d, recordPsTdma =%d\n",
+				"[BTCoex], PsTdma type mismatch!!!, curPsTdma =%d, recordPsTdma =%d\n",
 				pCoexDm->curPsTdma,
 				pCoexDm->psTdmaDuAdjType
 			)
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 530d698f50d9..c56f887df101 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -1087,7 +1087,7 @@ enum P2P_STATE {
 	P2P_STATE_PROVISIONING_DONE = 14,			/* 	Finish the P2P WPS */
 	P2P_STATE_TX_INVITE_REQ = 15,					/* 	Transmit the P2P Invitation request */
 	P2P_STATE_RX_INVITE_RESP_OK = 16,				/* 	Receiving the P2P Invitation response */
-	P2P_STATE_RECV_INVITE_REQ_DISMATCH = 17,	/* 	receiving the P2P Inviation request and dismatch with the profile. */
+	P2P_STATE_RECV_INVITE_REQ_DISMATCH = 17,	/* 	receiving the P2P Inviation request and mismatch with the profile. */
 	P2P_STATE_RECV_INVITE_REQ_GO = 18,			/* 	receiving the P2P Inviation request and this wifi is GO. */
 	P2P_STATE_RECV_INVITE_REQ_JOIN = 19,			/* 	receiving the P2P Inviation request to join an existing P2P Group. */
 	P2P_STATE_RX_INVITE_RESP_FAIL = 20,			/* 	recveing the P2P Inviation response with failure */
-- 
2.17.0
