Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+af4stnIMbkM7qPd2DbAqShqxxksSpgg+gusGh1QX/pdWMljHZNvmvGJl6SuKUDQOC8Xht
ARC-Seal: i=1; a=rsa-sha256; t=1522393793; cv=none;
        d=google.com; s=arc-20160816;
        b=X9ENcLhcIoTGNctRIsO+JyJs7qZpZ07vi48oUhPoWrGazNQm383j5UhqHdEl0B2ilW
         LiCZ3uwwCiOKsL9xCR0Pk2xZYa4Ovlb80RJaOPMwbkKhqdd/sp6dr7EAxI86ZQLO1don
         7KLjIUqT5Vjum5vkeTXAUglpiNPa5BnZaW3NQt9fR3xB2B3L26/S9Yx4gk/gmRPABqdV
         A/zF/qP1yuWJEIG5/Rx0IQ8IE+U4hLG6w/FwHHrtrtBWmVQP+xIc/R9VmfN72FR1Fp06
         3yx3wFcbAs1mJu+efTGkpOuKX7fX+2ozesC+n1BlNpzRaOQ3lKAk/1TEsJkSCDjBzwCx
         rZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GmZ+IiSmHpZxUJROUIhLrryvqeE3iD+ogGdQwSp6oOg=;
        b=gAjfqS+RqH5VkBb9WiPKoHFUSNxYW0AjwcwUue3+dBvVpmgMJuuROgPSRb+4XhGDq2
         9Uga5ptv+FcY8eQ2o9Pnilk4m3OaQPgO/xU2Mrc3cLNtRk5gL9DXSLTTlh1VwC3Kb4Qt
         G2r6KNxZZFB9kE15pVMPoXrshng38fDj5woyBMF8ufeKPWxYoJe2QLl6CZGUfFMc512n
         rNYx9/KFcK8ngmcwbZzBWTOteaZszFc2B5bsw5sNp+MRGwFRrlhqSa7QCiCFc3H4mtMo
         EemTIxtlxiy39vkTMJ7PrS584yaLTNqP7axZ5gU5dyvLXlXCLAw3qvnfdMd0RT5cas7b
         aEWw==
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
Subject: [PATCH 64/76] staging: ks7010: Remove trailing _t from 'struct pmk_list_t'.
Date: Fri, 30 Mar 2018 00:08:27 -0700
Message-Id: <20180330070842.25224-64-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:dQRay2M7luh6yE9sNevcx9sG6lBNSHaBuS9fuD126yAc4XOV0TY
 AJPIPg17vvcXwIIrgt1O4snnIZJapNtVXpL6m0xtWn5xLe0qVAh0ywM8qDe+FCflOl6Tgml
 Db8vQAPxkGWQlRuo0tV2rkNb3ZtCbzhfWkGlGatR+m5sXGz9mmGg7fqVVAvDcOpNI/DuX63
 yfQ2RSOioc/4KmoS86I8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p9dx66Y4vrg=:DBZ1HtudWqIZztpB6RAvqC
 Z1cjcml8691nwTxkdWYPk6oZcU8OqhGJ/SXxwsbpRqVzK+Pc3/SbxMgCpBESdbhMdG9D9MvZG
 d8P5eqRfzGKxFwU2UnHyVH0IVSBHEZ0RprpWaL1H4aGqA0xOUEAjIfPkojrFPgBGFjjIIdVrp
 RxB9P0ZhcGfVZksSuJmY4JDURB/ft715AZVipZINl74ZwHiahmBLmN7SnlR2RTFNv09g211Lc
 INiZcnDOEf3EuZ/a3qs/DPpa5lgGL5cUb+hl6p7/T95u1xFBb7NTxi4koe0i9qD7r0cpmdYjg
 0fDHzBj/2f7PLK8n6L2tdxOfZnuXqfpbUqdz6XfHGv94VcIzHJ6H6T6HayvQUDqrOZkhH3/Aa
 OqRjYjb1ez+Utq1T4kMbkRDC+7mYU+Tji2qcrqU3DhoAdGwPfKml+Eov2d4TqZNepLr7EShzz
 PRhYlgQCycFbcPmqOrupjN3PijK32EULDKvjXuNnzCBYvn0wRGq1facvs9n/ppSegvl0A3D0h
 e1oPcgFKXrCm8gF6lkkaboWYADI132p8WHikYQpbVkuJ+d4bEgoSPhP2ZgLt7Smtfb37WNrYo
 xjoby4y7i0LPkC3Y5ExzSdvB9/dJdzA5DGgL9LshwDcaKLqlGSNu+mXPsZ5HjXdJ2ddTllu07
 6L6jl9SYSnqT9JZEsUC9+BRNAJfILtiDw3aHb3rlI5b3jLm2NQmGzMpJdx4QXBS4u3zqlGWCb
 6oU4VYwoadcgj1OWP4pybxKbqHIpRjcALbZnoE3wqBe6SElTcpBGUZfeeCVhh/1L7SSoC6r6l
 BTHJbnwAQjPQ4Q62OpC3LZ+0qohlprhRQVUMELVcz+7AwWOFZ0BpcX6zmzEf98O9NG0znmafh
 C0Yy3PMAC8Is1kiIfGI841GXaajQD7IC6irEADUl0gZvzdWCQqksTBYObZxJnU
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345594427852768?=
X-GMAIL-MSGID: =?utf-8?q?1596345594427852768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct pmk_list_t' with 'struct pmk_list'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 851721182b05..69eac00e75b1 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -380,7 +380,7 @@ struct wpa_status {
 
 #include <linux/list.h>
 #define PMK_LIST_MAX 8
-struct pmk_list_t {
+struct pmk_list {
 	u16 size;
 	struct list_head head;
 	struct pmk_t {
@@ -428,7 +428,7 @@ struct ks_wlan_private {
 	struct power_save_status psstatus;
 	struct sleep_status sleepstatus;
 	struct wpa_status wpa;
-	struct pmk_list_t pmklist;
+	struct pmk_list pmklist;
 	/* wireless parameter */
 	struct ks_wlan_parameter reg;
 	u8 current_rate;
-- 
2.16.3
