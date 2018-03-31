Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48EtDbmQSXgfPz7fcbpzkRSS18DkZoQ7+S4OL9ZCtRdPVdmlPPxJ9ItMIvoS2vKhCk6DySo
ARC-Seal: i=1; a=rsa-sha256; t=1522476619; cv=none;
        d=google.com; s=arc-20160816;
        b=QhLcla9Cv/QHVAkFmhtx85pSSbowS/rraCX58NK3BEBjaQS3hhrfrbSVtcfQIxv7iK
         Lv5Fu8lngvIPCZKqKKZ3DU+QBmiJsAtek5EZ62DMP4bW4wHzRnwsdwvMtCofnBpvRTaY
         nnZCkxkjF1P40kw3f79y0WHzV2eljuWjGv811aat+r/d3F6CHpI5jo8flBYjfwQ1Nwpc
         bOwtIYlqkgFzFa2qQMaOWSGTeprjashU2XzlcPsfE9fGeFftiiExJaMt9Y4tnOYbXr7w
         yyR4QegSKZ06XZXfZcdFiNMjb+uu1cBMU1EFsdUpc6b4EdnLgr0wRp7bDkHRTjGZA4WK
         PEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GmZ+IiSmHpZxUJROUIhLrryvqeE3iD+ogGdQwSp6oOg=;
        b=XXVNPYGLvu/VsMnzEryqWgRexbAwBPkPECf8P4Q2EDURfvkMbe40SvxrTzef0UDdgN
         XkZZaSXbgNt8Uh77DwQU3NpTf9zJuQO03u4SVWijJau3Ek+bCFNEb7C0LdtVMb+e+U1b
         8jbqEVfK8mOEWgEqoGSWv6BXHSpOa+3MI0qfytJfc57QMkVI5bAiznnjI5K5ZoAcs3NE
         4LAEKV8w6Nb0HHvqQK/IE5L6xjc8mNgJloTDTjI6KF4PRAexzeohGLSPkQfsLXUox4yZ
         UEP77Kq9+fsZqwECLSKgwJ7HceYAdd3lfOsIn0us+YIoAPxpr11Gw3M0zm8gmPS5zOzj
         1wlg==
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
Subject: [PATCH v2 64/75] staging: ks7010: Remove trailing _t from 'struct pmk_list_t'.
Date: Fri, 30 Mar 2018 23:08:44 -0700
Message-Id: <20180331060855.9452-64-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:u6VGPI5Dc+zabEYAQpef214GnoSWrEAFW0rNEwAnbQ2JIiHlh3J
 tGMSWhBI5+BkGbJt3mtvcBHiIwPvkRkjQsC6k7eDsYidL2Tz4uICWFopEHva4mTVYU8Pc13
 Ax/jXN1xBV83Jb3iYUNsz9nNiTVT8wHOCIyrOyLsEQHjwHc3SgCFD6QSu7X/oa87UvbZIHV
 ijlGXS/SFNb4yrJAEpHZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EphjYjkoLj8=:H7UbVR1gEj5YZL0WrccdEt
 e2ojS3Giu7r1B/wFX67+0E5xzZLvdWkrIMGEUfsi8SMjfPsxiCuznBFjj/q6Pil+uuIMN+kzp
 7rApVWuMDnK9659ciJ1qZAor3Ll9xT+hUuJRJIHRLX8jtWvyvfcOBiQIbSmq5K5IlL8ph6Zp0
 RDbh2st1QDx76oE2sxNAh+S8dUJ1NSr3ZcJsAtIysYCJdrSEd9drMCvgKX144dHvKxg2jNsd5
 7fsiEXvo8tUvVkiugzNBKRl6BzIYYbsXwTwCxT4YPitxpEpf5m0XWgZJ+oa/AVmpwI/N/DX2r
 cR3otwZMVjOnP1CieTtr73jXf5MfAQSdT/qGFAsCIzmDnNU3ts1RoYRWuirXw6MNPm/kvD8dr
 xY2C5iqdkGxnhwsMYfPKjJd/pjYSrxMxeXIUDVHwuJ/zhUOoE6er6Gk3autads3PO3/xdO6Bj
 d6jGeR9Gp0LYkArftFTVoz1+MdHo+6a4hsYkKYkthgINCCIsMENKXU5wugyf9fy1K/U2uYtSD
 ZF9LCX0DbvR+XxaqnQ9lol/S5hiHC5UuNs9GGWr4jOh6F35s28hqtSyCQliOahLv3L4IEMKQi
 lhe01Le3jrF3eR2syUkV4tIPUn8yRHnEjIJLjHPf5y+WSqzt8WdnJyh8CYCPGIN2QaPR8V/gs
 aKdJBI9X6g42FGISVLQXAlrslm4j3Du2s07pMy3LgPt+rQPf1+HR6KRr8FClF8U1TUEqZaBzW
 13e4fGj13x7vYY6v3AvHNZoc+8sJr9R9/JOm/Z0b1W8D9W+xRDm0CNyc/AdgKJwamCYPykd00
 jLahldSVyMJ24Z2mYq7jiFFzB1MhcmBBC5zlZQvo0dkMtiUQhYJDHHDx9zXZ7Y9kg6OUK0zgk
 R0PB1+zn5W7RpBADYZKC+YZfXfphqKXt1Ubszous1TV0hsKKDMRmJHqp4P11jh
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432444071070070?=
X-GMAIL-MSGID: =?utf-8?q?1596432444071070070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct pmk_list_t' with 'struct pmk_list'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 851721182b05..69eac00e75b1 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -380,7 +380,7 @@ struct wpa_status {
 
 #include <linux/list.h>
 #define PMK_LIST_MAX 8
-struct pmk_list_t {
+struct pmk_list {
 	u16 size;
 	struct list_head head;
 	struct pmk_t {
@@ -428,7 +428,7 @@ struct ks_wlan_private {
 	struct power_save_status psstatus;
 	struct sleep_status sleepstatus;
 	struct wpa_status wpa;
-	struct pmk_list_t pmklist;
+	struct pmk_list pmklist;
 	/* wireless parameter */
 	struct ks_wlan_parameter reg;
 	u8 current_rate;
-- 
2.16.3
