Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1149420-1518817618-2-8480232399102450741
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518817617; b=kBIqbuGG0Q6aequVJp4qiRBSVtlCRylofE/iDdUffBL4uHv
    +agYG7+KAV6gpaIV1Nw6tYUQ+GTlfKG3MeETBo9kAPfEYzTIoAcIV+NA5ezD9cTf
    KGSHVKcWim1juNEb1K5vfl4pK1bI98Tib3zFrVY3GDv6vVwzRZvl3LHFYfro7h8N
    dd46WRdmImvmuS3bNeUCFMxXfWDG5ttbSs/4UeqZgN3TakRMI3LxouvG9qLrgWr5
    7G3z8HR7fy9rBPp6jV3L4Opjnz/Yj+2JstM5FbBMMeQwDz4lDETgTZnqMTcZXpSM
    2Kf28y/lPWTZlQc3YuY2AEIqn6XBM6pz9wEOxug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518817617; bh=t
    YL1KEXFLudodbExqC3cXfjoqM1tqCKcyAYPcEPGnJ4=; b=r9dKYFQaf4mml/x3O
    UqN+na70x9DjNOFFyOcQmHg+AA8faRXM9GajrquVHh/PcKEGFrDI910wL7yCnc9T
    6HoIoXd5aJmarx4fvth2oPFgfX0iVsVMCI4/6dcJG4H0vm/BdUCYd6ZAbdDBhVQZ
    GJJNkfwROVuqOJJWuKFWd2vmjjF7i4EDY9jGPy5icvggs/wQBGBkSjZlRnPRqj9w
    0+3bFt3/zb4mbFtO9qFGmbt7011Sc9Av4XUYZyUkQnmpylqdIuAogAOaLNYlsex1
    MXMZ0QdLnp/ghphlg+iXgX56jPdWO8cjvKbjb8d6/sio3ELdyHJKu98Us/3QdqeO
    7R+Ng==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	tulup@mail.ru,
	stephen@networkplumber.org
Subject: [PATCH 2/2] Staging: gdm724x: LTE: Fix argument list not aligned with
 parenthesis.
Date: Fri, 16 Feb 2018 13:46:23 -0800
Message-Id: <20180216214623.17656-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.1
X-Provags-ID: V03:K0:pDCpJ2brZQkXpYX6icVrbyDfejNvWGaKFVKMqAHgLkYIhZrHEty
 Yu+3+r0BdiQQW+bVFkt2BakRZ+PKsTc8z8QbBRCFMKdaWc9xSX9e9n7PkczzO7kiZfm+zFi
 XYzu6ma6OjHyNipNQcsx8eXl0/9MlEBwazfREfxGcHF3FNM+HHgfSkZQIGV98YMw4zc4yXg
 QvC8vd0SwwSEOHWjdT0Tg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mPs8JDmIYB4=:O4hFAi0WhoegjssYE7/H2R
 2XogwntiHBrUTZfGD5QOycWj9NGqlR+REaEsgF2qQRGq4iQkFgTyL+VayyMM7usq19C896jo6
 aMrTbbZIStPd26ZKO2ABUw3YeiAVV0b+C/y9xleBwwukZZ6idI/R17w1tn9E17l1HxzTlS1is
 WfHaeJ9GOmD+QTOD3N+cPVQAodRYNBQ0v676ENY1bvTRvK640ouh/KnFQ2Taalot5O3HQyz+A
 iHfteF+E1BoPGiIk9zpaH0Tk94BWFCO5cicitQt5XHO08/9bW5U06DN1k8J0XwIQnyRXBx62i
 I0lNnu4Gw2Lc63Li11nM7hD2NiatYbqJ97w/ckpHmOiARc31lgMM1ZVz2QPjTJ9/G2xSdLahy
 mNE43tcZSmcDf3s52CXLOBqcJP6Qa+Kz2wYuX2+IAjy/UJ7+kXwWsLIsxlpb4oxFVkrLY1FoN
 tLo678nqD5oskBAME9jOPYKNEcxHLBJXgyPl0z3FJ5HC/6teecUDHdkNt1iZScdFlr5SSHsim
 Y5YNIc4rJDesXPkZbk/NSHr2eZr5094B8jLkLHAg+iDMNg5yUqSzjR3pCt9YB9bKuvVatBGqQ
 /dj5rhTDdmpUNqLGbtmEcQt4pbKK8yfhKNp17/Bvt7fsCvWD4u1FD9Eeg3OjrP7+5fZk7RH5G
 hG/RbIbyG6gXPOItkfYBP+VMh/AmzJ/Gwe839UgAliaflGPQ0mELj6KGa649Zteff3k4Ok4KU
 m7GDcX1vzakHAufE3DRTd/IlNuU88bdJthvWjg==
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
Cc: devel@driverdev.osuosl.org, Quytelda Kahja <quytelda@tamalin.org>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix coding style warning from checkpatch.pl.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/gdm724x/gdm_lte.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index ff3fed9c4a81..26a81fdd0044 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -311,7 +311,8 @@ static int gdm_lte_emulate_ndp(struct sk_buff *skb_in, u32 nic_type)
 		       sizeof(struct neighbour_advertisement));
 
 		icmp6_out.icmp6_cksum = icmp6_checksum(&ipv6_out,
-					(u16 *)icmp_na, sizeof(icmp_na));
+						       (u16 *)icmp_na,
+						       sizeof(icmp_na));
 	} else {
 		return -EINVAL;
 	}
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
