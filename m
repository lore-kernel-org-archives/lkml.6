Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/PPy7SnZUw4cHVTUbrw+IUGD5bH1MVnUdcePnWjRTLzK3znNy5evDh0VYch5Q2wb7LfQHu
ARC-Seal: i=1; a=rsa-sha256; t=1522476593; cv=none;
        d=google.com; s=arc-20160816;
        b=gSuKQij/2h/JnE0tog0Wnqtf19VkcVSn/kLiwaddsDegSo7KF/TTMX7CeJooeOG98/
         k2zkq43dxbTwYMXYgPMyvbCmelA45Cy4wUJtcOuxv110z+HYrYjP9nJVOBi0yy+WnI8Q
         vSO0x8CsHOw0XflProzrRO3KEKfc+YRq7ehXNk3t2GC4CUVhdp39feuuyUnSPSmh2oK1
         AFSeopTe97O+JLhgSbQfjUc3v44YlxVhDq77+QJhZeA3Xiw2ZZoHCvzt2PUENoSEc26e
         fSTUF10rQVmjQTrDMb61r2DZW8UdTFR/dO7w9t8hxFmfYWBTo8PqKpEMt9E27kP5LK81
         NUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=kEogJg+5oZI+e1MbQv6LlIKNTXnm4sDL8hi/6aHEpvc=;
        b=oGfrVHQUFcAdli0wi4vfjOZ+AphXPcbNduu0hSWDEVaUYEln4KvD5A65kgJ3qXR/f5
         bgNDOq0vMQfOd5VQxSiFxOvO2ZbOFPTRsu65AN/zY2560R1M9faUCC1+7LS8yvSzo13q
         17gwe5vrgUuPE3aB6ebUwUeD+zBuC7HNKPwoBjeJYEGpxbj1/3x07+0GV9T8xloWfhJk
         jLGDe6Db0hbWxGEZbkV3xdUgvN+hH/5izIwvDLARTy2AmA0fjoNLsXM6LfcgJivYOh+1
         ZwQpc4ggJ4NAbEwqmUsn5LniAmp/lsEd4F8Wgb4SMi0XmSZYKQ9Hz1ASKZf7l5cQFnlX
         P+RA==
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
Subject: [PATCH v2 35/75] staging: ks7010: Remove unused 'struct hostif_infrastructure_set_confirm_t'.
Date: Fri, 30 Mar 2018 23:08:15 -0700
Message-Id: <20180331060855.9452-35-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:1clw4qPmyavwb2UGDpkbLbGX6xgvjmzdH1gjK1hrhqbyMym+9W8
 Q70AxfqG+Rtjc0EncrubkaSWTRRSKeeHAEi0mSwhW/RpFH6kh5J61hMvp2asIJVSay9pw7c
 fRFFKqccw21SxJ6GKUhKojNUkoBLEJ7zZJ3MQkFhxQdDrza3e7VvWdxlpC9aX8bEzf1Dq3F
 xUCBBk6XV/VrZgf9zBE0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qCYFfmVcwRU=:yOnXiJo7Qh6Hx0170LIkdK
 c8jtXJtYmKQ80YUy43lJijJYVuZMS87i5AZJa3BW4f7lZbFxgZn1eCOMwmw9VAkElFc7E8y7u
 r2tT8Lcjv5znKq6zA9nPHvH/Edn2jbjxqREqdjGcCYQPgeUIVjE8aP0w1hodoQcBFOPjuWQoC
 NQEMbkwPuedeXDbMVIZ+1G7zcH2TVHAhi+7e3mJ84M11nU3rZ7eNQToyegByOfwUk9SiQQZa1
 L6MF3XRkuttz4Yh22Db4TTrYsDR4YTmQhsx9bWZB9zy32aDCdhjDDUNJkEi8mIyo9DxYThooa
 5xErrZfRc1OTQ5fUNx4PXpD72OxRJutSNDJ5/7DyEqT136Wuq3dKrCYseAAWhGg1X7W66B/os
 pjf1kLLTwdXHwMXCvWf994lC2ToROo4KyoW8AaXPq1vsru9KJjvPz0STvIfS90UYdmThl397s
 aEuMclpbSZpV4po6HMvkJeSuOPI8NVb3YO3vK7SwDpEpsOrs3MNx6HJ2LK5SPZ1kAKQGhPhwi
 FguKN4h3ozt37EnF27SmtFUmi6P5kF0ZP6VVm7are6oi49CGcbnimLMizeJY+BGKy1y84Z/V9
 xP+RhXYPv967XsdiRZOxIQQ4LavbG0Y3LNfryQNSRqVcDYtchtqMYwL+bT9Bqhb8RChNws/IU
 yk9NfvYTUlxbCyHbtCk+whyO5REGXLL5ws6ABTabhm3jsOTjzznzIRL6SeG4jqwUVrxLCxraD
 wB+3qV7icDtPz/tx1JWak+/mrW5tJipxR8oFHQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432417179806048?=
X-GMAIL-MSGID: =?utf-8?q?1596432417179806048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'struct hostif_infrastructure_set_confirm_t' is not used in this driver.
Remove 'struct hostif_infrastructure_set_confirm_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index a4f51f3311a1..7429304d6691 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -341,11 +341,6 @@ struct hostif_infrastructure_set_request {
 	u8 bssid[ETH_ALEN];
 } __packed;
 
-struct hostif_infrastructure_set_confirm_t {
-	struct hostif_hdr header;
-	__le16 result_code;
-} __packed;
-
 /**
  * struct hostif_adhoc_set_request_t
  * @capability: bit5  : preamble
-- 
2.16.3
