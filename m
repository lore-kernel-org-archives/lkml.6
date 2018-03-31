Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/nAbi2cEp7H8pzl/6vSms7Ppo0EZ8wq79eN+vEI7Lvx/ZVQwDUj1dods5bs8ZPaEmzn5Qd
ARC-Seal: i=1; a=rsa-sha256; t=1522476568; cv=none;
        d=google.com; s=arc-20160816;
        b=RJnBhap8VgQqm26paeawaKkNvuwHCTUJD2t6790aZibE5qW/sUkq+Xd7QBGfgnokEl
         0rM1s4NUTHKoeK0dJ4YwNo9/QYSqFoiXBHJMnwbq/BS1SG5sPnEkjKuUbtqHs9uPl/wf
         Pa8SU+bHgOj8m+8o6LjEADami3t9sHv+DIGgQwva8j1yWnVQLXNHKdWx/Mj3jzhkiqjP
         8E7gPChm/XXa/LW6mMcFRo7y5cq0RD2PSC36Xr04abjfpa+AbQrhoIyJyoo/56t/7FpE
         r65oyuO1F2zqV0xSlIlSZ9GTvLY/9xUzeFD6Krx7+LNrSSDK4ZAypsyJ8H6amoYSYIeF
         hBcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=rgUJnEXb3Q4g5NZgEGygbswm+jeBtlpFSgMnLXzFTUQ=;
        b=RpghuwV+snZ2dBdaUgS26G3/dk08ID2okVZATmDGocuoxlcP0WdRyEXhP8PRDS9xr5
         99AM9ohdtH00cVoRLPdLd5LO2bTLazOC4P20tHH3HxC/bYbnZJxtvu3baW09c+tX90YF
         sHHzDZ8w14mU4oEwXlDcrhjfBwMYx/r8kVLSNc87Wy6JUGQd9tz51xYA/QPzwHWQAydE
         70fvd4qRp1GH2PdcBN64s5yhM9cPxse4uXql/m9FztDfVM9Fo8wsq/Mp+DuUg6aoOvCk
         d1pIHlnxJUu57V0JPa4pDdHhIJgKqGU9wtGWzxMqj8A9INZCegeZPInvkRVP9rn8utB1
         u5GA==
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
Subject: [PATCH v2 07/75] staging: ks7010: Remove trailing _t from 'struct channel_list_t'.
Date: Fri, 30 Mar 2018 23:07:47 -0700
Message-Id: <20180331060855.9452-7-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:F4yqKY0lAlmfzZoBEsj5nrgY9x9bw6E6FwqLi0S70CfwgWISa74
 /2XfIOKdw3cHaRS0cGeAb0BDM1U4/gS9loJNdbqj4rZPOOOU8J8T5Ofq50izJ0soY5jTCwj
 1D6hxNlWEHXXR6aAVfuJED88AAHRQGDF9Iv09r571QK0Xwzy21KY0wjPJiYYqSqP6S3Iadp
 ORzFsl3T+d6wX9to+dnbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wPNe/HRSeck=:v89+74CNjDB70qsi+10q0P
 6KH/gFNBIrIODRsT9NgPbODLbrh2Mem0dMv8eFwW7eQ1vS+TLQzBK1IzRnKzxfWpBKgDA9leZ
 X5r/2CPh32RmUSSQ7KNips3x8pq7EehWSNNwyGGAJRgKwRtbePDjufNYziyPbRMPFmOEOPZHt
 2HZX+RIAZ+zJbEu2VPqLCSESxBKZLC+D0RLt/iPSTPWB3uKaNdVL7ayTO2YLyVJoz7fXbsN/h
 bQHraqAEGgBlFi2P+A2UDtlnsH3b1MrggYC27XaPnUDXCsT1WzgYbh8proX4VrY5X0v5SsjOE
 mGEHvuspzzSC1yvEl/NCB1QZr/yLBNix8uh1Jef2UZXzdmL0BXF3xTN0pO2DZzj+smyZzjGdJ
 khzoCWVK2novCbKoJ5lz0o93hIyi3gINcA0k3ubPT8GtxoVSuysc2M+FWq6FWafecVlltQefr
 xztkU++JHnRaV4HwWHJNRJw5FfolxhgSc4jPDmUHFod1WONF1Q4i1bGgwiaVVfC8wbYXKwEXe
 Xd24mXjj8zejlHE+/0PW9+Bht21H0Si/5wFowzPjrmfvKlipk+1hGv1FNBUsh8IgWb8g0TrQV
 C52dM+opw8lofKoriBVZWLMKrv9lchZDM0BqMGzpv+xtHVxTAD+2754X1H6UWYbmdz6Jt+qAe
 iWfagN99Com6W5vs5lVVg+YjwcjyWxdT+D6pmasZ/JEfYwFQwyLNzv1Srp0WNgn1bof2+ztXo
 8OkZINvu7pNYpjD2P7rLvNy+697RPGvX5kR15A==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432390525653455?=
X-GMAIL-MSGID: =?utf-8?q?1596432390525653455?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct channel_list_t' with 'struct channel_list'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 54084af8dcea..8017a85f95ad 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -81,7 +81,7 @@ struct hostif_data_request {
 #define TYPE_GMK2 0x0003
 
 #define CHANNEL_LIST_MAX_SIZE 14
-struct channel_list_t {
+struct channel_list {
 	u8 size;
 	u8 body[CHANNEL_LIST_MAX_SIZE];
 	u8 pad;
@@ -378,7 +378,7 @@ struct hostif_infrastructure_set_request_t {
 	struct ssid_t ssid;
 	__le16 beacon_lost_count;
 	__le16 auth_type;
-	struct channel_list_t channel_list;
+	struct channel_list channel_list;
 	u8 bssid[ETH_ALEN];
 } __packed;
 
@@ -413,7 +413,7 @@ struct hostif_adhoc_set2_request_t {
 	struct hostif_request_t request;
 	__le16 reserved;
 	struct ssid_t ssid;
-	struct channel_list_t channel_list;
+	struct channel_list channel_list;
 	u8 bssid[ETH_ALEN];
 } __packed;
 
@@ -461,7 +461,7 @@ struct hostif_bss_scan_request_t {
 	u8 pad[3];
 	__le32 ch_time_min;
 	__le32 ch_time_max;
-	struct channel_list_t channel_list;
+	struct channel_list channel_list;
 	struct ssid_t ssid;
 } __packed;
 
-- 
2.16.3
