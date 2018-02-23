Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1550584-1519349616-2-5012450676890759356
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES dasven, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519349616; b=kr2t7lo7KxIc/RMra6CzfGRN7UOVL5kbDDFOmVfbJJ419h2
    LHECE+7WMYx9FPpX4XBLbUHr7SzaTTpiyQhezBZNTpdmtOmiKXP0eATfnUMBTn78
    sEOBQqHgnv7xgU55LxattXqezfINrggdgYyvsKeFfXO8klkXs8Rj1Q1ErhYN84os
    cjh4by9dlYdCn9gBtY5XVMxiaxJhUtuKOd/ng4ji/wHUvCCDFruUQ8VFwbMvHF/T
    olRRV2mGM6/6O5ncURZ7CVF5I8qogRXFriSGbdfOBDeUwObY3P5styOjWBiWZL4R
    8GLxE9GN7fGSn1mRo02IoXefkIYE0qSObX1KZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519349616; bh=j
    ltv3U22jRY/7WZ8USEZXfnVjJM4JORQUPlOVZI0yzU=; b=F6SQsvYXhdBrA5Qzs
    NMeqJGQLBXI0wHirx+sysHJDaqn9BOT4yYGrdESFLn0Yo/vVbloE7ryDrN/kOSQD
    1A73Dfiw10YXP7GNf4MnooYFE71iNJ/SAABeNNsjqmjA/qHzvDdw284ogVd/jKEi
    6AfIeT5k3VM1APfG4vOa0lmO7f30uwB/kDLXL+BkbKOuGeoTswrFD8sxQtr/dJ53
    ZqjP9KtJX0dOJkxm/3Vyf0DXVRKcPgTMCXHVAy7BsSVs3I45cOL7ISUlEYjtJEJ9
    JOZPHvg7uJ4PafBMSYYYgLqQtPTzSlUMmEEwhciOJmRrgHlRfGRrQKWShJaja4PN
    cA+jQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, jonathankim@gctsemi.com, deanahn@gctsemi.com,
 dan.carpenter@oracle.com
Subject: [PATCH 2/4] Staging: gdm724x: hci: Changed camel-case to snake-case.
Date: Thu, 22 Feb 2018 17:32:59 -0800
Message-Id: <20180223013301.17646-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <CAFLvi22mENRoFd3Z6=a5tAcbiOGw3CCnvJy_7N4u783_k3jH5g@mail.gmail.com>
References: <CAFLvi22mENRoFd3Z6=a5tAcbiOGw3CCnvJy_7N4u783_k3jH5g@mail.gmail.com>
X-Provags-ID: V03:K0:Bpv+tIdN/DMuqNgjKFq1hql0miTiGMZPfCVQR+EIvNeNxQqBL2N
 zkR+OFEnc3TTV1JY5P5AsMQQ5//BzrHnyzLCybj2I43nw2tiwGZqsTNKEqhl/nC/t6WZT8f
 H40QFyJzkrjZKecMGuGCUd7jOjRPZgJo50B1XjrRkieeB1eTJNtoSVTot7aEdQAdIE2WJrh
 U5jW2OHXDbB2+e7sD9rSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H/1LQK2ZAko=:r1mgewbahra8p/11gqlwbm
 htKdPkK4W7SbSWzVNFhXLe13AgT3jJU6pfTnJLEj+QbOD0nV6NhrePFpNLuPeffT8Ru1G1i3v
 EUj8qjp6rBSL3SQF0As+xCxF302ImTBSRIZuE6gpc6a+G0+rB93mgVZ7KYGqJqUibO1Z79Ine
 NQ1MGOnmDGQ9IcHW/0vzvItNfKgpv8CQ9eDeUJvJdRdnAZy3/69Qc5c90a6Rr/n7eGrJAZjgO
 GsUIo4ZVXdOahDMJ3cL5qF3727a4WDbVpKBNB2NQjRFQ29j1KbOeJOfaJN31xJ20UUHzh1g7s
 6+muhOyP6C+i1T6Yl4+MtYudSGOfk0+w7DQo9hpAyJQzS9yqpsgOwVO9VkVftOrortmkJYLkW
 4BeVj5dR2d1IOODRdEX+PtWcG2p160p4xi17XYEoKLDO7Kcr/aSUYHYfrqRpgYC6MffgZ6Zh0
 js+OOkBMb5KhQIOYH0s3C6NibznEwzXHXRJmd3obvx9iXJCme9XP01T5YM0SkTnTEHuViSMd0
 Wqhv0aBnd8KMbtC/MiKhJS1ebO3mcpkNyRmEtnYjlqf0yhW1wjcsoKtlqzzuvSSQJ/3RyJI/p
 qZL9/xqf0lOqwEoWIRZp98Bk2HVvzYSxecyCPA9I04PTk+2S7zsBUgnTl1vRyo+swvicSuibW
 w8fR6ll6HLqFI2qPmw3CtATjH9gl+1fl+v4hpExt9nlCnNQGv0sZ4be5xbjj9GOdVi41Qfg4v
 qk8+JNPubTshJ5oJfExPA6UUxP3zAni9tWsoZw==
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

Changed a variable name from camel to snake case to fix a coding style
issue.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/gdm724x/hci_packet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gdm724x/hci_packet.h b/drivers/staging/gdm724x/hci_packet.h
index 22ce8b9477b6..f8837c7103ac 100644
--- a/drivers/staging/gdm724x/hci_packet.h
+++ b/drivers/staging/gdm724x/hci_packet.h
@@ -50,7 +50,7 @@ struct tlv {
 struct sdu_header {
 	__dev16 cmd_evt;
 	__dev16 len;
-	__dev32 dftEpsId;
+	__dev32 dft_eps_ID;
 	__dev32 bearer_ID;
 	__dev32 nic_type;
 } __packed;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
