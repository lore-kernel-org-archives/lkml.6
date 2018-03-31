Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49BMENyhk8/dxbMjH9Y+EpU4zxmTaZOgkA/iNamUUGP+FuM9RIbkzdKgaS3HqK+giiKUx33
ARC-Seal: i=1; a=rsa-sha256; t=1522476611; cv=none;
        d=google.com; s=arc-20160816;
        b=G94MyeeRA3JrRTY2iA/NZdZMk2/swHtxVH7T78nesWoFDpDLzkf9E7h0yAg44IR7TN
         K6NpIVCPMj7vcfeR7qfZ0bvQpsF39iktWdmiyd5hag2ufkLzYpjSG1KMrvsENZzSIsUi
         Ezs+CAdkBgG4ZPgVBYonp5eb36iY5s+Jsf94raoIgy9DmJ2bgx4riPIOGbWKY7iKgAkC
         rCeZSezrWLhbAOvv8mddhKX+QYjRuYH6hAjF9f3zXTbayNmqtTOY7iWLRIsj2/RxYB0U
         khmjOQhkVrQhkukPWg3bmoXtFPg9Gu1S2oD3r61xK0IQE8KivS6Yp8cPm8zJVTFmcGcq
         0lOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/ztz8zDrE6AdlcwwEhD6IyNBiRNeImwJsvFSpG2Bhmo=;
        b=mlEvkfvHJUhQGGpQkt8YChw70szM5X1A3sqAI40MDSU2KqecUZg5MDTfRp15L59bKN
         GXfmktnInX9DfJDlJGyXS4Zy1/ktfLw58zg+whRM4jfEbmY38QgQV6lKnnNNEO/Sraie
         L83uUj7RskSLU9p2Vdwilr4VQrmVkDmnQqL4nIh/HFuSBIUtNoDEdeDCBJ+jMsqzucib
         zBo2Wh2LlzpgDf7EAMQe1nBdNpHDHrIVai/NEiiXdjrvxF4yMg3S6gARpt11fP07iv38
         77SsmlSBVbbutr6g6XZSB6Wcm1pjuDyjnuAHTHFG15mBxMzprkovEJPR+XtCs+7htB3o
         JLsg==
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
Subject: [PATCH v2 55/75] staging: ks7010: Remove trailing _t from 'struct local_aplist_t'.
Date: Fri, 30 Mar 2018 23:08:35 -0700
Message-Id: <20180331060855.9452-55-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:3UqrVv6rlq89DKjvotIpa6t8IesiPEdV1UVahwH4cZAItXcWk1w
 Lrh1AQ39WQpumCdp8E41DJt4W8j9Ss74suzyCiB8u+ZX4At/ugpGNnMOGaFsmkIzgWOAQTo
 JYMJZGkXNupAp2NNefNxSSIV0/eXf+jbkYCWdvCiQsrAXF4QFA+IgkQID9o6MRPsDq982EW
 FbsPdMgziNvnubLs6JD5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C4u9H5IZ4Y0=:bqxnQFlmBqOyBbWqDSuDkv
 jxE4hQKcvxy6ncBZAjN0NkTZJ82R7+VGKXiqrwBr2SJx44x+ATvUYOu1i2fXVNlaBTxQT/QPV
 WKl6M8t+XvkcM6R+AxRK0x1I4ZjGc8XS5bw2CZjoeYvwoSmEaHL1n+FTYhPemGLuzA/Jeay/p
 wBDzpDWCUzD9Q4DrIExIMKoIpDJb3PwMnacmIN9fOCQXPAtGXE9D3LVMgo9ahCBkIQqfhkC09
 PCFMGcXtFfyE3d0zDPLqtqvhX4RXywJoMQjNZxt6r/4fWKACltBNujVcndBuwLjO/ywFAdyid
 RU2V0muBgutQeBmYGx/UlsgRhDHIUE6xHf+o1vylzkt8NAZQi+HO1uKq1W5F1LKxao4q5aRWl
 Trg9tjOsYkJyxvN9CStjJmh3tL2R2WrYzpiZlDItfOxbRwzsJ3AsBmpRwNEzBVAjYsBuopem7
 jkuIFsdGZfqbg08Rtvu6bX+sLmDcwHHkfxL7w4S8lAoUZVcSh3/AktOPP5ipB0cLSMHp3FB7u
 NxfISDbxLINjnYaD/Evhg8td+5GdqGxRbYN32OWZGLHiX87MJYfmnH8qKNhhgYufFFwbVGDCu
 J67F+STnO4KVRjww2ahq5YEzp8AuDjpO63kr+sc7Jf+b0dIpn1CSByDSrIqSK+3ZQ88fSyjfR
 3IK0nyXJ+4Udx6iDPJL69AiUnRv9+7zeJggr873CLBpMA/g+HMOWSnS9G24iD7euoGaw79nJo
 mqlw1gLDyWR/obXr/JoETTj1FzKtIHVvazDkmfj0ErdbtAjV4kCO5IKMVQNj5XibVKeJju4pq
 Cxlfy2JJ56RRnn7yb4jd1GfKRYzmcn7WQEgBZiThtliqtATA0BtTtmomHEPuWht9g7h4wSS/d
 AUCOt0N54T4yoyZD+Xgb0/hUakosCI4Hxz/fMK2Dd+ZXTLHbJ1bxwwt7zd/JhO
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432435695772074?=
X-GMAIL-MSGID: =?utf-8?q?1596432435695772074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct local_aplist_t' with 'struct local_aplist'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 3104ff92c453..57b21d3a2435 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -244,7 +244,7 @@ struct local_ap {
 
 #define LOCAL_APLIST_MAX 31
 #define LOCAL_CURRENT_AP LOCAL_APLIST_MAX
-struct local_aplist_t {
+struct local_aplist {
 	int size;
 	struct local_ap ap[LOCAL_APLIST_MAX + 1];
 };
@@ -423,7 +423,7 @@ struct ks_wlan_private {
 
 	unsigned char eth_addr[ETH_ALEN];
 
-	struct local_aplist_t aplist;
+	struct local_aplist aplist;
 	struct local_ap current_ap;
 	struct power_save_status_t psstatus;
 	struct sleep_status_t sleepstatus;
-- 
2.16.3
