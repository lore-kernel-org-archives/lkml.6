Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+wtXhd0li7O05PRPgV4o2ZPZ9FevZgx+lRDM2SfZayAkGsVFB/HnsaiwH2z8fyVRhXepwX
ARC-Seal: i=1; a=rsa-sha256; t=1522393757; cv=none;
        d=google.com; s=arc-20160816;
        b=gGnrMz6xmsYFNiI+iE2RbguxRk6dedB0rNqYBgtjH6FP/I0IlrpiovwY+I00j2oTEH
         jNGY72C7aXKWXTvnNx0widS30xs5dT8vyUbw6NlINitgL6xfQ5hA+8MwywWhs8mzwZJM
         +2gKPC52Nr1DwknZE+qk2JuiyndlN8yvWStAZpBxDIt2jzHhg04S0THAgsDDuoTAhty2
         UC6mszHvRntBPSjEoPIASfWLiKVnCo27ZyFVu7B+q7lKcRtRU1afLrgfj1IWdGyFYVkg
         hwwplTiWSfOsgzRD+HnsTZI4zZLfJmTCD3jZvKD8xkETinbl85o7oes80z6H4vQYV+h6
         afdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=u5iKhbWc/iw4/nzmM9j5dqAWL+vbJfLBr8ZHUK9RzHE=;
        b=K1y2BYEUQg8bDPgPJ5YIxRfC6yz4Vx6SlP/u3MTXgdq5gaYaM/wpWu30E8yUbMbof0
         9lCblCbN7ZWyeraufb0+ARivx66dPvrWqnDMLGb8629lgK+LZGRJER1AW/dm6nAdevim
         1pT+eU+iIu0e7W+zEuH8bpHmEQ2rugdRTu7AFQmtuL9CfHarluQDEX/hTXlgx1OxQhzj
         bsJVhckJB5Tf5xt7dounL43cpNvzUPg1l+PJW/Dgs4gEgMoFdqJM5QVg7iRxG3bPeFAf
         H+TL1Jo7y1I4SQbHGm/Ng+AoDPbE3bYN9zgxv8kmKJFEGUnqEa5arFTeWAvCDu87iTy5
         EBvw==
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
Subject: [PATCH 22/76] staging: ks7010: Remove trailing _t from 'struct ibss_parms_t'.
Date: Fri, 30 Mar 2018 00:07:45 -0700
Message-Id: <20180330070842.25224-22-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:5vRgfILJdZUH/A58uQ+FhsIkWJ44hw3v7VSRTYIXwbimVrdKwXl
 SzshC90fad7MOtWyGIjmHVLpePlO6Lb5GR+bloVZlVKTe6lClR31khiXihARz+02uQzVsKM
 BrAvZuPVqK5epbOYjV1iBJ8//UwA+bBOnNfIp01b1x4cvNP/7Qp7bb8rWuTb2R6IOtTmj5U
 4ZV+QrpBeh6yT+5gbq5dg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mJ8gIwjUvK4=:6U8Q5nN8kfnIU03jFWnANf
 eUKaynLNn61+EK3N+2MjvVSNXLWahYD2Igf1Vez2h+UMrDsxctWzZFg5G6oxtoTBr2LUB4PvR
 pg/k+O0HP1yr1dWyP3qGBib+bI5gHEKkVU2PJ5A3DzIHIXp7WWR+K8VV0vUWeJUvX8XYKiNc1
 LqkTgYRhH5UEBw8erZpqb+OAARmZoQj5QVSTYF/P96ZcIWE03R7eQCwSvm6g1y96Wtnsryg4I
 GYw4hqKIURfaIdWTVPTJBTLfhiW8flSsu3FmGoxj5154qXxUvtaood+k/SxDQ71ENf3Ssp3GY
 zqzhmqHoeTEjnFOPu3fMLURucHCqYNYL3tzfr3vv9EYHn2I36Y7idiNY2nFX1vb6gEv2g1qGB
 sw1s20viw8r6KhOBguAKQRsbx/FUhhfksB2uagEZv2YBHArdRe8Tk3YP1be0yKnq8dv+iwTsn
 YD18ZcDh7e/5gcuE6DeQhBvpiA1LRfOng97gKRy0F/kJlNKmmV9Pbytz6FZPLjcfw5wSW3hGC
 v4P4X2DecXoJuzViafxoGmknhrwNPx51uJuvtfzX6CafpBP9PPe09GJHZI1zcSxsXDTLpNO6i
 prMswNVCG0F6vUlaNjBBshZDZfWk4AiG5W+By7UQvTvppgNvlb+nijJUZ4+a5OSctso8+qgVW
 Hq8ETHhfz4zVbsR2i9hvUV3Hw73gDv085XMsqBd7jQPvZkjwHDWU1pJZqnSTo31wX7n1zTbV7
 xAXJfR6ViEEx9ufDg1cQ6xgBgye9c3bN3OJKrg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345557100254652?=
X-GMAIL-MSGID: =?utf-8?q?1596345557100254652?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct ibss_parms_t' with 'struct ibss_parms'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index f4e7500c07db..8a203d759aa1 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -256,7 +256,7 @@ struct cf_parms {
 	__le16 dur_remaining;
 } __packed;
 
-struct ibss_parms_t {
+struct ibss_parms {
 	__le16 atim_window;
 } __packed;
 
@@ -303,7 +303,7 @@ struct link_ap_info_t {
 	struct fh_parms fh_parameter;	/* +24 */
 	struct ds_parms ds_parameter;	/* +29 */
 	struct cf_parms cf_parameter;	/* +30 */
-	struct ibss_parms_t ibss_parameter;	/* +36 */
+	struct ibss_parms ibss_parameter;	/* +36 */
 	struct erp_params_t erp_parameter;	/* +38 */
 	u8 pad1;	/* +39 */
 	struct rate_set8 ext_rate_set;	/* +40 */
-- 
2.16.3
