Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+mch6hN4YEqh4wwcKy+K46lohhk+DZj5Y4FEAeGptksmRXRoZIqWkaaii8+POqHEh5f+wU
ARC-Seal: i=1; a=rsa-sha256; t=1522393784; cv=none;
        d=google.com; s=arc-20160816;
        b=0Qh9we7jiGYXl0N2TmdAVt0q9g2aanBFWaVfgA54bfDR8t9LMnnyZtUHkspOM8qBNy
         C0nnqKHNvzX6slutCIamcs8lLA8Sl5BdT6VrzjVmAWCFY9a6ogmhLiBapUSZ+UiGh03q
         dDNk3NQzww/Ab618vhQHN8SkGTTnxxeXGoh2X00XxLExROGNkzs5bRMk95gS36LGMNFT
         sNy6Mb19FQcZBJa5WCQHVoB+zK7VQMZlm+9tolH142CMFhbpi3hlBZjM1zn40Lm88ZsW
         4CgLT10OnxqZof0nwMcGtFCb8vTbTDxAMs3f2OrUWuzODfEcSpgSpXJR0y0F9KQAQb93
         DoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=UwIcQzipFgg3TvM13kG8ZVSzH7AfUF3iLyyQIB1/Imo=;
        b=bvzsJJNAOKt0Y2aWb9sHkkAEyETLSI2U9wLji4VKLRdY91weZXhzTojpHF35j3SV8I
         WvAJv/9eSzqFRnfg6dV/7baQCiHFv/JL5o4f5xLClVTsVE+R/nS/A+ZNirM6MS0ZC6DX
         gZUdHl8drXYf7KephNcMLyH0JNgHTPa25ZiXPHtViVkiNy3ua1uHBgW8eORDfA9b6plD
         LkwNKLZ59ozzCUE7d0sIaH31DOurrywhUnBSn2TjA/hAsIi3DjJfbD0oNY3fG49gEoEa
         QymR08U4IP8OLk+fk/qHzwm43hQgZuE0/KIHQNeYVVOpnDb8oqZKGKV0laP5UIwb+e5+
         trwQ==
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
Subject: [PATCH 54/76] staging: ks7010: Remove trailing _t from 'struct local_ap_t'.
Date: Fri, 30 Mar 2018 00:08:17 -0700
Message-Id: <20180330070842.25224-54-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:HtKCb5NECYeGThkUB6/MpWtYvFpUz2yzZ2QN+hrwRfkVDdVl+++
 3Qe14ODoclx6Ze1Sc1U4kkD5UdyG1Y5cwon/3Hlqf+us6G9NvsdM077LcK79u1Nr+fw+suf
 CfNW2EkFsnA8zbocMaz6QRZ6IZxjnXk726jmrO+k+BUp4Cdw2DJRQeu7qPYvKaTn24UOi3p
 dokyXAdpcw10YlJygBbXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zlz+vlMszCk=:1mh4DFn3sDoIWA2VTek/Ka
 lqEV2hP+OSJVymuy0jeVdFC/vdh+xw3SJDA9eK0h0FmDPEeXLzcakxJ95D2G7Xqr3fIFLNUyP
 JB0uPo13i/lTNFcllMYrn4j+M/3IWa9RBv/SMj52ilBlQdX3tYvs2dDGspxf0RpO3G35yQWKl
 qs7BE3G1Fs5tbX7ukaIxVp86s6SqzxHhnws15c25as656cv5bIcbsvbRcOuFoD4rcmbRBm4Vh
 U57pE4g2bfWzWa3h//JYAsnbBbf7rx9alRNKiEkC0aIkMSly9KAeJQIYzhpwqNQIEAIW5241U
 zjWpkJGxn6ytMNEKGecjgx4kAWzQ4Hee7SkaidGk+aQxoG6CX5OWMyIJjTKR28EFFAZYGnr/8
 hS/H0uUxyoefaQwDYA2q07cJ1/p0EY4yS4w4HkvTKpCxchC5cWFRjqsEc9KgiojGWeeIIwwe/
 hrfI6w/s1nwx2XsJA0tAY7acUOfpL771dIzH8tNn3cSGihuwWcaeo32sTeDhxOjPxO1hhocvN
 fHu7N4ysOHep0RHEiOwGUgUknFSVXt1rb9z0SdUT0lMlf1H6ywXGg7um8OI4TcqYpjXw1EIvy
 +RnWhmiPwSDHgcJvnF4QzpCgMlpep0xd1F8KofJJGgg12hVpbJ8MlzCtpfyhbbLAd7HTRyHEg
 yVmmAB7WolKhWI8iKiGD5AspR340vwlkvg8eeTSJKuZ1GhNDEQpWO0OuGH8S9zrf73k1URsGL
 bd75EoZ6+WZ7tIrYCQ6O0+I/N2YNp6NoEKp78w==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345585534881601?=
