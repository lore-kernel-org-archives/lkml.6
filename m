Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+gLJOH80t6eitcSz4VD80uQPriHi7sb/IRxTbfBAV9n/Atu4UA1kkMJjUWjFPxKnwdohww
ARC-Seal: i=1; a=rsa-sha256; t=1522140086; cv=none;
        d=google.com; s=arc-20160816;
        b=pQofeL40d1AsjjeJCBOl1bqI6oDwtLmBHxPHIqUi3SfH8ByXJ5JyyKJjVJRPWqbciO
         WQmeTA9g+7f3ep20wmbzmXhdUk/sH4+hmXaP5Ah3OzJXBDGIhK0v9LYJ7I30+kntwzxO
         8fhF14FEBHgfJT1x1qYpFjtNaY9AAKNed3ewyiIUmGAXieI4gn9nvE5yZeNZzVf+UWrO
         L0sOLRZiWlqLULFEP9ra+N5ovniRoRFQ1xucV900Bfa6FM0ZGV8EqQgQJuUiaupjawQp
         //cp20zCOmrKf2MZl3MDbo9gCheV8DIFXBc1I0FZzcARunBDBMUGh8e6V5P9Zxml30J/
         qJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=FeOHwyQZY8uEoHd8jZNwZbztlmvJCxYi33T1qJVcMt0=;
        b=EQlCWgPZtZa9lsGjEvFK2jHshYIxWQezTwx38S+9+eszo/pTf39RosNI3DhblnCLX0
         Ws9inRYgMjGHmgauM60sI0JnmHfnQo8/ejf909kgT3BuJYsKZdhOHSFUbO1jNXk6u5Gk
         l7uuZGgx4IkFH+t+qC8BLVer1bBhrLQMiOOpkQHlQUpuCQOYFCrjynEPEOozDJcM6yo4
         lu/5/W6UZucrtsRCr97p1+AuECt6ApfedPQp9kfU+IliQWYLk28WH27JE1LrUEDtWCjO
         zPcFGzMHkObYkKO1Kc4Vg6nuVWkmGEU5inNVq0FT2AspbwSp+z0cgMS4UKdShsAyBIQD
         fs4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 01/23] staging: rtl8723bs: Remove duplicate #defines.
Date: Tue, 27 Mar 2018 01:40:53 -0700
Message-Id: <20180327084115.16129-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
X-Provags-ID: V03:K0:owMdyOPufaCURwes2IISOoLSTGegPUOwfYjwkipxKWzS3hKAsQg
 MJwSX92zGxhiQVOrasHTrWwgi7LJEvnmO7L+vBHz+G69xesMgEYdI7UcG2hBTeXwiVOa/IS
 Fx3el4g3xDd+/5dU9tXS3HuJVPCkss9wl9irFPm1HPecEdArVXbysoi5gFbqlQ/Oxk2D0Gi
 oBrAaCJ3ucIivFmtQRh3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rJq63+bSMes=:vsG2tY4Cv1qUuuuL2aZzTP
 caTpVVsCQeqaY3JThpPHyfFdZDDxp1lBqs1gcgIiW2bsE7kXCkSy566N887D6nZdh1UvrN1kn
 zLVRbaQ6G/bWRmo+PjDOhIYp2MZXyEn05unqweaVQ6/loVmM2rPQ9NNL8D/W2kfR9F1MWBh4y
 V67cixKJa6Hk2xumsTC1l5g0L3CTanrc6dAY54PbsADMaYtwssu4bfPVUpXEih4wm18BAVXD5
 7VzHqWWD7vIfLUmTL31bL4B+1riL5KgbEapB0KgApYJrfXOtbjTvRG1am48sQu8Rb0kTgfbei
 L2G6vla3PC9hKWznLEg/YHXiF/sR6KzBTuVUVG/L1Dnn7i2i/IBNw+6gxKvqDE+KguVx4Z2Ej
 F0xdJ8DsevigaD9anB3V1EpR+60I0klfkOg/C7UFCfBDRdHhxeULytp43vdHkMZL1bt9m8vJs
 NGKbd/0YObRmU4TGBA94XEgh26AgA2wu/2AM93J+Mh0FOnznY54k50u3Sy33RUecbtAk5ErSp
 hJM4AV19oZJFv3Cno4O7dRGGTJL/xal+U4LkvaRv+OM4qFlfbbQBEcCHcdUamHXMruxnFf4IH
 Uw09did7/0Ra/6dFgcI8PI+B72xDv+86hV42tRacV/ThaIC/zpLB7XmZkdIZTChYWWDptj+vg
 Nqpb3zk9NXJ78vaibKwvB6k4CpUCyIfQcPseNpUzUwkEc6haRc21psmZhfgiSey6xQby/GkVA
 TiZtwBWu6stAlUu2gFHzM96UYshklr5UsK/s3w==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595991322054206590?=
X-GMAIL-MSGID: =?utf-8?q?1596079563228110092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The modified file includes 'linux/ieee80211.h', but redefines many
constants that already exist in the header.  This will create a conflict
if the values are ever changed in the kernel.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 73ce63770c3c..a2402495f447 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -435,19 +435,7 @@ struct ieee80211_snap_hdr {
 #define WLAN_GET_SEQ_SEQ(seq)  ((seq) & RTW_IEEE80211_SCTL_SEQ)
 
 /* Authentication algorithms */
-#define WLAN_AUTH_OPEN 0
-#define WLAN_AUTH_SHARED_KEY 1
-
-#define WLAN_AUTH_CHALLENGE_LEN 128
-
 #define WLAN_CAPABILITY_BSS (1<<0)
-#define WLAN_CAPABILITY_IBSS (1<<1)
-#define WLAN_CAPABILITY_CF_POLLABLE (1<<2)
-#define WLAN_CAPABILITY_CF_POLL_REQUEST (1<<3)
-#define WLAN_CAPABILITY_PRIVACY (1<<4)
-#define WLAN_CAPABILITY_SHORT_PREAMBLE (1<<5)
-#define WLAN_CAPABILITY_PBCC (1<<6)
-#define WLAN_CAPABILITY_CHANNEL_AGILITY (1<<7)
 #define WLAN_CAPABILITY_SHORT_SLOT (1<<10)
 
 /* Status codes */
-- 
2.16.3
