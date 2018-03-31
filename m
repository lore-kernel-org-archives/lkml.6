Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48j6Wlz5rAvjRik1hoOXOXfQn8dkqos9iZpVqzot7hPwuYjbwANVvjBOe5RKbfF0jT7ft7G
ARC-Seal: i=1; a=rsa-sha256; t=1522476610; cv=none;
        d=google.com; s=arc-20160816;
        b=cVzHwbptvGPZ/p2O8HHeN+8mprLVwkX2PchcoThOvHsv3lAWw3NjGK+ef3Tk8elwty
         BwJ288I/AL0Q9wePWF+0BWiaoNRLAoI4CFJ83f1PzqSoWZUnfbYxRrgkqyH5zxd+LpkU
         XIgsMIKchQ+n2isqDAhWGlE90YBxPBMsZsk6PEv2ngSz+eExlnnlnvhtpUIJxafBAWVf
         Iov85ezwkM9g0cC0n2GPJW/FnOHXeBmf/OnuQvADForwMM+hQLymF0MV+d0yBKh/dolz
         umT8Ccfm8B9x0yj4ND0J+cqKL+8p409BygLuze7m0i07xJEbvy7vqy4BINOb0UYUEEtu
         MWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=vWJ6v4njFQ2sKPugg6C4apAdHYPwQWPWKW5FiTlHx2o=;
        b=px5PgxUSerr7fUOfyxH9EDEqIQvzJ08LKQLAar8NEGppdrGMFP0KeIM03MVlz5ztBh
         TJFbkiTnUzeHHU9H+vYBIW1FWiVRH8mx0sUk/fsA46/tcq/U2Z4ZXtLQkBeC+zNAXdOf
         kQ/aIUeyC5XJoYqfVGIaVQEjDBZ7b6l+9yaWQ7l+2gwD2fPh/FqTmg9N9Y+cYs2SbXn8
         c9GFkhWxoJ/VzLyRnvFvWIaT6hko0q04BQl/IDAUJbb5c2y4CivHriOJr2M4yD/oYzfR
         A9CBl3P6fsmhrpjy76lgzqmS7U+WzuYs+MkvuHzb6JInqh40+aNeyTqIdXYKRavCWB6t
         GXxQ==
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
Subject: [PATCH v2 53/75] staging: ks7010: Remove trailing _t from 'struct wps_ie_t'.
Date: Fri, 30 Mar 2018 23:08:33 -0700
Message-Id: <20180331060855.9452-53-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:3t/D1CuOiTsC0dFCDtdsYYUxSiiCxASBBghm3zRY87wouMDW0KR
 7WqHAtFEZjsQzXpP+LHXx9YQgJiEejkTEWq1auw+n7RKBdaGl+kMEEqb8hu9Obms1Mrt77U
 gT6Ugrt4oaa3OZCH2YdnOX0XyGyFX9ypOimvdd/rFeb9d59ZJbE3X6695pt4x3VYW5q7ZKi
 nGOWpIkIyKzPU+ruTmVsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TI4Jvb2SKXU=:eM4JjHCFFQaU7iowd4DjES
 SgC0AWSSgDdtZ9lUv7obTXcAqpuEOofAcnu9xW9I1qfshm+ht/vAmuuK40oYI/OPc4tNxeQ/O
 ga+7B5XS4187ddPVUVT5j2dSRgkWnDZETsMvx//UDM1MxaEs4Cu9uuTo4m8Ibeu8qNmJ/x+UW
 +ShsihbPwLKf4lRkV83yZy4sNPGcdPuCBDBnlBwCyWqbm3vpe7tz7KbwKud50IGfkbapzSqlG
 IxUoIFY+H0fEjC5X0FmpBWHCN69sBl3vLucM8LZwzi2MDg1dMUfpALtTwSJroqD1pfJyxZ+9b
 dOzcHx6ztw9h4Ho0MJDusDkGTpjofUCzYSN7GZqkxZEWskI2MA0G1EFEG6O8kE6zFzdn0yPhS
 CWoofFgJYrkV4r7IfMkIADcjjojAnKL5o3jDL8uPtpCPTLfXrAEOyrErcyw/fAypgtgDvOuov
 s0IVGR5WVuO46Q+7CdYFT59+KYA9nLE7vsUWnP84C+ASkJY8l4Wjn8TIjAwqOUSbi0AID0Bh2
 pYJdlvazMQQ7gabePxDVVAvwqrU9+EEIQPW/Y1WyIp67H1YibY8+7kPVjO47fq0Cdmz84hiLV
 b/3krhIT5s+hkqamsP7hi4xfSOWGfA3Edu8g6FqHTxyL3T+Z0a7XClI9q1tUIkByb4yRnAIGk
 wqECiD/aHfrCmIK9h4nPe8Ge28hh3ZikPHnm76TJE5jbIpQPPtttr0MNN+xppgjcX/K2Iplaf
 DXBFxmMp6fCP9TyquC3e88APVWChrlQLutd6w75i/O8345NM9lzKMvongZxVX7BloHtD01hA/
 1vXHeEKC5XH3AXzHX0uTvZb8dMN3BbmLMBALD9GgwdNtq08U9m/DTZXkIdNG7xchn+lBqyYVO
 o0Kxs9DLl8x8e3CWOXvsJ/hsNP92M34gUMyL6HhvVlfdHgXHr1LAvXd7o0psjY
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432433930865644?=
X-GMAIL-MSGID: =?utf-8?q?1596432433930865644?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct wps_ie_t' with 'struct wps_ie'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 10ff4460594f..30d81f9456b7 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -211,7 +211,7 @@ struct rsn_ie {
 
 #ifdef WPS
 #define WPS_IE_BODY_MAX 255
-struct wps_ie_t {
+struct wps_ie {
 	u8 id;	/* 221 'dd <len> 00 50 F2 04' */
 	u8 size;	/* max ? 255 ? */
 	u8 body[WPS_IE_BODY_MAX];
@@ -238,7 +238,7 @@ struct local_ap_t {
 	struct rsn_ie wpa_ie;
 	struct rsn_ie rsn_ie;
 #ifdef WPS
-	struct wps_ie_t wps_ie;
+	struct wps_ie wps_ie;
 #endif /* WPS */
 };
 
-- 
2.16.3
