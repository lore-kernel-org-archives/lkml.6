Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49E2UMn98EwmCZJtsjHpug1xV3PDsMNwp5kf9GFxT/ndrS7c46UeAEFxZge9qmggpW7W0VY
ARC-Seal: i=1; a=rsa-sha256; t=1522393794; cv=none;
        d=google.com; s=arc-20160816;
        b=eMrkvImV58uPWYVsU+t9UTskM27CdqPyVp6ou1HQyAcRmPGrHDJOMkv6kqUh67Pb0U
         WSJ0mhnxbcxUD9ijDK32wAdodgB+6mn/C+xQdv1/F9mRZWPU5U6hyVv6k+ZP/5pi+LqN
         q0b4YBeQyBoLzXaAsTpG5Y896SsjpTTkni7EoxEv3BFeei70dyK6w5ZqU5cGolCRYl8e
         MXTFCRl27hXyA1fzdtZyZ6/pPOV5dB5DhgfpkiTap0jpjt4o0URJEwWzKoniSnbYXbQF
         5rYXMRUTiofKaIf6cRJDzpnrL7Mu4xpEuuLd+2QEWKqmVhlsda1+bRHvgcSXLuVY3iul
         EJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=+R/pJsZcvF0cHwcHgYZrACFj9kkOYRUJ93xJeQdN498=;
        b=ikFUqFkEAOfmyrHn0Yqdhjw4lhWX4KX7pnINY6EwZi8KZbzMMuQucYmtlujDqPwDv0
         tpImJXuTm6E1i2jsu7gHOKhY2XX7KROIQwIxrVqlKQg1HnxY9CjQ/NDFJjZmHHwXdyXJ
         DxwsXFeFUpEJFmcX88fe0+iWWWJzmcslvidvDUOppS8EPXJ2AlafAo0uu6crEvGvbQIx
         Yi2p0YtD9X5Y2SxYWFPNYc6PmqkEGhe2SFKVS7xFj0og46QvcO6RmnTFeR4e9C6ZPY8U
         WD/w7Cob5z4KBx3cytO8DJ7Bzsf0KvmiNXjDsawRiPhqge09e4J+bGl1l6uxOPauJadz
         6Myw==
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
Subject: [PATCH 66/76] staging: ks7010: Remove trailing _t from 'struct wps_status_t'.
Date: Fri, 30 Mar 2018 00:08:29 -0700
Message-Id: <20180330070842.25224-66-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:t+daOIhqy7yypA9XCL1s11K/PhQNZilNekiJj9MpUeEuYBYdC+k
 LEgNeyNtFnawpyHxaITcwhFO1VFd9ei+6AKPmtNuy41T1hpUhROFFwYqVO6XzTaGQuHrWr4
 7U3pmG6L0sZyIOOWYfR7Bg05EHsVnPkESTUFk0kYdeDLEGMz/2fQpbrKGfK0RTQYt5YbnaJ
 /MDc3TFQC+HMODSc0GtvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kkmpxl7FHps=:ZGb1A4TzFdEfxIeQCx0b2H
 SxBgra9nwYWkmuEJWlc9puOK33ugnH5pgH9io8u4vv1g1tYyXe/ZDCgTAcVx0o9JTcSJ/0HPk
 vhaeqssAuYODoYoD+yZPRNM1CzLofU2YWoco2Sv/vB2bUoiCC9VV6ReVM2AjFrzFXqUdlAGas
 Bsoj0QJ3jyv/ZSUTEn3MjpDHACH+HpGQSSZaNdv4R/GFsh6x0G3GzoUmxe5hVRGzRif2VK41k
 3c/1/VJxkqJokMWdUx/BfEkHEa2M+Vhuko4YYNni3EMFa0JEedhnXgMSJg6LvD6HllMspn8QN
 oh2Qgtfgv23WhRmAHH1WIWxkikg6QFSizWK6sJrEXTMvn7wNJih9RbdbL9cosTGFFQe+l0VDl
 I838dMXBiufqLc1VbUw824X/OGDtbitxlgxubWVWh1CXkxxFoPrI6UEAm3MLvn5Wl93Ujf2Dz
 S/lhhyixKcCSXPAadGJUOyeFRsLR6VFZW0oP+OnwpE9B757uA2IjMkc40iUls9b+ihHGNIgv3
 hbzYzNjZYCFkdYOF8eqvHGr3VZZNulV3GsIFO3Q64tOyVakvhFds0F8tYoUutjGW8Z15RMqlc
 he2Y5mLYU0z18K+tv+ppvdy0Dckz264uN7ul16mFp0qVhbvf94hPJq1YeXBl7kMZR+Ytk9A2f
 LIgooRSV9V3ILK1TSy8bMOIBBPyWZb+GGNN/b28/zVvCwgFn700kzmjuRKiLIjiUVuqxQ1IeV
 sYn1kd4UJuJ9eMmVQXBtla5V/AVPDQBIPQIJCCzUWI6mcTtQW27hXpaA5l4R1tLN7qZWw0iuY
 i8IaFEmSW3bAqjioR2xnOEJNq1J8NyHu/J1+12CQXX0VJLPnEoW4UrvKvmXqR0fM6sfLaMv76
 dPA/RvT963YhOM/aPu16iT/IiNRulZVeq7+Cw96oAA1fdiI3Sj16ZqnFveNQ4m
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345595937893528?=
X-GMAIL-MSGID: =?utf-8?q?1596345595937893528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct wps_status_t' with 'struct wps_status'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 20b584524a77..eb0c14e78bd2 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -391,7 +391,7 @@ struct pmk_list {
 };
 
 #ifdef WPS
-struct wps_status_t {
+struct wps_status {
 	int wps_enabled;
 	int ielen;
 	u8 ie[255];
@@ -475,7 +475,7 @@ struct ks_wlan_private {
 #ifdef WPS
 	struct net_device *l2_dev;
 	int l2_fd;
-	struct wps_status_t wps;
+	struct wps_status wps;
 #endif /* WPS */
 	u8 sleep_mode;
 
-- 
2.16.3
