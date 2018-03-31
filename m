Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+aXnODNwAvlc7wQd9usJ7/yh+eGd6mk7d2kKozCBIylkQrBaz+EA0vgEVdkbUJOzP3HVFh
ARC-Seal: i=1; a=rsa-sha256; t=1522476598; cv=none;
        d=google.com; s=arc-20160816;
        b=GskchLtft/g09m44qIjwVgDsu4YBMGBrGHbCV5wqyC2C7+09yu00HqSBQshY4VM6Pu
         yUBnLjIkpJ9/viEJ85Qvs6o/ZdxNiZ0h10/WLK9bnmm94YRkhgkYncLbb7gKq9RMH+Kw
         NnCkhh4ZC/c8nIEUEyjTsF2P22lUIMMJvT4zvVGgai16YhBr0tEvY3zA8FOE8RYBAJgE
         TypH24PUpzELmqyypkCloddTP+ICKGllen2tEL0mi6kix/qVyXTfMFu2vaIws0Uk8smc
         3kxKMOj2q9ZjUFapwZ4Rj1PKaeT1bXBkPtOPieToo2KEftootie5GD7AwYUktEemQXrC
         G4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=oE8y7kA4GfTu/nyXS2UYhWOHwrR5tcHhholDbgrbRrk=;
        b=sxvmePSSjezwVAxOX6FJhoz4RyQO8h1kAqgfIHL3X0lDpuTfbZm8BQlsRsohOfkcY7
         9TCXy8U6Ot6yymAPvYb7/0eUcAZakRoSSYAPYuRlR4+TfddWABAeVpqDRxWsrpnxjua9
         2AZlj8s6zJ7gpVvrA+tuAJxrSnYm1L41LI1c3MtBe4at74fpFVppovGY9Qp4kSrZiTtg
         dYQHHmdVF3WxMKSc58/N5/w+yQFD8/zZ9MCLdSIE0kSXJoDnWe5xDcMFHHOrTLIUI6OK
         +NchLkna+wsVwfX6h+PrjhvXs4c5zaSHX8eVdHNN+ap6ECoqYfu+EhDr9HAg8s1KKvwQ
         vrng==
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
Subject: [PATCH v2 40/75] staging: ks7010: Remove trailing _t from 'struct association_request_t'.
Date: Fri, 30 Mar 2018 23:08:20 -0700
Message-Id: <20180331060855.9452-40-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:0r5b5arjVuJsy4+AH9M7uchBJ5bgLTKNrVT+Pub+PdzZMKTlFyb
 EcZw/13xNO0O9lrnb8dt+PX8u0lDL3LsMEu7bjn3rcFe0GDZvzWiHRkKTBNYka1ECy7vQdM
 1qBFxJBsm5fqNSt9KESbDWHLids3LgFc8qh0EBONM7GXcJSJVqxbS/0DyR8s1DT90DA7w85
 Y3u6eQ1LJM6yHQAilFLlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OQuxY42+/90=:+UhCq35vOhcktsS61A1Pdh
 nt6QAXyH3Ul9Nh/YZMHzooNjdpdohquY26O1VMYb9rvBOT05gPGJ2EoVEEpwqGk9dFRVAHz/x
 TUFI0IcMkoDhJUUkQGft6Aj2FHPJWvhSECpb5CHInWmTyB57uKE5fn4JDw0hFs+q636B5LE9U
 D4ZR0bEwAO53dmYJNwZNg2ta7pZ+wJCATPfvFUw4XOze7uygecJdepbSCoA3AxyP5xqG4o1ZQ
 ejTcV0lYiWUd42X6R6roFe9gqysSvxKoA22YwtsFta/I1gjZz6w2XPPhVN1RTYG7qfFNffUhc
 c/eHTUkrFGoLnJb3Qo25BMPSLJTpKHZRztKumr5MfSXEv3nN1amiMTUZp3Csvv8gQAkI+tdPr
 ERZoj+DvqosYWQpc1dFXUPTtpNmG71U5rXzyhXT9YfW+MZaaepvGJ3A7J9HEp2e/Zk1cxwT0V
 ot3+J4urx14YMxNWVvi2v/xBVYTyeB5n5IJfKEW6z66HAMtZAP2vqc6mHGAD+jd+6iJ1Le9gv
 Ms+BRMB4AEiXJHbZuFx4NB0S7s9wvmqvkVjphIXQE68wjJKeHuELP4xHg7GVzeNEvQVEYKBMv
 bEENJe8tE61A7WA69Q6NGf8e1JSHkYzBq+kmrc+lRDiozoUQwr6JCn1xlu9E9C9FhPe8GTdVy
 uL0CrHlMQWoGpTWBVTGDAm3jR0fqtMuApa5ScwIPe0ODNsGGc5RNb+czjpQbGmbxiJcX8IJOY
 Uc0/darls9IVeYNhHohbpahMbFDySwe/3NK7xA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432421624739520?=
X-GMAIL-MSGID: =?utf-8?q?1596432421624739520?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct association_request_t' with 'struct
association_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 4 ++--
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index a177496dd42a..43d06fdda9de 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -863,7 +863,7 @@ void hostif_adhoc_set_confirm(struct ks_wlan_private *priv)
 static
 void hostif_associate_indication(struct ks_wlan_private *priv)
 {
-	struct association_request_t *assoc_req;
+	struct association_request *assoc_req;
 	struct association_response_t *assoc_resp;
 	unsigned char *pb;
 	union iwreq_data wrqu;
@@ -874,7 +874,7 @@ void hostif_associate_indication(struct ks_wlan_private *priv)
 	static const char associnfo_leader0[] = "ASSOCINFO(ReqIEs=";
 	static const char associnfo_leader1[] = " RespIEs=";
 
-	assoc_req = (struct association_request_t *)(priv->rxp);
+	assoc_req = (struct association_request *)(priv->rxp);
 	assoc_resp = (struct association_response_t *)(assoc_req + 1);
 	pb = (unsigned char *)(assoc_resp + 1);
 
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 50584a1d2a6b..08c75f8a1646 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -371,7 +371,7 @@ struct hostif_adhoc_set2_request {
 	u8 bssid[ETH_ALEN];
 } __packed;
 
-struct association_request_t {
+struct association_request {
 	u8 type;
 	u8 pad;
 	__le16 capability;
@@ -391,7 +391,7 @@ struct association_response_t {
 
 struct hostif_associate_indication_t {
 	struct hostif_hdr header;
-	struct association_request_t assoc_req;
+	struct association_request assoc_req;
 	struct association_response_t assoc_resp;
 	/* followed by (req_ies_size + resp_ies_size) octets of data */
 	/* reqIEs data *//* respIEs data */
-- 
2.16.3
