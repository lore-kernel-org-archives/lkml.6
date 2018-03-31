Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49lFS54rCCGYUqz8k7p4X36EBz/4ZQtvzlfEmdWt/NeJL2iqGnImrgybuLZ053tHUiN0Ggl
ARC-Seal: i=1; a=rsa-sha256; t=1522476587; cv=none;
        d=google.com; s=arc-20160816;
        b=kMMS2INjcP078qMf8FP2Y2zadWDuQ+pBEuEeMWMA14eE5Zo/MzZWZWBczGfR/rWyRx
         ymY5XmHHMDAqIizZJ2UeDeaMYD10AdVWfPg2OOhQebWj/i7pfzXc/GefGeMwzlQfXfWE
         wanu0NYZb08imUzkWCXa2TOy+N6lo/G5IqwtqCp1sDeLIiGMb6WnCIpE5iI8H4HFq05k
         MazNKQSPsN5ph6qU8v4UyNoWLZStDGVvncddfIAF/Htb29a3E4OBVtjuwtt0g5VJNez0
         GDMwt+HrDE2Q8+qjAIHA3l/Ix99nlYr9qSf05pQt6vsnByGZmRSfEDx2BLhYhq6iBvQi
         AZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=1y/WeHvzAoLvDwHu5n16x4vya1at70p5ML3rN8l7YuQ=;
        b=vKeumuz4WeWu2OQUvFyfDzmGWqXKylEBo4so+pvKTKq2ahSt8xyEko+DnvWmhTobJz
         F7nQHkzY1/cCeZi7WPQPxtqt7Z/m1uoLOnpwoGsJYlDpXjHpQXZ2Go+bSj731LpVPYJ7
         syqmUAKo9MqkS2ZmwDow3QtuDdzuI4UXXlDHkzyfV7Hi2X3VZsh/GzDerW5n91OgPOnI
         Z8TGE20uZ6DmCaTyHfmpQZfmLSLa25YNCDgzjDRvl2MTseZ0NEh+t85O9xknlI9Phr77
         EywplPbVeXOeurUfnTVz7wPCcObf9feFexScpbV6U9Ch68NTWXB4GHDNiwwBKE5Evq7J
         yaWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 28/75] staging: ks7010: Remove unused 'struct hostif_connect_indication_t'.
Date: Fri, 30 Mar 2018 23:08:08 -0700
Message-Id: <20180331060855.9452-28-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:sD4tbNY3Zu09hezrhrZAMucDLjgNwD6DoLRyTO4wX+4OeKYM+/t
 C2uQgU55+GENRUkYhVz/G+DjFowMXClUlPMjLEzm/Ftkfza3DwFaw/vTv1UTGVh6y9/9+43
 2b4uOjI84BEZzt+gfmjqogA8sNhw7WM7h2pUnBrTY1yC7x7pftDHpcEDOQinqUdCtLRTy86
 +cIJ2ZcchgflVq/r0XBRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sDHAurxMQPQ=:epYbAW/9CU14PhHNEq+VWa
 eqTtma3RnoFj0g5G2VSXDj9Q0hgPI3jOJDLD8vIzcPeU+hhgtXSBYYPaZaoLZbsVeQVK2TdLL
 LknDbu4SiJeyosLWtqHus5RPBraMxPxAsIhFX9lAIm/ME6psHXvyod6sqXliP3Z7EpHG7U+J/
 bwh+DlvUKhJQyZWp1Pw1MUV8F/1VXIajyM5vnv1XkezsYI0d+EQpRyEajCGujrycxZ0L8dNQR
 IKrtU8HQyHJ/ui8Hl2U4681lw1n8Uwf+dm8Jv95Z1jD4YnPu0HDVuk1R3K5jjYaP86qBLdroe
 IDT1GVHeK2OoF0ljYuzNe0L5p7ew0b8dA8QhLER8EAvIXcdDUOlm60MlsabpTF2glA65l3DlA
 RvM3nSt+/lL659AnsL86T2pO9hl16x/B59GW+Wlu7kshLRGMLuIHwCseJ8sKSLTwbM1HxkdAx
 ZY2ML9S6GDclX6GyJBoK3eckM+5Zawn9hSvGrxbyJYCeBFuxGrav6GM3WYu5JPu+XHWrvrIDr
 t+R1rPfAiqORhpmZGjFsn3cuFTr/vp8z9KGRebg1cxXOJs4CAEblGnR2p6og9A3bEAX9r3BYq
 s5Kp6ENAOWzikCrNZf0Jas/qOJLXWsD+zHoxS5PlLKFMIau/WejWVYSCSPVexNBHGw/hVx+py
 RNWi3H281CSbcTcy/B5N7Z+yDjt7BWdzb6q5ttvRS2htpaoGtuCD2rifVRBz0QuJXIYQSAijx
 IuCI2KMTKboIV26H3YbY1100GRzk/uJjtmxEJA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432410590741227?=
X-GMAIL-MSGID: =?utf-8?q?1596432410590741227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'struct hostif_connect_indication_t' is not used in this driver. Remove
'struct hostif_connect_indication_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index f64eb2e1e947..bb58733521c7 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -285,13 +285,8 @@ struct link_ap_info {
 	} __packed rsn;
 } __packed;
 
-struct hostif_connect_indication_t {
-	struct hostif_hdr header;
-	__le16 connect_code;
 #define RESULT_CONNECT    0
 #define RESULT_DISCONNECT 1
-	struct link_ap_info link_ap_info;
-} __packed;
 
 struct hostif_stop_request_t {
 	struct hostif_hdr header;
-- 
2.16.3
