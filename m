Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx482YS9Z7qS+ycyhvy0qVAXKfi+pbM2jNIXr3xrdvBjKtRnIZWQZGIuQyzLZPGG+vl/Xfevc
ARC-Seal: i=1; a=rsa-sha256; t=1522476574; cv=none;
        d=google.com; s=arc-20160816;
        b=rxKnWtADwR6b6e/RAbBpg0XPuPDToBdUka24LrnX6/gEfPe3P7a4RtYz+xKMRGUnLr
         9ZvsEMZxlBzzYaN2OqV47iApMsQcCghsfolo/Fjp9PjBIJrVHcj8xE+btoFUrIOIrG1j
         DcVmmurlPUg3v3d6j/32k/eAzQ8CsjEn1IgkyQsbrzmRLRy8LOt7JbLbhSQ/yB6sGoIA
         aFZjHKcy4Lg9ctTEVebNOFIvqkLTObB4epf3BySyWQ5YPnPyyCTotfnr8jiYNNwUhKvL
         cjFX5HKkIY7HAzTnUR8K0qZpRGRqDCn5O8pBlJTmP8uKcb5UfoYniM8p19UP4OWtdu02
         vCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8FGs/ULbN+ABxl3JUXUMUso167EHo52c5q7eLZx/Zvw=;
        b=Exjglcm6Nn5DNDEc38EAajsQkbgGxEYHenW51jHeFyE9H4MUT3GkbMhECQRefs5hnK
         vZns4APwJ5kS9ZytrPHP4tQamJM2xVSd47Y400syLsOnYW6jVlMGwGTSldSXR8gngA5K
         h4H+qCSFR1r3NHTXAzNv5OE0eOu6ZNB2HfJYIaP7gsTS78MWy+enYNj+BqKLJ2YcSkKY
         5uoL+N8z2GqCVakDyJAPDmo8JRoM4Y7mGpn3/7rA2ac7ejvcVxnxjckKd6k+mZ/fSjYb
         O5qwGkUhqJgbD0yc723q2g1hTCJyLBDOfPo5rWrbF8hPMIAWNJtbE/+0d9K+9A3HtdyK
         5UuA==
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
Subject: [PATCH v2 14/75] staging: ks7010: Remove unused 'struct hostif_power_mgmt_confirm_t'.
Date: Fri, 30 Mar 2018 23:07:54 -0700
Message-Id: <20180331060855.9452-14-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:erlxWWyD+Ux+JVoJYCNGXFfNMK/wGuXr1KU5l1tTU1y99NwQGvh
 5agXTiARNxpc6f7oHaDpbawO4VYqp6ccy7eGs4NqjXeO+nReLJrNaQn5hftoLrMBZ9+jdup
 gU8NgKKTJvuYSCmbW2p0TPw6QxJelyv5+N4BxC2BsShfQNdBUv5CFDvTJzEUNA6ql/NiDbv
 MNFT5qvCPl0sPR4km+Qhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S9eqgd05Xgw=:uCV0B6w/RxDNzF8bgyTgZC
 Vb3mGBT/SHnuLQ1VKprRd3Dmjps2KEc0yf1L2ghct2i8TUvt8PPY0PADbGVLYE7iBdPQoAxnA
 hYBThSEWmzR+j7pTuukEF/OBLbYkkuUjkku0JIgWSl7ems1yUuZ7gJ6WZTBtfpDjT35O3uWx6
 mBh3r0ALhJtrPDwJxxtsMnJz/tOpougxTjHqMfBHYCXqyz0vCgph0vwXzSdwckldJwJ0EWpau
 oMh6qZ0IFzk8m422OUsYPEmiYK8uU4B8DTS3yGeFJJcBcOKM0JauE2noNjk1nVG09d8Md4kof
 BArFfVmidAJXvD/WtGT2U4hOzirdOXPCmMAQxp21rbrxJKI9W5pZYYCfX5ZSuUbhpMVWRnJo0
 eJfYJPYJPrPcLHtn/CQng0RzI9dTCpuVPAXfNrt6mGcsqLcYU3Csm8FT/81c2QxAyLaj9Qthc
 ZP4XvFoy9eGvYEdJQyUbkwzBD53yayXMLbZke4ODMfeEhE3G9KbGCD2sBnrqoaxzqHg1vyUBj
 twkBNnizVm4paiMI4Go2A1o+zlll7hFS3e9sLfLhqrQaEdE4y7amIKbPCV8x1ERN+8FEx+xZs
 ll2D/G6msUDckBr6wtHMoW0EC+cFmMSOpOSuw0MvxmZmVxEqt4YYE83mwOxqn96ofCPyGaN2n
 HPcqt+HQrTwDKEz6CwEB/bRldqK2jJAdDcFwlQMbLHo3w9RnECvRTxiba/Ko0JCzQ5/FcXv4O
 EivCIZ7KqPmni3hUxirfNYuFcCK5nv9/mjIycA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432397275127091?=
X-GMAIL-MSGID: =?utf-8?q?1596432397275127091?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'struct hostif_power_mgmt_confirm_t' is not used in this driver. Remove
'struct hostif_power_mgmt_confirm_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 10842d668afa..245d954e3be2 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -187,11 +187,6 @@ enum power_mgmt_mode_type {
 /* #define	RESULT_ALREADY_RUNNING    3 */
 #define	RESULT_ALREADY_RUNNING    7
 
-struct hostif_power_mgmt_confirm_t {
-	struct hostif_hdr header;
-	__le16 result_code;
-} __packed;
-
 struct hostif_start_request_t {
 	struct hostif_hdr header;
 	__le16 mode;
-- 
2.16.3
