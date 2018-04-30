Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AB8JxZp944yZe2MxHa4yYbpRK3J/kFSJVODbF//Tf569HV8NqfXQweYb6gqJLvjF2ouJbHNdUlp+
ARC-Seal: i=1; a=rsa-sha256; t=1525103628; cv=none;
        d=google.com; s=arc-20160816;
        b=hYBnpEc8RfXebY0DcichQVWTaniMbLaStwe5aisG118Zj9+LpUECDB+gdFsrxA3aa1
         FpMRBPWTSzYsy0WCkCzWpxlvsXDSUlk0oo7uuILfWBbNPg5a9vT3Vk3Cb2azSpsMY7WW
         JLjNcOJRz2gjaANsXdLouTad0/l3J7FEF7OqpolvOYSkH9fMhl6Ao04Pzb3EL4614uyW
         wCmM3jKF7bZgHHiMxenVbw1YNDpXfTfy8XF8doN5jydqpqkv7Hbf+VBnefsQT0bhf71f
         OuoSkT9/VVZ+oEfjBflESOVuvngc5bCtiM9D2DqkOY/K2bBo0gA+IrTc+VGuAHEC5cS9
         xlFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=wK/x5ykpZba+t8sOERurffseafesl0O5KXmzY1prhaw=;
        b=v5HSyppnUz7OtQofYix0mrkgL1MG/teFfr8oNAGtrKl0wMO8vOJ7xx8eO/J+c3VVyD
         21rDvjsyo4BVMias8SmUAQxdCc/Sl+uqu2Lz2Ex37asrRXb/LXzKquc731yJx82bWsPz
         zTcksSp2wpg6kOyWriDgtmXOV8f1L46kqbpJzSEp4BrdW0cs4D2wCI16DIearzXPDbwc
         NdbtTHvzGEMKK2FtyvQhKAkWlQKqyRZyB5sfuFwbSzTtd2I0+CuybGp/Kuk/kK8pzZ8f
         yxsMm1/kaMocZZXVbaSCL62NNTKzb0CSVc2cZh16/WxAXfoCDj6zBxzriPzreS+dhoJR
         qcXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bastien Nocera <hadess@hadess.net>,
	Justin Vreeland <justin@jvreeland.com>,
	devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][staging-next][V2] staging: rtl8723bs: fix spelling mistakes: "dismatch" and "Inviation"
Date: Mon, 30 Apr 2018 16:53:47 +0100
Message-Id: <20180430155347.22571-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599187062770463802?=
X-GMAIL-MSGID: =?utf-8?q?1599187062770463802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes in message text and comments

"dismatch" -> "mismatch"
"Inviation" -> "Invitation"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Add Inviation fix as noted by Bastien Nocera
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c |  2 +-
 drivers/staging/rtl8723bs/include/wifi.h        | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

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
index 530d698f50d9..d53a4483ea9f 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -976,7 +976,7 @@ enum HT_CAP_AMPDU_FACTOR {
 #define	P2P_STATUS_FAIL_INCOMPATIBLE_PROVSION	0x0A
 #define	P2P_STATUS_FAIL_USER_REJECT				0x0B
 
-/* 	Value of Inviation Flags Attribute */
+/* 	Value of Invitation Flags Attribute */
 #define	P2P_INVITATION_FLAGS_PERSISTENT			BIT(0)
 
 #define	DMP_P2P_DEVCAP_SUPPORT	(P2P_DEVCAP_SERVICE_DISCOVERY | \
@@ -1082,15 +1082,15 @@ enum P2P_STATE {
 	P2P_STATE_GONEGO_ING = 9,						/* 	Doing the group owner negoitation handshake */
 	P2P_STATE_GONEGO_OK = 10,						/* 	finish the group negoitation handshake with success */
 	P2P_STATE_GONEGO_FAIL = 11,					/* 	finish the group negoitation handshake with failure */
-	P2P_STATE_RECV_INVITE_REQ_MATCH = 12,		/* 	receiving the P2P Inviation request and match with the profile. */
+	P2P_STATE_RECV_INVITE_REQ_MATCH = 12,		/* 	receiving the P2P Invitation request and match with the profile. */
 	P2P_STATE_PROVISIONING_ING = 13,				/* 	Doing the P2P WPS */
 	P2P_STATE_PROVISIONING_DONE = 14,			/* 	Finish the P2P WPS */
 	P2P_STATE_TX_INVITE_REQ = 15,					/* 	Transmit the P2P Invitation request */
 	P2P_STATE_RX_INVITE_RESP_OK = 16,				/* 	Receiving the P2P Invitation response */
-	P2P_STATE_RECV_INVITE_REQ_DISMATCH = 17,	/* 	receiving the P2P Inviation request and dismatch with the profile. */
-	P2P_STATE_RECV_INVITE_REQ_GO = 18,			/* 	receiving the P2P Inviation request and this wifi is GO. */
-	P2P_STATE_RECV_INVITE_REQ_JOIN = 19,			/* 	receiving the P2P Inviation request to join an existing P2P Group. */
-	P2P_STATE_RX_INVITE_RESP_FAIL = 20,			/* 	recveing the P2P Inviation response with failure */
+	P2P_STATE_RECV_INVITE_REQ_DISMATCH = 17,	/* 	receiving the P2P Invitation request and mismatch with the profile. */
+	P2P_STATE_RECV_INVITE_REQ_GO = 18,			/* 	receiving the P2P Invitation request and this wifi is GO. */
+	P2P_STATE_RECV_INVITE_REQ_JOIN = 19,			/* 	receiving the P2P Invitation request to join an existing P2P Group. */
+	P2P_STATE_RX_INVITE_RESP_FAIL = 20,			/* 	recveing the P2P Invitation response with failure */
 	P2P_STATE_RX_INFOR_NOREADY = 21,			/*  receiving p2p negoitation response with information is not available */
 	P2P_STATE_TX_INFOR_NOREADY = 22,			/*  sending p2p negoitation response with information is not available */
 };
-- 
2.17.0
