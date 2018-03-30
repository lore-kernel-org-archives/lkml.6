Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/pnod0tV6W11DcqOYaxqTt2cMmT0Re7SMYyMFpSJTD/Vy+8R6SQAimnosS74Bz0JWHC7qP
ARC-Seal: i=1; a=rsa-sha256; t=1522393764; cv=none;
        d=google.com; s=arc-20160816;
        b=ie2ALQGmPaKW5VRC/L/0xMxXtLaXcP3TCeBUTDvXB0YjUgh1GAtmYEGcGYpdU++M/g
         dT2tnKb39WKKLapNWq+p5cJKbAdDbek89eBoox53Y2+SwqXwaAzV2MT50RH9KtreWxb9
         fVkVGaYt1pm9iG3Et01LGgESfcUvoUJOtCgWWyT0wngXDwN48iiqRlelyyj66Mw2sNpH
         hEgPRLd2ln8Og1N8akPz16eHBRhprc8NzOtTy/Pvam75KPyPFq/84WNrcVxP9gt+CHZ3
         FMP+3ti88Ag+V+QIqpbnROvxltVqia3lHMsQhldmob20OPJyH3TvvNkwXWgdoWPzHtm3
         16BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ScukK7XsiGETjd1lU7JOzWt2lsz0VgMbHkOHYi44q+8=;
        b=LW60vqoJbSIhR+nCGd6ADJk2bAy8icAJFmCdyJwKWPf6j02jK8j0OgBeGXbnk9den6
         PXrm2cF4zWITsBbDQMZ6JPsGenHdvhCG8qoxXi5NjWWDXgEK0C4ldl5z7B9sdnLYRsZD
         IqOBq6H7AnwF9eM1qZcWkLzVw9jL78Ipse7KOGyJGvC1Qnf+z1J9cgC4iMQHoUVl35BX
         r1SyuoJ9AaZwD5/donmKGYSCCgIbWeJf6JuJV5ymk+stQ2sZJ9XbmOUcJjG8bBxSXOMx
         +TS5ro1c4cPbaSim8r+TP96hkZrlCBDX6hJ4NCsXomDYBquZQJfL8Qtr0/tUSK6Jk2hv
         qarA==
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
Subject: [PATCH 30/76] staging: ks7010: Remove trailing _t from 'struct hostif_stop_confirm_t'.
Date: Fri, 30 Mar 2018 00:07:53 -0700
Message-Id: <20180330070842.25224-30-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:UrmIYimOWMgxJqOmOk97gTqPFNko+IZy9PptAm5YUOpXUk88ifo
 y6WiGeh+aUNo7OK9CAVi61gc3XTpmzkARKCtCOBWuUg+9EaYBbrYMSRBP/kz5T0Lr2pK7ce
 nEa552RFH1CdU0BB9Evfui2zvac8v7BLxP0RwusJXEyeybQjhGXbGEDGJHObIPHXKUvW3fo
 jrtFCy9/Fot5fDJ/RxUIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QV0ba/HMW8c=:fkwxw/Wq2S8a8BXDqimLRt
 9tcWCwKIOiLqoaQEJzlMcSkCMO3wDfj3dVLt0exKqzmESzGjOZ1kY4KpWnpFtVUs51PKxmRWy
 d1LbHrsYisyDvvMC9FzJOtrnvhHN56yljlUtPsS1UY9RInxLx4Xun1lz4EXXwCCUp6A7xJo+3
 W5W5bn+VVAS81bIa1/ObPGxATCk6d3LQoKBDwz+QWsrF/JH9t3eB9mrRTNQQ6m12Bo844Rcq6
 DOo5PyGHwEpXUMGwKAQq/2F7JQ50G5bTsbMZIgNFIKnsZOjy8HGg+i0U/BAAShbbhTZCU5KB4
 DJ1xTXZT9eHwgolW9SUv7j90tEECwuqAVEHoM+GUSth5+TasIAxbyrQlOncLLRLGKdDSROiao
 PyYAEmIO77koTLJcNW52rF5b4645g5PcuOui7DUo+sBjgnO4Mp00bIBo4jQwxR/Ko6iIkHTKX
 kMWIWDw5Pn/2VFtPB8SxX280LhaOEzpzahtkcpD7iSUtTmWvSAk/XLwoivQaGTbC+sTZrQS6z
 DrrSgJ5BhvlTFKicRBqjvqzlLoy0Re7KJ1bGda6OhZGPfI2J6CYd1lgURHjOdGNzeDji/1Wtz
 v2jg8qLbnQ+MphA/gjpM9G1N0Kzr5rH5LzMSHkE11H0UP7xbUxCyWtgPxUvcA4M/FD/n/BwQ5
 SIqGlN+1O6KGBD1beydDLSSdqiKqb9kvPBIdSsT4iKF3/+Xomi6LP5U2WZ8LTO2smR7EnF+4h
 dUyFtxv4jccpv3UxtLUnW/I1OgIUzB2WPNe8gg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345563858417217?=
X-GMAIL-MSGID: =?utf-8?q?1596345563858417217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_stop_confirm_t' with 'struct
hostif_stop_confirm'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 03e15fc591ea..615e2ed979e1 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -330,7 +330,7 @@ struct hostif_stop_request {
 	struct hostif_hdr header;
 } __packed;
 
-struct hostif_stop_confirm_t {
+struct hostif_stop_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
-- 
2.16.3
