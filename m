Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48/zcV9Ke/ZyNjB7f/Hl1+w5QcrMlFAT1CLJIuBLIUVX6p6RfMQnQ2YidgFC9CPX9jQbEie
ARC-Seal: i=1; a=rsa-sha256; t=1522393765; cv=none;
        d=google.com; s=arc-20160816;
        b=RZNwZKwZfAhkn095RgDo/ixOgerU652lnV2GSJ77T/YZw8UO375ObgIK1ycPeZ1yL/
         Uhbe6lCZzjKva14JFegiQ5hcdqA65m2YgJ7leqI/OGUKkjyz+mala5d0Cx0SsZmBoTCR
         HSvbzdtd5xDYwgMOpTai9bLtW23AYxLMSG3RwLHRjdeCMRpB+/WN0FJLq2t/OW2zO7SF
         +wrAmONYeFbvLGMR+CO4WsRBakMYkrMXOyx0IrW9BphfANC00yozx8JlYSURbvDuXyee
         AVsxYQb3om6ZV3aCbsTXQ25M0tbSRiodkf9SoDaP4a4TastSu0P1eV7FeIs/KJiWSYye
         /xfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GgtOltGtO315cehNkwj1CLh8tFgbEw2z8jpNmNsIUsw=;
        b=iZnx7hx4j1K3hWQeqQPwZXaiK7gmpj+zvX+zFV44vV/MIofT2Nl2r6t4jLTp+qy7Yy
         6fxA0abtD1lS7K3kTXEEeHbGollcAHqz0LfQwiaXPMdwmZ532XWlUoX8iv5vHDWATzRP
         kuG5fuGOIEm4KRzYhiDgwPCZjmkjMem+PiLfT8JoZJRnWbmvlWOwhMJdbpfigKGMyZ2w
         8RZAfT3i5DBfHL3taJMY7j9+AwShWbZEfmDJ8IYqhPA9W2RHPkUQ8D45AK4RvDjPE3uD
         UV+oGJKrEZmviu6ZPxYpdg6FGItiUUgyYOT6fJHD7gVcxRxl+MaWMxZZMBWUYSQGvjDX
         R/GA==
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
Subject: [PATCH 31/76] staging: ks7010: Remove trailing _t from 'struct hostif_request_t'.
Date: Fri, 30 Mar 2018 00:07:54 -0700
Message-Id: <20180330070842.25224-31-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Uziq88a0qDMZxTDNsUETV9LqVmfNq+1kRRqN2O/goDnsfH6obEn
 WxT8uYGMwLkD0QKaiNrLksrXMKRdjPpX/pZvFi1uCoRZARhV5lsaTcjEFnu8hIJ0dBMDVwe
 vuk8zPg/AKYvF7t7C+faEUEnj7DJG53lEOVBF1w7dmBrGSvs6F58WDOGfZS4eEAO10UXnBz
 x4ldk1IahBEUvi8Yf+WuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eDTD2btfekg=:nwgNgWCp8tdS9UiMngt78o
 bM+lNe9n60Kgg3UewT3NRebvVtMa9bQ0kRH6WyT1kct7quoBW61362OrQUz5/V8GdbKOlmRFa
 jG9kFi7Go1pRMw6i910p15+lWEzcrUoUMU3dH5DGdOGP2k76NKyaXK3YJTJvK2hVHXOSWLKl2
 uBMBf+yo4imB+E43iF2tw/INArzrHOX2yXIDU9Q9tGpOKVpl5T2KiPQAj+6Xf5qRPA4rGgXPw
 DAKREXLq/S6+REki60u/0k8ZXu8a2ZjwMlUduVP4dsg+5GXKEqzmkcLLVdjdTY7kUkdbdpYfQ
 rGb6PTdsQMKmxUDA1qg7SJ2tyirjNWRCAjjkq7c+1lEl7SCZ3BS+MFXi8QekjRfCKkdBQV8H1
 JZoONSe5m875Jaft/4zUgI2cCjQfiKtUwKpQCIcLvwvv7kapRCt0ETfwAX2g616mwviI7HsKf
 URppInmDbyvEbMj+4/3HmrNH18TdVC7esGFD9fspHCXSWh4LseLy/lC+86zI1Y5jByD78ccME
 6WfOzWRcwDhVA+t+FC6fvXUcF+GIcP3aNFBfSXTqHiYK1++H/EAat/v5ZvK2N1sXcQ55NIxfV
 vA/oZYMIDj4mTWYcwFGSkfwigj+yq+zlF2mKa+pCJniIRg935i79ViNZS8xU6qIH983X2iJvD
 MP9WVFsj8kXZtmD9/mGorAS1Lr3kSLxDSdBdAqqDPLxSI5ROE8jWj6qWcZMAqpTn3DhWaaMgJ
 nHV2OG7vgLpUSfTgv5I89+KVpHqzV1ZDLcFaUg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345565198965877?=
X-GMAIL-MSGID: =?utf-8?q?1596345565198965877?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_request_t' with 'struct hostif_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c |  2 +-
 drivers/staging/ks7010/ks_hostif.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 5c78f94e6f72..9798e2427f36 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1313,7 +1313,7 @@ static __le16 ks_wlan_cap(struct ks_wlan_private *priv)
 	return cpu_to_le16((uint16_t)capability);
 }
 
-static void init_request(struct ks_wlan_private *priv, struct hostif_request_t *req)
+static void init_request(struct ks_wlan_private *priv, struct hostif_request *req)
 {
 	req->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
 	req->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 615e2ed979e1..ad42c35d0f2d 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -343,7 +343,7 @@ struct hostif_stop_confirm {
 #define CTS_MODE_FALSE	0
 #define CTS_MODE_TRUE	1
 
-struct hostif_request_t {
+struct hostif_request {
 	__le16 phy_type;
 	__le16 cts_mode;
 	__le16 scan_type;
@@ -360,7 +360,7 @@ struct hostif_request_t {
  */
 struct hostif_ps_adhoc_set_request_t {
 	struct hostif_hdr header;
-	struct hostif_request_t request;
+	struct hostif_request request;
 	__le16 channel;
 } __packed;
 
@@ -381,7 +381,7 @@ struct hostif_ps_adhoc_set_confirm_t {
  */
 struct hostif_infrastructure_set_request_t {
 	struct hostif_hdr header;
-	struct hostif_request_t request;
+	struct hostif_request request;
 	struct ssid ssid;
 	__le16 beacon_lost_count;
 	__le16 auth_type;
@@ -403,7 +403,7 @@ struct hostif_infrastructure_set_confirm_t {
  */
 struct hostif_adhoc_set_request_t {
 	struct hostif_hdr header;
-	struct hostif_request_t request;
+	struct hostif_request request;
 	struct ssid ssid;
 	__le16 channel;
 } __packed;
@@ -417,7 +417,7 @@ struct hostif_adhoc_set_request_t {
  */
 struct hostif_adhoc_set2_request_t {
 	struct hostif_hdr header;
-	struct hostif_request_t request;
+	struct hostif_request request;
 	__le16 reserved;
 	struct ssid ssid;
 	struct channel_list channel_list;
-- 
2.16.3
