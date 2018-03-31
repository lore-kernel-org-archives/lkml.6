Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/YkCyDCwuwMpHmgOrV6FdyiWjaYZcwzx4NuPMUtrRM9+GhGr9xT7jCGPI+glnIHiQ3+I/I
ARC-Seal: i=1; a=rsa-sha256; t=1522476590; cv=none;
        d=google.com; s=arc-20160816;
        b=F6JlDfk4abLch/Qxclbgxx3SpROh5K0hFPZSFH/52lmUY/c/pk8pRI+pJI01WUP1i7
         3pQUBuk9OtycGCMf4QWIVx6hVgKYX/+5zgdi9TuMO21If1iSHoeMOUuLPH6LQ1ssnqeE
         ahUTUsGN/LyukTcxV5KFoH66ODxM0A8Gj6ijfJGVgTSSmCVofnekgAnL99vB+mWlEzqX
         SZeVA3dEsiJoHNQMxMX6/wHTybJuNGGz5lsUcNjAQ9hXnC8F0oBWeZtNAMr6C187tIHM
         XzH8fpHc0iDL11FaqbMGaEUzeOo2Ao5lvlN6+JIxaq8srhMhe0Lqp9o4FS8hfWFtfyac
         mroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=5Gu2YAykg3bK4eHqMFAX238G/2k2GS66lSyPI8lmh1c=;
        b=o3dZK4ka2AjKoI0eRCvqE3XMdelqYstLiiLzNIX0vj7oUZo+u9tqyLxAA10wTfWyCE
         YQez8GW8TwAcGRgcA0VXWMnvY35uBFEC7iFdOozWprzOt7ZbtS0kuJ29lYODol9fE5Wp
         LCVomiaDtdn7ajUfGwkhmwllRfNOlQUIdXrg85WioJT7oh0vgjm6IkDzflpfv2cl3olu
         mCp8bTSn9wbINIkcqtSkmxbJE0EGrABJf7zVpabyU3tinXzwjHdYl0DBB7vujHCSoK/8
         0YDOoDVbITpJCGaI2q7bLyfzhgiybvkP3PUva9nu1vNCTKlMvARQbmGOAKoMlsKDnGeY
         nkyw==
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
Subject: [PATCH v2 31/75] staging: ks7010: Remove trailing _t from 'struct hostif_request_t'.
Date: Fri, 30 Mar 2018 23:08:11 -0700
Message-Id: <20180331060855.9452-31-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:lGdYKR6eEj9ph5XFZ2EkccmqIYoUFJxgnblT1lTL1OA5sH9+Wzm
 N+pHBk2nHa32EaAR1r3EV1x+QzwkTejGbkupCCYjyU5N2wpfLgSoVg6lpagqYhFaV57Rkko
 +LDUGaC52I+OoskmxSrVUKHFnNJ0kK7VPkfY3fz4/Zv6SCaYvTQXe5c+1VsKM3p1gsC9P6X
 x/YvaHDdTI9vSSsG9AiIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hBdwMtURmTY=:dBEuSyeNQvf0T+J9GSI7Ta
 i6ei1jHq9h7qs/zI9JySyq6Dhd6Ui4VePioEQWvBPLA+mjcj/5CDLNXZV+6GH/JR3cqKN/KMs
 BRlgok0SQuP0tybKVOL/4s54ldJ0HuzVBkT9tTiLiy9USLVh+iJAM7ekQRwHFGHakvMPMYD5i
 9ppKwVtLyr+Kii4od97aO1DkzRTZnhEdEDKAPoW5boVZ06e6HafYnb6cV6C9JQAXcLXC8O/h6
 FU8NGdbn1JOWPsxyvTVUgpo1oSV6ghhGdkFUSSg51ONJwJStouw/dT9ltVEXzBCCLy5XrvDFC
 rujHv2gmsDgf5gWo3t4fnLgMHth+KIQR5bAZWUs5fNfc+9hvGXI4zGImDzrRIliNkUkmGe4m3
 JBEyTJSGUQchrCBq06eZFrSZdOR9fDISN1vH+rCouN+O/ZmohHCcpJEJq1KCeBQ7ctZtUmuF/
 YdUd2aCWk1vgu/w6kKJIdXLIUnkPZiYmTtWBORqIFeek3LexS6lmqhsM/aXAlwYhsMyJdmL1k
 6s3jm+vMzMPFTEAwZPqTZQiJPFpWhdryO3FMDGBT9Grv59ykdqe1YVqMlMA9qNT6aByCKRTGD
 AKP9j3jbCzF27Yd3Z2IwLZcH5suQi5JNph22pjhqiFa1mS5KUdi1ho6UIajD75XLn7rgeFo8T
 t/lPMK8l4qRZmw9h0mVYVsNEaeXPzt9rpY96ahR7Z+dmw1Wxt6dN2GZFvMBRy+7pYQ963Yd5/
 ixFI4t8RCgVPtU0ykVCsflZTR+EreSY4iSwMKw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432413352782114?=
X-GMAIL-MSGID: =?utf-8?q?1596432413352782114?=
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
index 52febac0cc60..443a528fef1e 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -300,7 +300,7 @@ struct hostif_stop_request {
 #define CTS_MODE_FALSE	0
 #define CTS_MODE_TRUE	1
 
-struct hostif_request_t {
+struct hostif_request {
 	__le16 phy_type;
 	__le16 cts_mode;
 	__le16 scan_type;
@@ -317,7 +317,7 @@ struct hostif_request_t {
  */
 struct hostif_ps_adhoc_set_request_t {
 	struct hostif_hdr header;
-	struct hostif_request_t request;
+	struct hostif_request request;
 	__le16 channel;
 } __packed;
 
@@ -338,7 +338,7 @@ struct hostif_ps_adhoc_set_confirm_t {
  */
 struct hostif_infrastructure_set_request_t {
 	struct hostif_hdr header;
-	struct hostif_request_t request;
+	struct hostif_request request;
 	struct ssid ssid;
 	__le16 beacon_lost_count;
 	__le16 auth_type;
@@ -360,7 +360,7 @@ struct hostif_infrastructure_set_confirm_t {
  */
 struct hostif_adhoc_set_request_t {
 	struct hostif_hdr header;
-	struct hostif_request_t request;
+	struct hostif_request request;
 	struct ssid ssid;
 	__le16 channel;
 } __packed;
@@ -374,7 +374,7 @@ struct hostif_adhoc_set_request_t {
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
