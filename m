Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49vbtoHhvSPn7XauBIJxaI6/fTKZQ9BdYnGZzPVtMn7KLbbgpgktZmJgzQtvn/QlK7t6gMm
ARC-Seal: i=1; a=rsa-sha256; t=1522393774; cv=none;
        d=google.com; s=arc-20160816;
        b=y3ztWws3PgfqG0Ta9e4YwmganHJAMEgYVBqjqQHxCTROwtvtUzdTzg/fNBiqjGWcSi
         y+6+FmQfc8v1LynDnX1y2jeb/C0d5yxSE48ZSvpLHDSejIXkB1L+V5VvnTfN/IHT/v4w
         hU2w6jlP8619I9QBzXAYxl5mvVuw7olumrHBA1X/UENMieImOfcpf4X/uMpHLSwtSm85
         wSf6wzTRlhYj5aQxVQ+1TdZHpHY1xGGSHMxdLIeBvPyeB/G4GztJMoSMNLyySt0LXPUM
         lt/CafwJRf+K3JZyGCCQiPpI8sRhQb86Ne8+Dh3AE6DCIepcVqabXFSihXJrpgtKLn2M
         C8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=jNkW6ZuQFfZNq4iYZVpfDQXZVAnXsnlbw5QnfEEYvE4=;
        b=STjoZpg94kgvQ/cc0xb+myM08dfGr0eAu3oEryVmub+tl1NV4h4W53snnr+1uFzbwh
         Ma5Bm4Ylibe7uN0pKNXpuXke5lNhWkURQ4YMEapFF4nqIcB5P52J3oSRYWpbvRK+XpY6
         2axKvIcIrzqRk3dwYhRFmtuPL5RhpkT6shEhQkEVuFiEqgyxohvPhflk77DFpA/GEJjP
         iMSTU9UDxLmYZ9VrIYgc79EoaI7e/9p3Mi5hJE0RoqR9xnlgVM96pmiTpxk4/sKerse5
         /0CBIHAUGwhh0+VPSqy0NCJ+Asx/QijMp9gfqMiniYQLlHhVMvI+pAdZjf/ndBbZ8A17
         w95A==
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
Subject: [PATCH 42/76] staging: ks7010: Remove trailing _t from 'struct hostif_associate_indication_t'.
Date: Fri, 30 Mar 2018 00:08:05 -0700
Message-Id: <20180330070842.25224-42-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:C2baaQQYtu+0OcNI+Ucngb1InmNV+oqlJgVAZikopq4VsCNKB86
 dSknNkoEEm4dGnV2q/BRdLce5QQn6/hzuo0Sn8UL1AuNH9wDKhseTehxUOg4xrpW/5aWZzq
 LOYnl83dtO+ZZCtMBkIXp9fLxu4H85zis+yuzoRBGSSXh/YM8QUBr8vdP6TrVokuA+iglwQ
 r6GcTB7uCq/tCHMaACLNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gcXNEHZ/CbI=:Jm42eP26f+gvmi9pRupZE3
 AcJCYtGhZXBeSCB99P2Ze3MeY9P43xrO+IihIVNRD917QrMdIu1yq2Od5In5esPtcMAtow/sn
 gT3KAEQj5KJyU6h7wjuqs09Ve5WSyAGbSj33pX4Ypfj+b58WaWK/REXoey83DrLMl9uF9A7T/
 iLHCuGOQWt+LqdNkP5DDJOTit4Yre8+T5Z5tCYFulUhKLqIg4u51L01OHtyhONWDpIyBq7GVe
 AMP4amCrnS8QJdVqsgTs7ZD/eW8wVum8XmT01ORO4B8uofRfmG6Su9yoXWCk3MZchMl/gZj9Z
 Gb9Ug4MnwWwo9w90tc0ibhdAPaeBc1v1S9CEV63XI46lu8GwMfvG6whyzyeyGQT1cPKJzssAl
 O9j22DBBQ+qUHh0uX8xsp0nO2XnaJHslZj21Qh1eqC+iFLmvDbKXVH0N+sZugN0FBLFgI6vyE
 IA3nmNVqYJXfkyCTQYMnWYGWihujPQc/kWmJ2UEWEYV9F0uagfewT5t6V21Vy2cA0RDrHlMXu
 FbnJtm+DVlOdI4RHbBogqGmMSPsWCmURMvb/qzbEIAZXw1C20NmywIdbK80CqCXxgeyqyfbwZ
 U3i382Ul3JNJRb1brvXZKrnF05M+gTFKt687MEICgeeL0TSVLNd6wXij8AWHizTDkGFN6w02R
 cPtZdQGOyJFElG7ezZaLXB58Rvvw/YNIS/ztY2RZwZGb1jnEgALKxRtAxbV9g1is9YNViugZ4
 ramjuGZmbxnhyDnHdsK3f5O5w6RISNxsOYtmFA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345574725173314?=
X-GMAIL-MSGID: =?utf-8?q?1596345574725173314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_associate_indication_t' with 'struct
hostif_associate_indication'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 566637b9ac15..81f12b41830e 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -452,7 +452,7 @@ struct association_response {
 	__le16 resp_ies_size;
 } __packed;
 
-struct hostif_associate_indication_t {
+struct hostif_associate_indication {
 	struct hostif_hdr header;
 	struct association_request assoc_req;
 	struct association_response assoc_resp;
-- 
2.16.3
