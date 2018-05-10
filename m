Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AB8JxZrMBBUuJz9EV+nFYa0iEkHNTFBB1wBN24wRhD+h+7RDociZ6l54DGvn+nReJqz1MksBQU9c
ARC-Seal: i=1; a=rsa-sha256; t=1525964862; cv=none;
        d=google.com; s=arc-20160816;
        b=uliAnP1wym8CvIb0cgGmwe3ZTjku+9UXnfxQG+XOjFdVocPRMt7ddwjBxc+KCq5cyF
         NWMc2sE1jncLkg/NlZR2Xlvkm1UluixwWv/8mOVpuki5D//YCWYeb/Fy0isO8pYWCTjB
         n+bMjD+ohljJKXlBkREgzi6sXjxwL4CHxzWbDNxAGfUM/NDKlzQ9agqIU1l5agE8xoUS
         eTumKELq/z9AzcoguHFBA/HSBwZORSUlTi1vtLAd5WuF1EF4dJg62ZwJAEcEVPVXbJ+K
         4bZSufPAimrDb/vNfUVQE1MQJc4kKIc3OWXsn8HcNsNyfTCEj0Vni5BUnSyShU5EURr4
         k63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=Q2WTcq255rC4Zw+uKe00TZwP9EaNbYHYKuyChhKNWJg=;
        b=W7TE43glV8ffRklj2pWxYThI+SHULYgpC4QJMZsm9FsJoYUPc4r40Kff0QeiNKXEOe
         mAm0e+vYm0InPwcfQtiuehflY37W0SIlTNmeDeFr+rNDUwJ1IHGwewrXvatsdqrMhcnK
         sKYsaL50QIJPwRrAKYl59dt9krHapwixkXQniHn5TWZdbUtxjJBOzquhPpovlNFlQVg9
         vK05cmNfguu4HqDUTcDUfxjfZPoDFwpzSN3nP2K9JPuxy62sus3p/Zfz4wqkdV7bQSfm
         LL6BEKs09LHT1VZNwVjdbmobyPkMAn58xH9hSrG+O6/U4/QcfbPNy6aB1pEwur6G8B/1
         3sVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtlwifi: fix spelling mistake: "traking" -> "tracking"
Date: Thu, 10 May 2018 16:07:41 +0100
Message-Id: <20180510150741.20677-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600090131983688658?=
X-GMAIL-MSGID: =?utf-8?q?1600090131983688658?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in ODM_RT_TRACE message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtlwifi/phydm/phydm_rainfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/phydm/phydm_rainfo.c b/drivers/staging/rtlwifi/phydm/phydm_rainfo.c
index 8d0802669928..a89bc59cf63b 100644
--- a/drivers/staging/rtlwifi/phydm/phydm_rainfo.c
+++ b/drivers/staging/rtlwifi/phydm/phydm_rainfo.c
@@ -985,7 +985,7 @@ static void phydm_ra_common_info_update(void *dm_void)
 		}
 		ODM_RT_TRACE(
 			dm, ODM_COMP_RATE_ADAPTIVE,
-			"MACID[%d], Highest Tx order Update for power traking: %d\n",
+			"MACID[%d], Highest Tx order Update for power tracking: %d\n",
 			(ra_tab->highest_client_tx_rate_order),
 			(ra_tab->highest_client_tx_order));
 	}
-- 
2.17.0
