Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/vZnMVqrgrAARi9OrEnpOSEcq8Ksn9M1d8i4Yl70rEiSeJMdEBU4oEh9JJqYBArE4siNuv
ARC-Seal: i=1; a=rsa-sha256; t=1522476577; cv=none;
        d=google.com; s=arc-20160816;
        b=dFDnk2yq7xptuE5c9H+KOOE7Z6e8cWqioQTsSCtr+Qp1GJp8t6F4PFCq4rhY6LmQGq
         REkmr8A4Wqwar5eOgoTOzA+yEF2F0yATxm5Ir5tSw5lQ3axcgK5PDwTpbQZAoaOVmdRP
         RNDDclbsSSwtgCDM2CRgY3Z+3ZEzYo6AOy+e7VEZ0zVdEsftxzVahuS4rFzDG8Dc5d8D
         dJRzkYkk3Amure+OmJcaOHbGsWVFDss83Ugy6Cbj279Azfu1Wg0X+tyqm8RCI9OYiMRo
         J5U6v7Ya8o9CDxdIoWxVXQvu3Fx/+tTQeef9kJyp1ZsPbo20S1EDmSkmgM7+WHX/JDoH
         oXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8r5xNDGONl7ZH/bSnI947oMW7FaZ9T2lh4NHP2A/AbI=;
        b=QgFTgXgorRK86L6bSkayDMorAcxL4yyv5UA/UKi1BTFxIP1P1LzJxoCGVaOokwqvC+
         c1ITgNgepMg9j3xsKK43XJauHwhXMN+HEp8713DS6XEaZJlyjtfU3/PWEELwX5Rdhui1
         tn0COoWVFYABKCq2QtjzticBW+6QIAgBwzIW6DHMjvKilz/MN9QS7Z1/cxV1aWCdrSe8
         YHQ5BZyf+fBgpHbquMbhrhR2FuTrffFlm23UvRGiBJJrTmv+H7gAGOTusWpTsrWrvEdw
         ywHn/ZbTtrg2/YnW2lNyiOZWDCw/nXTptDRfttUvX7OU0z+VfQ0MoV1pdM7EDX2mGAsH
         9N+A==
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
Subject: [PATCH v2 17/75] staging: ks7010: Remove trailing _t from 'struct ssid_t'.
Date: Fri, 30 Mar 2018 23:07:57 -0700
Message-Id: <20180331060855.9452-17-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:URjRgd/VGaAnwpQa7lOF9GAmy63ALjIVw6a4kcE1ZlHaTd0Ptog
 zdqQt+AJuJiGv8lQ+su4Sw6C5bpgooh8rhb+cTfuN0eNnnRQMuVXbz+t1ZldO0f0q/Q9tX9
 oeCz3YKsWDv3GFwb61OHjuBKeIlo0EnVkGf7sD2YZw1d8fXPErMoqtvd7zdUGhiefEvY6YI
 M9k6gH1YYke2o3aYUEf/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ECkgs/rqdgg=:tBqJgQrYk+3CYpA5phODcU
 A7d4NmZPCxCyi+29af3DWeIXyGreAkI+KKslxGNe4MclgsUhfY8LAB0EMAZ8/cXPInOS0Ldjd
 H0fQOu4mUNyvC2LKC5/jOFhW5tXz4pnljWyGUW3yZjGl5goAQ8CP9WZ051nCHfgDFN7tP4Olu
 WO+d22is5IT1B0NXKn3mEGYJis6av1zrbVVL7oYJHVVvojFcaBrOKlIOP8oQ0VHPKbiK3p4g+
 GHdPXuAmONdsb5Y6yrcxbebmb8CkcRgELKzFm3Tl9G0aNSPIG2in72zK2PxLGzE9aCT1ImBWN
 54sI3vgBhLDViE+IljL5G96jzXs8RCC0AW/5f/DLjuoFGvkrn8xzgU7s6ZupUQA3kouONTGNy
 BXrpH5Vl3UXmuUqb9jZXVawhvkb0C9sbXqUAEwnRApXBODkGWW+IXWEt2O5oaIPLkCH/O6cci
 1kTpX7YgD5wJAbzKCJyrN19Of7gcYGfCioseyu3Chs+fo+klUOhR/X6TGL5tqcL6lgnw+L8DA
 Mkrxf/x6wsgkAClA31sxkS47Aid05jDo3tV/w07/cQ0ypzZ6kcX5zEu2papgenhCHiHLOPhs1
 Bm0JHVx0rrN58ilyokBpt1MBDgRrHLrkLErLX3pf5hj/KYDu/UTFoEtm/pWmHxoNZhKn3343T
 cLLsZ8c3RbTzttgEPEIyY2u01ECswWDAZ/F4ZQsOGBlkuqooU0Ac2K5NiU8tWa14wxi3xp0af
 QPnjmPC+3/qh2hYAF9Va4KyJ3hbLH+8y1Q0jBA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432400258107588?=
X-GMAIL-MSGID: =?utf-8?q?1596432400258107588?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct ssid_t' with 'struct ssid'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index af656a839a0a..5abbbb46a804 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -196,7 +196,7 @@ struct hostif_start_request {
 #define MODE_ADHOC          3
 } __packed;
 
-struct ssid_t {
+struct ssid {
 	u8 size;
 	u8 body[IEEE80211_MAX_SSID_LEN];
 	u8 ssid_pad;
@@ -353,7 +353,7 @@ struct hostif_ps_adhoc_set_confirm_t {
 struct hostif_infrastructure_set_request_t {
 	struct hostif_hdr header;
 	struct hostif_request_t request;
-	struct ssid_t ssid;
+	struct ssid ssid;
 	__le16 beacon_lost_count;
 	__le16 auth_type;
 	struct channel_list channel_list;
@@ -375,7 +375,7 @@ struct hostif_infrastructure_set_confirm_t {
 struct hostif_adhoc_set_request_t {
 	struct hostif_hdr header;
 	struct hostif_request_t request;
-	struct ssid_t ssid;
+	struct ssid ssid;
 	__le16 channel;
 } __packed;
 
@@ -390,7 +390,7 @@ struct hostif_adhoc_set2_request_t {
 	struct hostif_hdr header;
 	struct hostif_request_t request;
 	__le16 reserved;
-	struct ssid_t ssid;
+	struct ssid ssid;
 	struct channel_list channel_list;
 	u8 bssid[ETH_ALEN];
 } __packed;
@@ -440,7 +440,7 @@ struct hostif_bss_scan_request_t {
 	__le32 ch_time_min;
 	__le32 ch_time_max;
 	struct channel_list channel_list;
-	struct ssid_t ssid;
+	struct ssid ssid;
 } __packed;
 
 struct hostif_bss_scan_confirm_t {
-- 
2.16.3
