Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49TLupGVZqm/rhXJA+yF0EkPHK044A/QymS6ruSYLlM7J3Sp5uMfdkfTcmrXJCqlL9IG8UU
ARC-Seal: i=1; a=rsa-sha256; t=1522393759; cv=none;
        d=google.com; s=arc-20160816;
        b=F7Krw8m8WTYhb+qQogWIn9iV6ETdKCIG5gsnwt4W1jAUF2XFAyx9FugJ4EUtspAFIk
         GtwICudVxhedEv+dSzEHqIgTdH0EYf6Fxf71vIWBslFMAl7UOSdgTXfFSCIKttplB9O6
         /YCiFNhiauwTM6ER+RNwrD9R8pvS7pBv+nzGpmy37aQ0x44CrpTJZNTqiuWYo1ZyuHSt
         rleeni0Cn5rEcrBoDbhVFbwyokMtlDVy7USU8HIDf2M9Qnqh0ST72k63HqvvjErcj65D
         H6jEEwiO77qZm9oHnkNflsvgWmUlU0niuTkeWOgJGfcWM9OOoeiwCllJ2CYPxbzMWeMw
         nqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=aHNhYr3BGvEFZ0thsm7q+jL/f+WFQYUwn2EWVSF1WNA=;
        b=FVUAduf+HCDezMYUJRSk1v7oePSf3x/fOl3SKc5R+ax6xrb1bNfGfWyH4UbGJ9QTBK
         Y/w2eZKw/KZDMV0Ap+8rJHFyEmMe4z1pWG6owDrMTTaza9BxdsOYdPg8OaLgN1bfav8H
         zWsR/tHXHC+90I/tl+UNd5+sF1X4m02i8xadSgT6al7cdRTIh5pEEcBFfecccMNTaHYY
         vsGUWQr3pNNeKdUBMjdUvyak2qEUREdkNPDNGrQ7q+tlc7vMWOsGY+GrVh6/bcYK6Gwc
         tNBR9M9eqEV02QY7sgN4uMdRa4aHx9FAR6S3XPSSxMVJRYEQVnakwk+0l9EVdtkeHehx
         8Ccg==
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
Subject: [PATCH 24/76] staging: ks7010: Remove trailing _t from 'struct erp_params_t'.
Date: Fri, 30 Mar 2018 00:07:47 -0700
Message-Id: <20180330070842.25224-24-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:WPTy3LAvlo4lcgaV6/QrYk0GLQduq0GdThQBJT9z1KAoG4bH0mP
 qXFMCjUz9D8UeS1HrBkfQTSBVeHt8IrLYut7fVDv205AYIpgCMOVJddqJTjAvedzT9crKZC
 V1I/hPUiBkiB8C9NKxO4qNRw1L5pJE+62+CCRfyg5kpFPWo9TxBJffNxKHo6sQZDg/ZY0tG
 dpo/QxbwlgxKeqbEUblWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N9zv43kpC0g=:RO2YfBGoPeowuw0dxoLS8A
 sy5gV93MA1zgtiIVpNFw+v7xBJjeV+pWpS0PMZrfoK1m5S/SrQGC+AGAevBx4FtiSyL+hFuZ9
 x0obt/dfD4mGx/Vhz0oiYkAup/oYRFFiIHLzE5Gn+hVAP2ZeWkEw47T/NGPytYC0x/8kJ8fbR
 XxbSx1tXRwtO6xNcVN3i+Kvc7YUkmJSpDokR+6oQtNf9Su9FPUaN9y4d4qing32t7/FgpzBWC
 glFQAUZ/tE381gvSZ+9mHJ6igGup98uodEb4JxDT1Kirmh+MrQWCTiinC7r5aqiHhqq+KuIvq
 afS1DCrYhQav2Z+keBlgCTNrorQtFKB1+Z8xuqGNTKh0iusR6J26u8SwSUT0Ikr+NfAxBHYO5
 XOL+d528b+GQ3PX2hLe9XOJzqI6Zc8FAEf48GspG5EegITsorSZHS2UCfS0I4LJmakFP93mZk
 bLnX6KE2UIF8VoncdjTDm5T/5pVY9J3SGBtFMdeKn2l5gTM1/BqKxgYj3g99FqtGB/O0DzcfL
 UAXWg1bRVOnc93h8k8n4Sov8TcGhdsQFiDvpdiuzYUuRUfC1hYeiIVxIIoF+wl0l80ZEMiEVO
 jgRYf0T8V/o5QGL5t6PncghNgbzhYp+XXA2MPX15/V5C8o0bOU7I4PraPCLq+Oi5uq9JrzAxk
 P1OZFjQ38NGizo/CvzymauBLg1DLDyK8MZfuMNV6Z6CsgTbk3I5eq6xXSVUQAXhk5ONCXo7gR
 u7iMQaNJADysIGuO9OuO5hkTi2Smtt+0kbHSMA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345558996681411?=
X-GMAIL-MSGID: =?utf-8?q?1596345558996681411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct erp_params_t' with 'struct erp_params'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 548ad0e8a5f0..4d25801ab38e 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -266,7 +266,7 @@ struct rsn {
 	u8 body[RSN_BODY_SIZE];
 } __packed;
 
-struct erp_params_t {
+struct erp_params {
 	u8 erp_info;
 } __packed;
 
@@ -304,7 +304,7 @@ struct link_ap_info_t {
 	struct ds_parms ds_parameter;	/* +29 */
 	struct cf_parms cf_parameter;	/* +30 */
 	struct ibss_parms ibss_parameter;	/* +36 */
-	struct erp_params_t erp_parameter;	/* +38 */
+	struct erp_params erp_parameter;	/* +38 */
 	u8 pad1;	/* +39 */
 	struct rate_set8 ext_rate_set;	/* +40 */
 	u8 DTIM_period;	/* +50 */
-- 
2.16.3
