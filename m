Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48zWwEd1i84uEHq7HiyfG7b4a938LCO6Gq0zVSYtw4zohonsfAq68imEMqGX2BS1HFmDzZH
ARC-Seal: i=1; a=rsa-sha256; t=1522393775; cv=none;
        d=google.com; s=arc-20160816;
        b=JJJ5AQZJZVk1//pHI1HJeKBZ5cROyRXuvZOqVVeD5S24lC9ek3jFIaiWF+ZAjMnYGS
         oqXvLWw+bYRSHQ4F9UM91QMmAZgvU+89fRhqxu87NWA7tvyDVB3PKVWg2PumjthT+wjy
         EBg94Ilfk/y5T7dS0V7h4AJ/e1yKadtMz73ahkgxCxZe1bLzKlnHT3dbVyAJN2GljZyd
         ExSPWC1e5Xead8ohKpjPpzTKy552rf5I6rg9+k/h6bTdslVRlXTuXgg+gwudktbGAV+3
         e5GhEcRXuxXAOj+fsf/HFVR4oxzuhcN7CdHBGvkHaJcgHPHfnxr0PPtpFM91QL0gI6vV
         AZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=L23TfUQxsaM9IcqAUBrOP9qXsk1DvsnPa2MsVNSAUx0=;
        b=KohxVYMkCYNDEy/if1GECA3NZ+huY9WcrWE7ZPjUVKPZlGQ1KRMx2j2mLll1G1kJOA
         LjVa/BMJV5Dx4roB4UY5MaS7gOZyI+3sbLBmothXLFaKjt8nXwTRpvhhxuDQTP2uKPHE
         wKte/rB5/ME5DuzvslBuzaGVX8IjAkQLTnweZksJ+MurwTAVMa/XFy8169pp2tUp9/HG
         bvD/fvBA3OeiF38r32bG5oerspIksKkRIOZE7h3D81Q/3u/dLMi1R4TsMFWwkgtZRGzT
         DS43hoh9zE7652bsL0NK1hKLjq6VDtzRksEI1jOZOKhd/z0VxCgmLkmsmcXR/qRQjkUA
         XNeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 43/76] staging: ks7010: Remove trailing _t from 'struct hostif_bss_scan_request_t'.
Date: Fri, 30 Mar 2018 00:08:06 -0700
Message-Id: <20180330070842.25224-43-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:1LtW1JvSxz89fSG0Otq3pnctb3/bb2F2z22L8QgTlH2x4jrRG+Y
 zhjGCLfuFSmNgt4JsKU1NDXChqP2WOP3K/uoRSJlkUP3ch3fNn15wYs1ipiyZt42O0ZLMqn
 TVEXZTIB9EYsSstEdhLKNy+qsSGd4Dsb+9oN6vD+zeqaSdbfjx2B3RsrZZ5j9XTumbMbRgx
 DuQn0/B/+tY90+KAIh24w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:udfjfMsOAtc=:hQo6X/EIY2I0GPEs97NGdR
 RV1MCZ+PueYiRdMw/zrv1wCrv1uHTOxLB39/FCotJpvPkAZ06+O8qOH2kz2ASj7nERxDPrXcW
 yDa6U82K0QK/iT+xYkJZyrK0hq0a7zix5cKXTnFIS0RPyjiiTdUcl1cQ8d4tCWw0SsCxuffge
 FX4hIGIr9ccDdmTJj4JpNn0EPx3mDCt3v8nvh5TewzPhJ8w651CgL8t3kGb6R0jhp1eyZtp2Y
 WbOElXZeyQNb//1LTM6m2p23uuavoIyVxwPihdfiv8Lz2MdM1RXDiiAmL5S7B5Jy3g4fubDH1
 ObsnEuqyCTUh8lcho/UY0EXR6lNMhRkx2rCXFeD4CShBzroP7ii9dp8HVuGWAi6dDrymb64oN
 sAoXntoMdn8+uNSaMWhrg/MgBRimlc8elt16uDmaI+V57M33qxZSRMsZt1bTPsekKw+J3KVwr
 X9201gRO/nduOW9PhE6vAh+ccXmF4iA8aP9Yy9/8vBfMkUvbsAPWw5+KSI+wuMqnrQTo8p7xe
 yq8rJiv7hzpxGEq7WbY8CR4v3QmRnulG7XoXtkl8Y3Gy5gSpXhxf8rXmwFfmI9B+wGN3yx7UG
 PgrUaoO6g8vHCl5meJG2siRzE/Y4O4+HgAtzOk12Q6UbHLB8p/ViHwNrSj/KpXlv8Fvdmgb4X
 YB628Or86w4x0HB0fZlvKt52vkuk3g+Ulv9m1yi5XS6jB6KvIVlrzvGlJ7l9mBghWPYc7wy2m
 kVH1p1r+G0djAx00YfxWMykF9k91cgVXHm9iSw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345575491157872?=
X-GMAIL-MSGID: =?utf-8?q?1596345575491157872?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_bss_scan_request_t' with 'struct
hostif_bss_scan_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index e733a77269df..aa827949db7e 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1508,7 +1508,7 @@ void hostif_bss_scan_request(struct ks_wlan_private *priv,
 			     unsigned long scan_type, uint8_t *scan_ssid,
 			     uint8_t scan_ssid_len)
 {
-	struct hostif_bss_scan_request_t *pp;
+	struct hostif_bss_scan_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_SCAN_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 81f12b41830e..23ed10674162 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -460,7 +460,7 @@ struct hostif_associate_indication {
 	/* reqIEs data *//* respIEs data */
 } __packed;
 
-struct hostif_bss_scan_request_t {
+struct hostif_bss_scan_request {
 	struct hostif_hdr header;
 	u8 scan_type;
 #define ACTIVE_SCAN  0
-- 
2.16.3
