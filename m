Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1160787-1522476684-2-7442428172299696290
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476684; b=gRC1A8VuK672TiIcfq2G0LDKTxRmPaO5BQlTkrWb8c9rta7XMO
    XWnP4YbPKr6tjmZ5Qj+UQ2MlzLNkGbhoIpgloiGbKehqMYxk9o48O+CbuvAxFkTl
    xZWek8XMrQwV/sROn5+6K1ZfdWKQ+acamTyGVpyqledvQ639oQZ4vmN7GDjfDhja
    hQeaFOSmDdVr9yxFvPwsYDzC9eB96v+Wt/ljXOPSEnht/KrL7PgoYN8YT9TipJwt
    XFG6lYg8vuBLBwaphZ5WKWRzg47AGFfC4qOcdUtjAy7hB4B8zXb6j/jpNT1+kwWp
    8pOqwi7nlhPtKNc67Ixc91V01t+g5iv2HISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476684; bh=EAVBL
    /yTLcivpxGdpmqMWz63drVZ9WnMy3xCNunzXrU=; b=cGyykiigixCMSsNQwgd7+
    9bo4tT4ArANeSYGbQeEq0otfOjOWvuaryPebM0bXhWOg5CqMOPrDxBAI3mo5H8Rt
    qrzXasIWREx/+aeN0TG9m7SXvFeHKU2+zp9OJlNkukrcTl51RTt4B/9c5TxIEXkP
    GyWZRctzffgZmUCdG0vmOCqT6ot/S5Zqxi8bBcXP9FkYT2JNDiNHVTTq7bnjzKGu
    Otq0j1yaMxUTqgHMXSASQqGOXXizQvBtVLN88l2AN8skv3EG5aD3A+paUqOPKHmA
    8uM+JnKVjTO5AKCqrZUSdVwdDrH8qyd/b8nQGtKYcVkC1up+72eY83j6EN8H5Th/
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC11OJKJt0QCA6GMBPkoaaIVrsshIGRUuWMtewSnGvzT4D0lKRyoBxRJ0gDLn5g8Uwbhyw/6F3uVZMLSETSWLyL3laXGzgjUuWKVdqaWooud8Kb4pETg
    331eLBGaKwjPoNsqvLLmdU3zl3hJBmIbQYK4/3s1lyUwKhLTmmHx9rHGRkS2Jdjtedb4H5myuuzm2JP75GG8ttDq/l6XwkbKSXW8r9H4qU5vt2dy042R015T
    /xucpL5R5VTiqL4SJ34fsg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=V_zipIKupC2UuXeJSREA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 47/75] staging: ks7010: Remove trailing _t from 'struct
 hostif_sleep_request_t'.
Date: Fri, 30 Mar 2018 23:08:27 -0700
Message-Id: <20180331060855.9452-47-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:ArzGA5rZnp6Zm454dwu7scZcc3Xq2Nmy2gniftBZVeoHETYWZsF
 C5JRSuIEcA38Ig47rB9V7r4PJx+Yj+Fn7wui2bKGLdmOl+RtQT6ZmH6l75XCUFgmMBL3Di+
 TdmKjBgfwBd7uGRFhkLN/fJSrvEkBPhDMpw8OWHBdGQyhxtvoGzhbdPamKWMQBmG3kh/KGS
 AwpBY/jbyQUkDlbSt4slQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T68WlrvjbpQ=:Nivpllxzt8vuikrlX97gpb
 PDzgxuLPHSi+BLaWqcxvjC5kJx8bLRCiARd6QaSp9CIlZrnPdTdAAOuVTs7XxvameYwjcPR+d
 GShPvQQ6t870rrcZMAna73fZmXfJ6vUdDls8h6nSgUEjNzONbOJ0dHXdz49h98c9Ra8KUiHur
 k2QmFUoJ1MDGlHXxpgIF68Bkj8Y8ewu91MyxK11adxleMP2E85EELcu+V/bNf/6MBiJ/cOy2B
 acZMxOeSmAxvWfDvkVPJxsXPYLNJifXI0bAEbbOHqHB8jTJXXsO+IrGbtiqbbAGs/hxHD6ZT6
 HCxY059DqLSlBDfJvAxReO3024NfTg07thyzbwibPSYDhlz+JDvBoyVm2LU6VygDtV1c4pJsj
 VZEVEFpdMXi62Sdp56DlhCPjSw4v7Zs9bxOIFx9ul+JSiYshChq37gBW9jF+lPobujdpG75Tf
 lDdUp711MQGN8Mqkwi8YJACfmAiINO7EI8u2EA8o3oessFAw51qWMHzO5KKjjRLbwqCMZxZ/E
 4Pl37Z5EYvF8XRHjX6XGy3vFnlBVFD+G673ATbNB11bZlLNwiIc/s7Yod73na2B74RP+xB/3f
 mOf1fptP6tci6TAv5uDSdxDFxWLQq+jvjbyfs99QIrLYADfknGXuRbupS4px7jJH0IXLGWZKo
 x9EKFO8X/cTPfo3A3LbgufMpme98qcnSlU0ovEk5TnpumVqi8ove1O+uzgnFR5ubOQucjKwYU
 NQ+J3NkZFN5PtOy/Wj0gVKU5K5aCtAD1Q9k+4g==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_sleep_request_t' with 'struct
hostif_sleep_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 4bd8a285eac5..cb768e861b07 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1483,7 +1483,7 @@ static
 void hostif_sleep_request(struct ks_wlan_private *priv,
 			  enum sleep_mode_type mode)
 {
-	struct hostif_sleep_request_t *pp;
+	struct hostif_sleep_request *pp;
 
 	if (mode == SLP_SLEEP) {
 		pp = hostif_generic_request(sizeof(*pp), HIF_SLEEP_REQ);
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 869068ed963b..ca0b89cd99a1 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -414,7 +414,7 @@ enum sleep_mode_type {
 	SLP_SLEEP
 };
 
-struct hostif_sleep_request_t {
+struct hostif_sleep_request {
 	struct hostif_hdr header;
 } __packed;
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
