Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49V9J6BAP4/WEn3up+FvUakxHmzDHw1jOyOdhMFN+4G9snqJEdyV5nnNjnF6gDjiTTaRYtq
ARC-Seal: i=1; a=rsa-sha256; t=1522140090; cv=none;
        d=google.com; s=arc-20160816;
        b=pk5GnDMMVDjeOhC75+K1xFoXPJM8QIA0J3YSjQ/ZkxADESrczEi3tOTGuHOkUJZLIh
         3U7byPNBoIyh3LUfIwVpP6ldXaQcdWTCfqKKVA29C2rI+Hh0z0dELj75WiswjIwkSbZ0
         anCOvjdgseSGMJCAXaMIT1Zai0GcsN67FNdsBJ0QPAgg0J6/VN5CTskYL3dAQ73P6H6p
         6lPz/05BCpw4RwWvssrCdxzyCsODzuWqxP3RWFaTJgqhs5TUPMkYsZZk8z6j+yYRF3zU
         IdWE5pxL9H55UhHqioJya9sc9z04kY7tcGDgLJ6J00wYCYzUZGECQtfYoyaR6z0RtlDW
         1wdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=AsRNyiHRyoMTjGDGDkBSNblwFVSq+5s7mCYINrMmGuo=;
        b=f74oWB+++2OGKwU6NLCvE4C37R5dpjImw08XLsb9gtdwtF8TiXbuhFADpT0Iov+1b3
         fjlrSMUYEpCea5sSqcMVp0qYZMRvKFlR7/e2itHoTODd8enlpDMhn/Lpg5MvMFi/N9Fa
         EyPKKj5YZoAw107O7jqC1zms6m830GN/6uVg5ZGPlv/HaYGjb6scGqK9gC/f6aXPXwy9
         aqauBIx3n9pX5x6cQOcTpunDyVFhNTSwXOmRyr4E+WO4nQyTpyKtzfR4iUqqKU0EkiQT
         wihR04I2ec71sWrHv4z/q7D9iMWSJAvvf/bpBL2PaQejcSW80pxQTOpay04TS5gqA0id
         chOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 07/23] staging: rtl8723bs: Remove unecessary braces from switch statement.
Date: Tue, 27 Mar 2018 01:40:59 -0700
Message-Id: <20180327084115.16129-7-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:7TNfIfmgLs+ZgrW8y3lGRYoWB5nnvF9Y9WuM0667VGxE4MbjTAF
 nn5BgdCxue3IhUWNdEM4nNYM7LYotcisf8lGN8P9gXd3lwPXIOzzPf5JJ3Jkiz40wtxiUZb
 tlbWyvxzc7Zv3ViTnmt2qDpVqZrJMExtWwZ0yue5aryZ2bVRxB9J52SktBfwfGg/ly/yKTm
 oHFUW2CCV2OB1aZylYR6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DycugQy4U30=:uFFFXB/sGz5k4Tk7ZPS4la
 6QNCJMgwzlBTpBy8pzdwTZq/dwSK8+KidRDgBvqM1J67YQzmoztdptEGfTBoZ7twwwY7GH8B9
 KgWyCvAoQs9v2s1R9C2ZZWiU5+WtCoMvcXU0rwkTxD7fcsyinqC/FVIPQI9+xGdpTiPJdVFTy
 hWpZxcj5EM6VcDIbSDW6RhKJd4xpzVO3TM9iraNnP5lY5DBRFJmDJTd+8HuMqazZDBaKFKq1p
 gc3HXK0DgHxAXNHgUSqmMrXnJPtag53zjb4VpdiaQqkjOUTQNjsiTyw9N+cssa2CDgBGlVx6H
 +TMlJvwP61R2dszFQOvjfE0zbTfRDSck/QyJzxGfB0TbjOcXSZzviBVTrvS02rSdOJxhDmVVA
 pv+u+zDXuWef9TkApsE4+DqyeRMq3VTVgCFZDEFoIta+c3DRT5mv2AaOdO8JfnHsGcHJZa3MO
 +jvnuLEVsvDvif/j79XFCCoHdNudF5KQM2bg6jc6di8Wo8vKbRzqAbMzKbLK2VkokrU/k7UQy
 eHPZzWjjvrD2QSRiE49F0ZjYJZirfib+HjY10YIuENZ2/nnqXX9B7JAh71m/pKacf41bGjdpe
 x8sr5R5eUlINOq7vSz4W7gieDz2WNMUnGnffVu/FgHtKaIYekpOBawO/LDfHjazV8imHmOE6s
 fhPVKcD0eC6na/5vWk9B7rd+RIetBacnMRDRwCuuVolyJJbGXzbtN3f7f7/s2oiThcqSOK8nE
 TGlxXO3YQbXcET8ggI4OCNtBSraJLpmiGRwVlw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079567314747317?=
X-GMAIL-MSGID: =?utf-8?q?1596079567314747317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The switch statement in rtw_wx_set_auth() wraps individual cases in
braces for no reason.  Remove those braces and unindent the code.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 50 ++++++++++++--------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 1b458074b7f9..3e78fc28a8eb 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2151,7 +2151,6 @@ static int rtw_wx_set_auth(struct net_device *dev,
 		 */
 		break;
 	case IW_AUTH_TKIP_COUNTERMEASURES:
-        {
 		if (param->value) {
 			/*  wpa_supplicant is enabling the tkip countermeasure. */
 			padapter->securitypriv.btkip_countermeasure = true;
@@ -2160,36 +2159,33 @@ static int rtw_wx_set_auth(struct net_device *dev,
 			padapter->securitypriv.btkip_countermeasure = false;
 		}
 		break;
-        }
 	case IW_AUTH_DROP_UNENCRYPTED:
-		{
-			/* HACK:
-			 *
-			 * wpa_supplicant calls set_wpa_enabled when the driver
-			 * is loaded and unloaded, regardless of if WPA is being
-			 * used.  No other calls are made which can be used to
-			 * determine if encryption will be used or not prior to
-			 * association being expected.  If encryption is not being
-			 * used, drop_unencrypted is set to false, else true -- we
-			 * can use this to determine if the CAP_PRIVACY_ON bit should
-			 * be set.
-			 */
-
-			if (padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption1Enabled) {
-				break;/* it means init value, or using wep, ndisencryptstatus = Ndis802_11Encryption1Enabled, */
-						/*  then it needn't reset it; */
-			}
+		/* HACK:
+		 *
+		 * wpa_supplicant calls set_wpa_enabled when the driver
+		 * is loaded and unloaded, regardless of if WPA is being
+		 * used.  No other calls are made which can be used to
+		 * determine if encryption will be used or not prior to
+		 * association being expected.  If encryption is not being
+		 * used, drop_unencrypted is set to false, else true -- we
+		 * can use this to determine if the CAP_PRIVACY_ON bit should
+		 * be set.
+		 */
 
-			if (param->value) {
-				padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
-				padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
-				padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
-				padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open; /* open system */
-				padapter->securitypriv.ndisauthtype =Ndis802_11AuthModeOpen;
-			}
+		if (padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption1Enabled) {
+			break;/* it means init value, or using wep, ndisencryptstatus = Ndis802_11Encryption1Enabled, */
+			/*  then it needn't reset it; */
+		}
 
-			break;
+		if (param->value) {
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
+			padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
+			padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
+			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open; /* open system */
+			padapter->securitypriv.ndisauthtype =Ndis802_11AuthModeOpen;
 		}
+
+		break;
 	case IW_AUTH_80211_AUTH_ALG:
 		/*
 		 *  It's the starting point of a link layer connection using wpa_supplicant
-- 
2.16.3