X-GMAIL-MSGID: =?utf-8?q?1596345585534881601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct local_ap_t' with 'struct local_ap'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c   | 10 +++++-----
 drivers/staging/ks7010/ks_wlan.h     |  6 +++---
 drivers/staging/ks7010/ks_wlan_net.c |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 2f732d8bcc4f..0e6f9e954a36 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -109,14 +109,14 @@ int ks_wlan_do_power_save(struct ks_wlan_private *priv)
 static
 int get_current_ap(struct ks_wlan_private *priv, struct link_ap_info *ap_info)
 {
-	struct local_ap_t *ap;
+	struct local_ap *ap;
 	union iwreq_data wrqu;
 	struct net_device *netdev = priv->net_dev;
 
 	ap = &priv->current_ap;
 
 	if (is_disconnect_status(priv->connect_status)) {
-		memset(ap, 0, sizeof(struct local_ap_t));
+		memset(ap, 0, sizeof(struct local_ap));
 		return -EPERM;
 	}
 
@@ -224,12 +224,12 @@ static u8 read_ie(unsigned char *bp, u8 max, u8 *body)
 
 static
 int get_ap_information(struct ks_wlan_private *priv, struct ap_info *ap_info,
-		       struct local_ap_t *ap)
+		       struct local_ap *ap)
 {
 	unsigned char *bp;
 	int bsize, offset;
 
-	memset(ap, 0, sizeof(struct local_ap_t));
+	memset(ap, 0, sizeof(struct local_ap));
 
 	/* bssid */
 	memcpy(ap->bssid, ap_info->bssid, ETH_ALEN);
@@ -2359,7 +2359,7 @@ void hostif_sme_enqueue(struct ks_wlan_private *priv, unsigned short event)
 
 static inline void hostif_aplist_init(struct ks_wlan_private *priv)
 {
-	size_t size = LOCAL_APLIST_MAX * sizeof(struct local_ap_t);
+	size_t size = LOCAL_APLIST_MAX * sizeof(struct local_ap);
 	priv->aplist.size = 0;
 	memset(&priv->aplist.ap[0], 0, size);
 }
diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 30d81f9456b7..3104ff92c453 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -218,7 +218,7 @@ struct wps_ie {
 } __packed;
 #endif /* WPS */
 
-struct local_ap_t {
+struct local_ap {
 	u8 bssid[6];
 	u8 rssi;
 	u8 sq;
@@ -246,7 +246,7 @@ struct local_ap_t {
 #define LOCAL_CURRENT_AP LOCAL_APLIST_MAX
 struct local_aplist_t {
 	int size;
-	struct local_ap_t ap[LOCAL_APLIST_MAX + 1];
+	struct local_ap ap[LOCAL_APLIST_MAX + 1];
 };
 
 struct local_gain_t {
@@ -424,7 +424,7 @@ struct ks_wlan_private {
 	unsigned char eth_addr[ETH_ALEN];
 
 	struct local_aplist_t aplist;
-	struct local_ap_t current_ap;
+	struct local_ap current_ap;
 	struct power_save_status_t psstatus;
 	struct sleep_status_t sleepstatus;
 	struct wpa_status_t wpa;
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 533feef604a9..a4f10bec865f 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1301,7 +1301,7 @@ static int ks_wlan_set_scan(struct net_device *dev,
 static inline char *ks_wlan_translate_scan(struct net_device *dev,
 					   struct iw_request_info *info,
 					   char *current_ev, char *end_buf,
-					   struct local_ap_t *ap)
+					   struct local_ap *ap)
 {
 	/* struct ks_wlan_private *priv = (struct ks_wlan_private *)dev->priv; */
 	struct iw_event iwe;	/* Temporary buffer */
-- 
2.16.3
