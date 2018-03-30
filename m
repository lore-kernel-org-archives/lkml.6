Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49rE5xVljmLHCOFXMkzv94dMuGuFlxLcUPuy06InGdy4WCj4JFjtQFA6Y35AcKPS9g8wrMa
ARC-Seal: i=1; a=rsa-sha256; t=1522393752; cv=none;
        d=google.com; s=arc-20160816;
        b=sTSXcb8WkzFyAFP3uvy4xG1UBdHgODLioaStF32kRcEjJ1vWpvsbM4lo/u/YVNJYv1
         VMFgJLxsZW3iadRR3BrK4jVQA5YNR1JLUaqPHiKxJjWeofM49vv2gR/tyKoIdNwsXSmJ
         0gicPBgCleiGmuNhtnP8Huvx8aXfxZGMcWrzr1IJyiMfTCpQRu3vDBOY1vUug8XrAcDR
         rVWGHRTTecD6trXmaAs7WWeSkUGjViRGHgcPxx38DppI9b+BC7e3v+VVOaPCV3nrbEq9
         UHQoZoFxxN1JsFq8E4WvyhxxC1/WPmtWsjsPyadtMclbJwFBsS53VVmv3aXdxh1SDn2y
         16AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=UUw8J+0tfC6zBGKNMEZKDFgEDJgfbuJW7TyfloxaTGs=;
        b=OPnAPLKa5fuDjOWXBPn2QTbW4UQ6U57wFfT54sdkeVfTW1pSE06fYp2xcE1aWoitq8
         y7qpfMBphNqSpEjnvzQamfI4QTj/p0RIk97Fj93T+d36Enux4aBJxuHmHIaYkxfLdzqF
         ur4KJPQgzclA05UOB3FYsc0rOMvo1MepnbWLHumUSBvQoq2sT1i6F4i7foAOg+55fSse
         RnNSNluLR3Hcl585ERb+xQ8qZi17r67Eec/rEmd6YS1ZSjFdIsi8XnyyEXmhdR42GfIw
         TGqIBG6l9zzwtb/UTQri2XLgqEmWyMIHtCAc3QpcXAp3XcRcHHWZgCBzCjPzSgQV8kOU
         iQ5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 15/76] staging: ks7010: Remove trailing _t from 'struct hostif_start_request_t'.
Date: Fri, 30 Mar 2018 00:07:38 -0700
Message-Id: <20180330070842.25224-15-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:KRzhos0sOOxqGJMNF2Z44E4/2EIHGLDAtUFHZwvp8QHR/iK1ehb
 xj5HwPpShBX3x+cnp8w07rX7tetkBsPfcYceclPH6JuWu5aDKxNYY33P6uuzUqwtbjlxQX3
 ckT6GY5ZrqzlqAkzDE6mxHXpKW1Icch/i5eSr6Olrss1TfXVEY0FbUumz5y/UqLGkLi2o8U
 Y4mdAzhTx71jHym59Sl4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TtyNRM1Gr60=:ejLvUMY1wdFo4mAhd8yVlz
 6/X7/v4Dx8zuSU15e/XDtulbzAjOy08wL7b6zL7Vuyg0mrm+sWUSeuuyJGXKnvCHYLFbhlCIr
 XHJNbepIhrHkg8n+B4Rnmlh1WZ8I/EmuIMP8+XrPvI3NHGok4kPoG41bclsiLwr6L9lNG6N8s
 nNC6rM8dsSX7V2zGC4ndZGFEyrDdDQAY7zWz4kAkkbDqm8oe59syiNb9t62HeLxws4nqnOimE
 PSTCJENY8+SlCVOmlc00A+rLSEUijQIgWEUf3LobQsI/6u+AFvnAdVPuzbq6njZQVLlnIME8g
 +8ELtabkgYPUv+dmR8Qkzm2iR/ee5OKenO+hmkJib0DEAzglrqgOQkInWZv3/5X34BXmStbMM
 TO9KsTqn/RkB8FiWFobg60ablVgggJfMVySmqZc02VvubavyLUf0EjYs0XeelphNPL0MQ2zvI
 gRljUY3PsWLDDgxzmKxdi6pHZy4VXrPE4hA1/maVKYK9DHvQZ8TLDXDaXOe/X0Vk7Y2C3su18
 WLn72FxE/pb0WTxLP0undc+0R/3JT3ur3ACW5D6io23hk0Ftunfvviq2QuKjL6jBJkdYEjICu
 q9APlot53jFN2XyBZA2TQwbxyNvyiP7/+NfUP1zdLIXDwBX1J7tQDwMdidncb7bETJNdZAyKo
 5+Sz7Nbh8i/Dbx/k7X9uIN2TDvZoOGrH6YXpwlfGwDbjQhO7kTEYJdHCpC3m/aRTX3Fz/85rZ
 z1/N4uWdAaxHSOanm30dOU+y8HUG9+lTsPtUfA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345550488229481?=
X-GMAIL-MSGID: =?utf-8?q?1596345550488229481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_start_request_t' with 'struct
hostif_start_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 848307241195..9bfef9c9f64b 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1280,7 +1280,7 @@ void hostif_mib_set_request(struct ks_wlan_private *priv,
 static
 void hostif_start_request(struct ks_wlan_private *priv, unsigned char mode)
 {
-	struct hostif_start_request_t *pp;
+	struct hostif_start_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_START_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index e0219fa6d4a8..b8b37afecd8f 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -211,7 +211,7 @@ struct hostif_power_mgmt_confirm {
 	__le16 result_code;
 } __packed;
 
-struct hostif_start_request_t {
+struct hostif_start_request {
 	struct hostif_hdr header;
 	__le16 mode;
 #define MODE_PSEUDO_ADHOC   0
-- 
2.16.3
