Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2671386-1527001699-2-13387100066450965750
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES rosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527001698; b=nPP0YijkhDM9TKjlM5+ki25K7MCsJznmEn04PyRUYqFenF/Poj
    6n8Y1ucrymtV4xAs9Xg4bZI6Y402tnaml3NajLP4hDOvM+ganzv9uCqOri9VbcSq
    YuvnTucwyIQmQ1qRwOqHEvckxRuPuucWnylXuJLvk70Y4u1kNjOizT7gc5DCAy+/
    UjDEQKtF+elO8lpm9qV1hY247Vj7zrLlU5N9Cvsu0RP5kLGv5PHOpTaRbxZlgbnv
    jqR49wVHMCVVfZgnfomhv3uvOjNhb3yj6OXDusVk8bcQ32BSjBj81NImoWrrZrNH
    0lJWX3wgNGeHt8AKMDRlDoRGZ3/JAOAoO7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527001698; bh=
    uPoCM6JxoxW2LbVQ4E5D500dDJi5fZsIsN0avKNbr2M=; b=KDmxfxN5Ii/7LP4y
    tYiNmOl3l1GdpvKZSJnGew7l5gPw3/1tCyfv2/WHpjUWLYg7YJJh3HgXPWBFkUUA
    7CAbON9M4tSVrwHRb4UzCCNT6ZAyL5fv1KxlCRgUbw11tx/O+VEKyb0wknKf/tna
    gPVbZQdnaVsPdR9BsB+VXzbyW0lOQe7mlgjUWiZChl4oUplPgZrK71f9jeIOKaOw
    ea2i7+SMrUUQfjL/JfKV9KLYHjVNQVo3wkakRA4boHIENKS/kHoJmDhdn2eS3Bl4
    Z8DVNzdeQL3Oshf8FzDAuvH8xWnivpQHQ/CrOb52iyuK782SnqoWFnoZwxzF1Xmk
    btr6tw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=UxZ4/yGF x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=UxZ4/yGF x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEkgopl6gPLcooAdjsL0JX9GYcuSHgBk0bYmtcbjMwSRHzK3PanPdjPTKjZg7HLTOLX1Y13jGch+3Qx4Ymp8X2CJ0avATJLsnQPM6s9zixP62kpKcjYT
    nNX4XMuppD0hN9CPW/I5gduHNtlZVmmNUchaRQ55JcfTPlupq4nS5ZlccswbldRC/VA+KB02ge8NPZNcC+L+iwz4v50q8KA/9Xabjii0zPeuPbMRNPqUpTfE
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=VwQbUJbxAAAA:8 a=glKb9265TxNBDykp62kA:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbeEVPIC (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 11:08:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23233 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeEVPH4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 11:07:56 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520870400";
   d="scan'208";a="79548766"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org
Cc: tglx@linutronix.de, mingo@kernel.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, jack@suse.cz, darrick.wong@oracle.com,
        rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, hch@infradread.org, jmoyer@redhat.com,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v6 2/5] fs: Convert kiocb rw_hint from enum to u16
Date: Tue, 22 May 2018 08:07:34 -0700
Message-Id: <20180522150737.9893-3-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180522150737.9893-1-adam.manzanares@wdc.com>
References: <20180522150737.9893-1-adam.manzanares@wdc.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

In order to avoid kiocb bloat for per command iopriority support, rw_hint
is converted from enum to a u16. Added a guard around ki_hint assignment.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7f07977bdfd7..50de40dbbb85 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -284,6 +284,8 @@ enum rw_hint {
 	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
 };
 
+#define MAX_KI_HINT		((1 << 16) - 1) /* ki_hint type is u16 */
+
 #define IOCB_EVENTFD		(1 << 0)
 #define IOCB_APPEND		(1 << 1)
 #define IOCB_DIRECT		(1 << 2)
@@ -299,7 +301,7 @@ struct kiocb {
 	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
 	void			*private;
 	int			ki_flags;
-	enum rw_hint		ki_hint;
+	u16			ki_hint;
 } __randomize_layout;
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
@@ -1927,12 +1929,19 @@ static inline enum rw_hint file_write_hint(struct file *file)
 
 static inline int iocb_flags(struct file *file);
 
+static inline u16 ki_hint_validate(enum rw_hint hint)
+{
+	if (hint > MAX_KI_HINT)
+		return 0;
+	return hint;
+}
+
 static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 {
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
 		.ki_flags = iocb_flags(filp),
-		.ki_hint = file_write_hint(filp),
+		.ki_hint = ki_hint_validate(file_write_hint(filp)),
 	};
 }
 
-- 
2.15.1

