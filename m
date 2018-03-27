Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49vYwsZAg5bkLbj7iEuETrPx1Fdfv1zF2Hn8qrhiJpvXHovvsTqYJON6BL6HJqgRq7IRnT/
ARC-Seal: i=1; a=rsa-sha256; t=1522140096; cv=none;
        d=google.com; s=arc-20160816;
        b=mFTBmM2l9JaKMDhhOyJ20mO/pBjIOB2dHzLRP4Ssm13YQTebrPDR3sySyLQi5RvIEN
         Dr8iagzT78/C5lw+xy5Mb4pQACx7V+eSB4Sp4r409ZsN+B+Y8YvmXzs7+/d6O23hncRP
         OzJTdD3Y+XNYPqKmvO67T/diBHaysI1kLGFLnWSkNFhd0Lmh3BJh4Z9WLQueIohuzmSJ
         Z37eE4T6h6mP1X9xyt7uB038rD1TQHHvvIcGGaBSu6NOLfC2eDKyiIOyCpqYrK/M+U82
         mQHx1lOBQJEglE63N9XGsxTv+O/Wj0mZe4Jympb7bL6XKi8dy4ddpXScoV8RVI85+iRd
         WZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=jlPvdVyZSYFSNi8hn/EuBgmTJD68cDJ6PZ9+iO8Lt+E=;
        b=EyJcmOGwZmobcszEgzaDFz9ldzMJlRX2/oB4kmLARWZdvCzo26S3aggJBPd3RucuJ5
         XFwj2aoWi2mEqJZGXMk0s3NfDmCTYshs17N4bEc2tt4ltpjoiS8KmzTn5EH4cVm9KRLh
         2l7CDAlq3f10yx0LREeuIrbaMrxiU6vd4fs7199vRpPH9VzpMS6UxpLkW8FrjJU08elA
         tUQVPy05Wtt34GzG7qWn8fZGHGRCfV5Rzg2E1PAztYLrqxj6BP5hUYrzz7aIO8e3s9us
         dUXpBYW+dW8YKeaDRMSXf7TgRA1m4qmscSJVjtLt6FbhYxlBtxPRI08Axpf2eJXbpzm0
         3xRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 16/23] staging: rtl8723bs: Remove unnecessary blank lines in 'rtl8723bs_recv.c'.
Date: Tue, 27 Mar 2018 01:41:08 -0700
Message-Id: <20180327084115.16129-16-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:iMckFLBkEGwT+1nlzuXO5lb60Au0v4H7CoFDJkoe+O2RhLgSnWz
 zX8bBuEbo0de+6Vt0WUTWRLq/LqPZ1mYsKQ3w1qUlLX86e01P1D+hZloVHHyy5sMtBwFym6
 VhjH8nx7kgyJFdR5PdFJrugH64j1upaIukydoQvNAKbqX0TnwTirifV7Q9V09CsAgt3J80Y
 ft/gAa8NLe9xPtnh1XITw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f7pnFGi3dkU=:s9DI+53VRHDfA2LVsr/fES
 5s+mI1IpDv5U5kxv53vntmxNcWp1LGk5GA3H68cJEvzyd+Y7SQ/G/GDqOpc2BPEK+oExnh5pu
 G35AM0QzYzhrhA6D+zUfjUF8l7hDKPl6NbUiAipjwX2d39IY17cyrHsU7iXkK9QaW5zeX1/nP
 RfTXTCo3LDvncNzpwhxe9u5T836qtf7pidXcIErdiceys3IqwhA8EgmzrNT+wIlpW81FWgKax
 iS+wzeZQglNFcR46f38WmFExWLaXwioPY9xwGfPiEF5nVFDm8S9XPF5txTy6x5W1jZt3QkEMl
 fgCuvIHWuoGRIrtr3j0nIqm1EaQXI8FFcqHxTz9GzzxJ7B4K6UliPR2rOcsSZnowHTPabfFqS
 Jgd7JTc8VP3Bhaj/smtqgv9ZCMJxNW6Ho5Vk1FDTGgp4aQm3co4HVQDfVFsJU9rcBZ+jjRw/g
 6OEGz0sj3cbnljkshRjcg4sydgDE94TNiAxokFsma0qOQydNSc8S8s4VZTiGCNCzNU2U+TRYX
 /Joly+zmtEg8bpFS2IgUrkiicgygKvTckglhoXKZdAvcHDwtNcLF8UGwZKrZ4MQD/Zg3fP5S5
 j2GN6Te8Hn9KO7VQIJJeouFyB5h84irHl3S3x6feAeflvTFVg6CC2n3SaiWmMncsuT5lt9NTf
 LyVMWuWKVDswFWUMzODJTLZzlDHeDnlKUIiI22vavY8dleFbLcPYkqtTld8DNIY8Qx/8EJlet
 6y87qdowCUVR33DDU+GU+lCj1D5rfBcC6QLLWg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079573498565142?=
X-GMAIL-MSGID: =?utf-8?q?1596079573498565142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Condense multiple blank lines to one, and remove blank lines before
braces.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 8afac615a42b..3a2c14f53a1f 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -18,7 +18,6 @@
 #include <rtw_debug.h>
 #include <rtl8723b_hal.h>
 
-
 static s32 initrecvbuf(struct recv_buf *precvbuf, struct adapter *padapter)
 {
 	INIT_LIST_HEAD(&precvbuf->list);
@@ -104,7 +103,6 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 	pkt_info.bPacketToSelf = false;
 	pkt_info.bPacketBeacon = false;
 
-
 	wlanhdr = get_recvframe_data(precvframe);
 
 	pkt_info.bPacketMatchBSSID = ((!IsFrameTypeCtrl(wlanhdr)) &&
@@ -189,7 +187,6 @@ static void rtl8723bs_recv_tasklet(void *priv)
 	_pkt *pkt_copy = NULL;
 	u8 shift_sz = 0, rx_report_sz = 0;
 
-
 	padapter = priv;
 	p_hal_data = GET_HAL_DATA(padapter);
 	precvpriv = &padapter->recvpriv;
@@ -337,7 +334,6 @@ static void rtl8723bs_recv_tasklet(void *priv)
 						rtl8723bs_c2h_packet_handler(padapter, precvframe->u.hdr.rx_data, pattrib->pkt_len);
 
 					rtw_free_recvframe(precvframe, &precvpriv->free_recv_queue);
-
 				}
 			}
 
@@ -350,7 +346,6 @@ static void rtl8723bs_recv_tasklet(void *priv)
 
 		rtw_enqueue_recvbuf(precvbuf, &precvpriv->free_recv_buf_queue);
 	} while (1);
-
 }
 
 /*
@@ -366,7 +361,6 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
 	struct recv_priv *precvpriv;
 	struct recv_buf *precvbuf;
 
-
 	res = _SUCCESS;
 	precvpriv = &padapter->recvpriv;
 
@@ -463,7 +457,6 @@ void rtl8723bs_free_recv_priv(struct adapter *padapter)
 	struct recv_priv *precvpriv;
 	struct recv_buf *precvbuf;
 
-
 	precvpriv = &padapter->recvpriv;
 
 	/* 3 1. kill tasklet */
-- 
2.16.3
