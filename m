Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELtM2UrPT3RkeyghciJw05Qrpo8uvRbFusYur54qBwlWg4a6ycFVHI89MtRJyXj0JICescoI
ARC-Seal: i=1; a=rsa-sha256; t=1522140097; cv=none;
        d=google.com; s=arc-20160816;
        b=J77aKipghtXPAfqpjoxwyRuGsIxq7TDE21B2SA1v1IyS2qtjZOO2iXTZ3PhURV6Avc
         bCiMs+ol7JnybgjFgSRwJyFYVzejCTXh8aJgU0XoZN1q/QLXYSlM/WoNnfPKtX2Lz08Q
         Tpt5FfA45dkeH8tO+AxC0cZVtnB57fSJHkRRZilEa+4IXviUypriseU3pCc6D1ldQfXW
         lTItgN7oij0gAGC3Qez44/9V5dNvq/RjAau/Ir520pUBhpaLg1pcFA5DEzg0KhkMJ9kB
         Kb7u0jhGsBfuKj25w+nfkPZ3AAbvOnYg1/3DPukeZx86J6PctKj/gEc8OV+d2Zx4Org8
         CDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=WmUrZvQlSWjsxXRH4FkN9LhzwOVVTh2t97fDZ38aevk=;
        b=m+iWXA1nnt68ct2nMUn3wi/DacrEu6j5eMWzG8/xh4wS7Z6UfWLMWg++NPNJvonWa6
         avSwqyB/2qy8Bc/gDGpmVhbMK8OQh84WQITWkLaXyiZ3MMcBLbRoqEqLaX0h1OIru+lw
         hZs0vcUpEtesy4/czfsYwmtvY4KpbNsKm/F3d/2l43gY/meveRfDKtNbt3FhuGsonFKx
         bhqxaqyUoZqMhPF1ZLJGf9s+3xgylKIM7dXv+wm4rwwJgcNtcFeYmsF/wgCFTE/48Tuu
         HA4u7KpiPyacoNiPrDlzQH9pTkAifyxgLYR3axjocZBgF3m7Z+7ep5ZkrqViFUFN3Oke
         wHcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 18/23] staging: rtl8723bs: Fix function signature that goes over 80 characters.
Date: Tue, 27 Mar 2018 01:41:10 -0700
Message-Id: <20180327084115.16129-18-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:xmswnCWEfYUVJrJObVEbjKeXFOmr3227wjayE5D/dbsSjBQDBJx
 wBNcJCZv+D0TSSMthwncWPqtZGVO1fZ2p/Hj2aROqVP8vrHNczTDhqoEgmFC0sRQaJFQ9SL
 0o9jMIsD7yKMYsirn9JPjEiaMORJyA9onxnwHkEIc9ypbXTl+6mpY1bnXIkm+vQkE483lMN
 PUSn+yWXcsnOBXuqJrE9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fsLv40eE2sE=:ViJoTASyUwHFbBx2sqlpUv
 oLvLWPrw+WeFMqYAg7BTF9iVEsAJ9DqtFFIEW9yDRFYtSDkRplyB4NZT7Q/xSd5H8AZB+nzsc
 aERpj2MNeHGBAzJPQ+EeP75AYD0WQ8VuOfESXKqL1/L8BM7KzOBDNQO3dBjVVdZpGAoNfb7YE
 ESTcmY4L6bqVmdIqs+NGxQl68g6Cwl3r8P9r5iSsdATRKK+dz5GLx/uX1x5Uq9orM+WSO0km8
 thh7RZA7utiFDyVtdH4418k4ZxSSHfQmZn4jKYhAQpHwcxyx8Ck8CiehJNK33jn3TCt+FoEjt
 TKVfP9tonK/LbAFHNqvbSrrk5KR5jYgA6wY4ePXMA2nv0Ljjzjt7PWZfmXYNbleSuMbjQyL2v
 EHHXNc3rZFsvuC0ViuRyhS+ceW500AKHSTawpzL/437kRhiVyklHqjmDaVUW/5iNQlJ9YjFu8
 h38I7ODTFi50ZZMFjGYd/kr0FPVEvelJsUk3WQ3JSQDWbk8ClnFwWhYhVkMUWE4EqXXlTUDEY
 oPrXq97bbuoNxs+6nqjyS/4omehJsl0cTnUtP9RH0wlxczRfCf5AcrqKGGgwVd+BdXXLP6Cc6
 s5HkFOgYTc3JVsR5Zja00i/YKkavM+onLX9wl3Gp3JOIcO1FqTfrnF5idctV3fWKGG1euiVnr
 8oQiu5K2MykMrYfJFeL94b06NwDFA1LanBiqZP5jkoWHVDKthaTmKEkTqVV85z0VlCAGjkKP2
 w+TMju2YMElyU7zZs08TFSFgxR0eioiGlmU3Iw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079575310945641?=
X-GMAIL-MSGID: =?utf-8?q?1596079575310945641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Wrap the function parameters for rtl8723bs_c2h_packet_handler() so
the function signature doesn't exceed 80 characters.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index a00d4e7ed70c..c4851a825fbb 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -162,7 +162,8 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 	}
 }
 
-static void rtl8723bs_c2h_packet_handler(struct adapter *padapter, u8 *pbuf, u16 length)
+static void rtl8723bs_c2h_packet_handler(struct adapter *padapter,
+					 u8 *pbuf, u16 length)
 {
 	u8 *tmp = NULL;
 	u8 res = false;
-- 
2.16.3
