Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48eIMJopfDC3kgWbCQ5+tOd+0QkOoB1p0MKVXsbrUl+mJKUzgw7kjTKIB2Q6aA0XnVuno8A
ARC-Seal: i=1; a=rsa-sha256; t=1522476579; cv=none;
        d=google.com; s=arc-20160816;
        b=KYKTm5Wgr4b++DvSulK4ZDO/V5nCV0Sc6iFI2GyKYW4sLTcbMtPe+MmCgI7qAEzKFw
         Gd2r7iqwak8lWeuaih+HJTHpSw+YNujjEjE3ZaIMDYJA27WkkLr9w4Zf4q6jfXoYnYSI
         EZBj8yscWZ3tZ2USO4mfnx/TRwCfIFxz0P743LwAGQf+lflWHGAfYbZl+7AOFSUKIKXV
         7hkZJHAPN6pp5Jibe7Yk/r0FMEksoUDl+BeI/8XwvjC9x0LhLCD9faG8IAYELCtYQyue
         Qkafx9irZ0sWJv3Zeogf0EAuN3FVgaFqpLwqeIVhEHiEZLRROkERFu1NFmDLLnojx6Si
         u6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/+s0MdSWUXe86L+pCM7Jz2A1bGGprArKScBEIupSKzU=;
        b=EBToddazLaOTi7UJ8exFYaFOknWNIDaiIeGeZqGs7NOefv5iFdILzqSaBg/uV3GaiZ
         Fjoa4fkgW8/8GVckf3s+onEXdECr+jwzvxlPeHurJe1JUMRw3cKh4KZqxneYyOXV0HoQ
         kq3TBVusEZhRGycaO4ung/7+RWrVbqBouUWZY0mUn6JjQECg9ePBJN0Sxd0XdBbOSTjy
         CZ5USyAHJUpu8Or9opv56R+kOR8msTOBSaBF5Ar64VWMjQ2rKr6TfNuGqZdpnmIl8JdX
         4DF/Dn0TSIAF/JKTR3m7CUUDlZ0o8dLQDFuzx1hNRAfcoO786cx/7ULiXT51FJyyNzbz
         CFfQ==
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
Subject: [PATCH v2 19/75] staging: ks7010: Remove trailing _t from 'struct fh_parms_t'.
Date: Fri, 30 Mar 2018 23:07:59 -0700
Message-Id: <20180331060855.9452-19-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:znfFozGSEQWFk7RX1zK+EdOW0PWF5GDEC5FPmc6jqiMBDfNwiaV
 me+754ZUHS0zaJ8OQLIQXvO0RzYoAPQzTXu/VQv0x07LTVCdesE9kfoAYB0MbXnTVH1Yad0
 r7/x0pU7/8X5lxk89hSiiimSS1hT3+WS8e3sLpHOJ5lgBcmvgjiNKSLzSsyCaloRNXQsAcS
 R/Ugk+az1AGMiQsxX6ldQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SW6d6ACc5DE=:giCF7iWA5dyzcBR/ccvXBS
 lRXKe+TKGfBTqlKX0on9Vep1Ba6yj9wNt/Ij6+y97zANWTg9V70RcUUELpVgXAQWYxAmuFXwJ
 aMO6uhdwHYId/kY1oAU+0VQ+5qG+PzmQQQ2FufOEH7wXURHu4rdQK+vFMenSQ8qVb1y24ZdG3
 uwBuHBi5A2+/mfiY1iA7P1+tVsvQ2IjokZgK1FfHAAk0TR29wgLHLFfZYGTI5xJ2J7Z3O5S6U
 UrHkviBXfVCQMtYJgyCNQ2CB1bRkjx4/mf1GDtrgcQ0kAxGzmPvKJ1iYfLDhbImIRTgCZ73tO
 1J8Si6M5DhQ4RyZQVPURFTqoTtv1woQsfuQjNuzva0YYxt4tOSQyaHPdihvjMfZZTk9XA4rPw
 KhqQUpM11C0SyRRYhRLqiS7R6FvKFZ3qhKhQJ+ogMeJQpCM5wYI3QO08BKU2tMgige1b/PWAp
 BNaFrVKX/prb/BfgA+Ya4QIUEgjMgVTUeN+aOwdcsfrKG6ezXGm96OOv2xKvy+z9fa1E+/VvT
 azmZ7EMm1f6k/lwnjk2uSJ5bXrYBEabX7L37snQ+a8MVkDi9HHfxvWrksFsYz1HIRkVGz3FEW
 graN5P3muxYPicY8l/BsXrsidD6cx6mfklohul5zv6iZJRYluugUYk0ra53KT8DWIPPiuBCK+
 YhfFmS5JeV8hNgUo2zqYIny+sYZkn+gm0So3oHD3fO3Pvcq+MuF95fgmJ+1ApQdyIjPfDdKbT
 OgpLkyYDOmp89tYTYG32yB7JKyzHIXdgVKuk7g==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432401657041057?=
X-GMAIL-MSGID: =?utf-8?q?1596432401657041057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct fh_parms_t' with 'struct fh_parms'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 6ce5d32718b8..384292588afe 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -209,7 +209,7 @@ struct rate_set8 {
 	u8 rate_pad;
 } __packed;
 
-struct fh_parms_t {
+struct fh_parms {
 	__le16 dwell_time;
 	u8 hop_set;
 	u8 hop_pattern;
@@ -271,7 +271,7 @@ struct link_ap_info_t {
 	__le16 beacon_period;	/* +10 */
 	__le16 capability;	/* +12 */
 	struct rate_set8 rate_set;	/* +14 */
-	struct fh_parms_t fh_parameter;	/* +24 */
+	struct fh_parms fh_parameter;	/* +24 */
 	struct ds_parms_t ds_parameter;	/* +29 */
 	struct cf_parms_t cf_parameter;	/* +30 */
 	struct ibss_parms_t ibss_parameter;	/* +36 */
-- 
2.16.3
