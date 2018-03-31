Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49IlqDMl/9qrS0a31ei1WkHawvldCp8ABef+rB6wrFTyNF3X9erv/cI0P+R14JArupcFIPB
ARC-Seal: i=1; a=rsa-sha256; t=1522476570; cv=none;
        d=google.com; s=arc-20160816;
        b=NgShQBhqOvoXBlEr4h0AytDjPxRTc7m4FhXipYu5g++GDBA4p++aekMdGnnN0Tp4vr
         fM1I0v73EJWRQh9eG52JmsPEL4RYWb5X3ECxhpKa62h29f1djZ6LQB2LzaV8v0fEpLDb
         7yZfX8D8OJyvbmk9KjczuwLFBlGU65wYPt3glcC/Tu3aoLAc0zSIrTag6BLJMK0AlDpP
         e+s8ZBAlZqKVjGeUOvoBvjW8qSWM+1S99TZIQN5Q8dCAEwOyRrzqLgXY5mVhVHvOz69e
         jRhxU1vepMEFnM0DI/Rb2xZXvxpfKCMvEmiWfxVUgEIRdlaiXoT7xpHxa93DXpTQzhks
         908Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=o6KboGscZK8MW+moUQsYtvU3BPFVlk33Mu6JM72RSTE=;
        b=W31ZezqWecFE3TXYQQvOkw/xieObRzNp4f6/nb5vNWm+MBoMz8/CTqGlN0CUds2c++
         OS85udyze9aLXxsZrFhOPvPvYJ/ubFMcfGqP/9FB0NV9A3H02Q1E/IiejqwEhfZlclGQ
         fB3mU3scRooCOxcWbhRahvvBpEv1cBRzVDMqgP8qNM7JGnSuq73hWUzKNWsivXwX8tp0
         QYgUvgOeHQbWJsVr2+UN+uONVBMP8j0eGIqh8kX6lkAFy5X6fTtzQ/T+M1o1kVFD4Auu
         3t3Ibsu7JOgpKo4RiAmKE8oQ6z0THKzuvoUkKP+lg8O84ujJ/LVOUdRDzQp4duR9e36W
         kqvQ==
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
Subject: [PATCH v2 09/75] staging: ks7010: Remove trailing _t from 'struct hostif_mib_value_t'.
Date: Fri, 30 Mar 2018 23:07:49 -0700
Message-Id: <20180331060855.9452-9-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:/heFCqVS18L5UBw67ZXa3P63XxwQTrTvenbI4zHpELzYzRCmi3Y
 AvGrSkw2FZsVxhHslqwus86sp264cKzbyKev1+YZI+49dvavlH23vCi7f5GkA5D9MwGuHUn
 koP7SNGdwdH40vm4fTB6LcmT2BruyfmJLE65mEe9ePmnTu09lrMW/iLt9/sq67u9Iy9kzBg
 jzU2BFcxRuRkZRzMCq+RA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:12TCszCCugU=:zx+EAZbvMfgud/D0Fb4IkA
 LZSgA/vSEccUfc257Arc/XwuLcrgRVRNK2miExnJENamYCJUvCAaNPvzsxm94tn4dxZ93NFSN
 EemikXASa6CHct2QAeDimPM4SdW54MICVYTh4C2jdZOrBKlYwKe5uFeM8LrJvTACspUKQVZsR
 siaaK4SNq0lxN/jDcrnxxcTPawhsVY0bRhnMv+dw/cjgBg6WtytB7IDI4/1+ZBYrg3kpB7VEy
 p//BldyW641IxnWLaEG9ou1W3CBCgKJQIUqULcrS7ZAO0yG8BF0RNuQ19g8EXoEfh3vZGEQLG
 ax2rLQbRZAnDchwmehd5sVWZvWyIvz+WOxpkx5dpJq1kYDxBp0M2D1D2WVQTYm0Zh9s/UIixA
 FdalBHMJfq/v0OuPfZbDaVNRLwFN5DIL3i2LQt6XYIHL8OKKvTMzTQpc3YHSOC4J0MDhkb89X
 IfMfHUIYgnITwhr7vAyrEoxpktCmIycbX5nAoUS1n4i41Me/KYOEyedZKvCrAkdyuCeTQeWLv
 bUE3DuJ0JsvEqL6J1uUq+lC39z0jmumaU/JNqzXflq2tuU8bqi25KqLkhzIc1M1jpeMx9jVcl
 p78CT9PV/QWiaZ8pXv8P/6USUHxU7jXIfUHMVciBrhMuai72jhRCyaQdkHz29Yjv7LjJmPtNk
 bfFfB2MIXGqRyOUbNZCTzLYG9hlbEt9Qr8ksBoYMQimz4tVNV9yOqoCR7mifrBJyRAxozg4Oe
 pUyg8aU+H+oySxVXTPU/p0VJNotlRkUaxQCdyg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432392493658490?=
X-GMAIL-MSGID: =?utf-8?q?1596432392493658490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_mib_value_t' with 'struct
hostif_mib_value'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 0c2771861096..aedc832bc04c 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -140,7 +140,7 @@ struct hostif_mib_get_request {
 	__le32 mib_attribute;
 } __packed;
 
-struct hostif_mib_value_t {
+struct hostif_mib_value {
 	__le16 size;
 	__le16 type;
 #define MIB_VALUE_TYPE_NULL     0
@@ -159,13 +159,13 @@ struct hostif_mib_get_confirm_t {
 #define MIB_READ_ONLY  2
 #define MIB_WRITE_ONLY 3
 	__le32 mib_attribute;
-	struct hostif_mib_value_t mib_value;
+	struct hostif_mib_value mib_value;
 } __packed;
 
 struct hostif_mib_set_request_t {
 	struct hostif_hdr header;
 	__le32 mib_attribute;
-	struct hostif_mib_value_t mib_value;
+	struct hostif_mib_value mib_value;
 } __packed;
 
 struct hostif_mib_set_confirm_t {
-- 
2.16.3
