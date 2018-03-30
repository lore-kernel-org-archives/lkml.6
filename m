Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/VOdJtXVNiHBHjF50oJIa8oeYAqyc3I/7yekmqatlUdWaxcqZMl6OvPW8GuCW8LNmOY9Ae
ARC-Seal: i=1; a=rsa-sha256; t=1522393776; cv=none;
        d=google.com; s=arc-20160816;
        b=NzNIGsTWIlbnNg2J32gFAHQCw5iXXcVulZxq+4y0XIi5RI8DcRxyt9gqMB9248ufiQ
         4nEOpFJe1qWMd0OrvOC5dbtaXOsV+qqCa+cPfsLzxL3t/TEix1KNvbd3b2zg/Gi1hAwY
         c+zUJP/4cZ5+7tJXKBPG0vjt7rlQVqbkq2dMH0BKP2uBERTDB/4PdDJEhKdTbP1bFt6j
         AkueWysz/P8ovidpZrMiUIlrNcMt1vPCyQZepviP9hqe7sZw+P4x6XVbKO1wyAFq9gJF
         FoV7fRAzp7ilrEfAphrU+GmLb83BZupOxI9zWAioIzCe6pQDhtJTcL8nd2YMhRwInQeU
         qu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=FDHya6wW5U8Q6mlC1xwn9l+pcPloxFDyzz4+pOOM2yE=;
        b=ho4vFqcUdXDAUI7qAirVMz/Px4Kb6qjEW6lnjISR4qLmCrbxjjJlwyrfDIaI7iaFOW
         IJKBo/wi8nNUaJeIwh1Jwzi7JF/N24i/Nr2u0EOYGMdixx50lp3L8vfdf6P7QBW5hFBf
         8Q8vc5sAfCBHeYTL2zHVx3qPqBrVC8hwtsj6g9wn+06wojzOS9euvE8Fw5eAx3E15POi
         ruDCT7r16yeifI4VZKih8t9WOXFEYGot34bk/5rukYqfFalZFwTdq1TrO7gOnv8YBkZJ
         SONAOra5ZQkueSkP8g9uodU8sX9EY6dRQD2ZEUun17uVVSEFdFrYkWwRX1sd65hZp/yH
         kCfg==
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
Subject: [PATCH 44/76] staging: ks7010: Remove trailing _t from 'struct hostif_bss_scan_confirm_t'.
Date: Fri, 30 Mar 2018 00:08:07 -0700
Message-Id: <20180330070842.25224-44-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:wnshVG+U3G5/JPHDMMrrLzvesmc7WW9oD5oYJXPnS2ka5dftpEj
 I0kwa3tCs5IJlvTXU7AAjaUISLKKb4htsVkXj3zvHXM7UY+ylVZUguQ9Y9XkUztheUu1dnA
 Iil2ahbZGcflVFYvMC4igAVfnw91Hdv+kag86Ew3nnYIrdUjudlckM/CBHN2ZQdR3ANpX83
 MLJfcvwaLnWR2JPI/pQIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rSWc6KosT9o=:8PHdtRZjnvkimxyFib+g5F
 TrI+lFkhK0YO5PoV//WJ/EWOn/+9sgGEVSefZn6qRQ/l4II2gOl8/ty+lgY/ocveH4hF+o+/5
 LVs6AykNyiNnZDw/mD/Dce2of0PsHqXrECsos5aTpx9/FMy8udGriFa9kjtsbTVF2XNowYxoN
 31Uvm+0kdiu0ueoUELR7If4/TKRnqCAp4M9VbCNW51iu8Ia6pTnvr01mYOz0EOXyIGo7fT/w2
 RXtjo8Qe55MmfHj2Wbyxu4YAmKHyXguuNIdIBSNWa9kIq/Keyox4cUi7ARDhZOBZkTxDMNtj4
 p4B+dmCvA61VhBpXZO5GMVhktuzafQH/iuScJCFf0n26iRE3dHSViDRH8uRrxJU0XW12ybE4C
 6eL2jmPYj5IfFrHfBZiFAz1BxG+ddQwzXNYpUrSD0iIkQ/OWpLkIsw791tVP6OOV8hAZmcM28
 AQInPSlAhLJJJwqy05JWLwg2TORf7B7x81VNRuwiUOgvPVLLY+d5kqfiuOjPGURryMOYGWAi6
 GT8luy/f7ooTCZJUgFHbKW+vKwLGtONqiBym+fjmODpYxWn3DINmd0MG0JVsyae684At1Biz1
 BICj+w9FdTQ3B2av5hibC58SUgJX4KLSMiicRI7h6BUjbKkGLWxVS9wgeX/vGrnuR1sAhqWhM
 ZOV+RWq4tFYiu/ubSXFGRsyw9AfWHcFJX5xIpvMIz1EcF1SEPP9f41UsTwE9/6hImk7n0gvWv
 w5l0q64eMbwXOpSEEkjwvKIS1XGuZAOCtujVNXRtS3DaJyO8S/+aFEbLFR2o6y+QxUOXw+L5l
 aOg2wEyJWy/yRmXj8wmkMusdaRVl76iV8cFtcdT6Qz4bdyRLSH4W9bH1N40uIOIds1W5Yywal
 5r7WYFeQo4qHMbzFS1Fwy/W0ydTMYyjz9F55QgtxvCteKmlwYrqfxTu9Mko82I
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345576596292714?=
X-GMAIL-MSGID: =?utf-8?q?1596345576596292714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_bss_scan_confirm_t' with 'struct
hostif_bss_scan_confirm'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 23ed10674162..2c1bfc9e8610 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -472,7 +472,7 @@ struct hostif_bss_scan_request {
 	struct ssid ssid;
 } __packed;
 
-struct hostif_bss_scan_confirm_t {
+struct hostif_bss_scan_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 	__le16 reserved;
-- 
2.16.3
