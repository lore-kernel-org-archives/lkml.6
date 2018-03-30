Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx491BWyOLaUfIKRSQe+/mkhiRdstWUzPujGXn7pYwvXU07u9YJsgRs94C0ks9HRRBZRSSiCM
ARC-Seal: i=1; a=rsa-sha256; t=1522393773; cv=none;
        d=google.com; s=arc-20160816;
        b=NkyKZ2hLIulfm3FW6j2FDys7QuHBSJ1jxztK2GKXDhZ2XLwe28E52BUOs7JPvynalw
         yyMvrvnghE/CTP9UC1jozVy9yBcU3c+VvfZjjaNm/I1V6wXR6X1R0yu3+ZvsbeHL2KvF
         HK5mpfxzAvfP6B8zeP8sEWSvko+lB8aA4yrUUuR4SrYIv2EyObI4h5bHvSDM0XEIJ6wT
         JgMNgfms8R7vigQfYEN4tjvDk2QMsIGTdyuoUQ8U/mJvvgO2k5dABqOVrZJi8c9AAuae
         obNQ3iv3cRl0U5buReJ2tAHzlrgiOfOsJ4jqfDEc0rx3g3ZV0DzHJMxdNWXcCSlxwlBu
         /fyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=yQI9Lf42c27ZRdVgsIWmOuSImcymsUBY3RMaLHnBRSY=;
        b=JLUWFxgsmG41FDmlgI3F7ez8EPmaKnKlyiYKdiSG6SlNtWPlt+mImac99oP++b2rkp
         sZfRVg+oPG0jkYirqSaeLeOetqWbOfcKJX4yEEesZaIxvFfOgWLorhJXL1WV9QdkDXF5
         DQWiTpAe8l7aD0PC5ezOzxcuBlgu2NbeaSe6CxVduHBzBm8qnxDK9d7rxOVhH2oWQPaT
         zYmgSMDNMjT6sM7zzUvrjvAa751tH4e029HrBHL39R2TGcUkEq31Xs/hGPNq+c5/JBZL
         BCNeTqrhtpgMQpbmvYABQ8mg1Z3bPX6OGBIpI/apR8CcnvYb2AgZ0W6HQrrpTKD+0KA8
         OsYw==
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
Subject: [PATCH 40/76] staging: ks7010: Remove trailing _t from 'struct association_request_t'.
Date: Fri, 30 Mar 2018 00:08:03 -0700
Message-Id: <20180330070842.25224-40-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:7AKEkNsf9IS8QYHpU90YD9PjirUtZGutvzIXDxEgmrP5zyoVB44
 wM3gGwjE4QNm6a2Kk0pU/2z7BTr1ItCoVdatqsbdjhOTII7jyCrqaGH04agsjKfKlZKTdGb
 FKB0lIkX10vODfiYjg2ZyIpUQJlFvSAq4XhpnCVe+VUNa93ag3/cBMXHAifhmW9zLc4Vod9
 f+pqJjsd7SQyzKXsbWogg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1BSEZSrxvOw=:eCDxgnw4SWrj4yeRMlWyCv
 Es+1Q08BSf0AEJsaFALXgdHxDjNpQm5ntN+CkTeHuZ91arY3/a1ROaSuzfJNiL/UaZt1mMGlo
 o2N6/pueQj9lsQh3wbxQgwqKvIMuIeUnnRTZ4HdbBOepDwe5XXuLzlXsAkCrM9BmEhnHepvaG
 fKRv9p5JnH5BeN/p1/+Z04I3/+kcDsYjYOUWfewl3R1VwX4owHzxA/jcCZRJXCOpVHbhpUxLQ
 pB7MmvFZHQNQRG9geTdaiAk/4UquK39W72hnwG38aWN8PcAWAi/B9foBYZRkAC86t0R7HJ2Nu
 KDMfFP/YmxcFWQIVfhyfadIqc9PnC5u71QqCtTmHfpeY6DRqcsL8hbE1wKeSJYvH3bKgHE3sf
 zDOTvhV520rm7Vom8EcBrn+f5hRxPw2TUNC0ckX8XQCkhVcuo6rJVpln+VdrLHpHYostVcLIG
 tms090rT493QmgEHeh0mpaeDGLMCrKzxlpSsExwJSIqtMv0IashSOs6Nfz7GOPZT7xgtr7WKz
 OAdiyH5q6NiHC4DVmAtCrzz2yAVet22B0YKfi4vOvMDk87p1FEKc0kQP33y2Ag0eCFCf4dUeq
 OFNV76HwgAV5lHPoRLeMHutsbTaCVUaQCLq66yuFUWogqLl8/I4M1fIqM8TkHPwMo/p2L8OeD
 stm98X56hCy6N5I6E0XZnPXN9NkuI30S9kXHDKargdN9t1TTlQOY45/RwYF0XnsxlX+f73TSa
 WM3BtRANjXyDwOosE7J51aOQfTOfLxEb87ZCww==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345573009209425?=
X-GMAIL-MSGID: =?utf-8?q?1596345573009209425?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct association_request_t' with 'struct
association_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 4 ++--
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index a177496dd42a..43d06fdda9de 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -863,7 +863,7 @@ void hostif_adhoc_set_confirm(struct ks_wlan_private *priv)
 static
 void hostif_associate_indication(struct ks_wlan_private *priv)
 {
-	struct association_request_t *assoc_req;
+	struct association_request *assoc_req;
 	struct association_response_t *assoc_resp;
 	unsigned char *pb;
 	union iwreq_data wrqu;
@@ -874,7 +874,7 @@ void hostif_associate_indication(struct ks_wlan_private *priv)
 	static const char associnfo_leader0[] = "ASSOCINFO(ReqIEs=";
 	static const char associnfo_leader1[] = " RespIEs=";
 
-	assoc_req = (struct association_request_t *)(priv->rxp);
+	assoc_req = (struct association_request *)(priv->rxp);
 	assoc_resp = (struct association_response_t *)(assoc_req + 1);
 	pb = (unsigned char *)(assoc_resp + 1);
 
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 02046ab78a36..a1fea8eb89cc 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -434,7 +434,7 @@ struct last_associate {
 	u8 status;
 } __packed;
 
-struct association_request_t {
+struct association_request {
 	u8 type;
 	u8 pad;
 	__le16 capability;
@@ -454,7 +454,7 @@ struct association_response_t {
 
 struct hostif_associate_indication_t {
 	struct hostif_hdr header;
-	struct association_request_t assoc_req;
+	struct association_request assoc_req;
 	struct association_response_t assoc_resp;
 	/* followed by (req_ies_size + resp_ies_size) octets of data */
 	/* reqIEs data *//* respIEs data */
-- 
2.16.3
