Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159836-2-1787106050454179329
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159835; b=NLlnRS7OKL7vEWYLL92uESNSXLeVaktOxNY6dxs6k2PVw01JAt
    mYuNGT0n+TXeJwCHbOE3jlMxYkqwh8qnxCVz9VMsApB3UI2YVcbAiwwBoLBOKuyJ
    QXSB8UNgK1UJ92YA6O8yZHk4HzbilCbgiR8/3TatpmP/WFHMLAglqUgWqNcPNb1u
    r6UuJ7z5frDHZVEy9Pjh+oUDThU0t9aTfvGFPDkcj6ft2Q/JxNfz9YYeXYE+JbuZ
    vAUcvGNh91fdoinFwsWYwZfuJ6buM6Eq0DjNU9UgMHyhNwlc8++7h2kSvvqYOpsv
    7kQdWIKURWvXgcz+WTrGZ3L3JCzXV05ud/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159835; bh=GAU85ESeGo5wbF7M1rFhEzFKxdz9fM
    4i3n+DyNwjqV0=; b=PclSsRDRehwQT51VBXKHrkJOSosxpt0hvu5eNI4ri2cnNs
    ZoNENAPidjWL9rvT/LHT58JQzFU+ndxX+yTqANEWw+XN0tafEMo+MrIbyHvBpRlh
    nSItPcI6nmKX1jJkIikrpJpIxPR4//Bxt70CRRzy89hXMwuH0zQmIehofbtEWqsW
    6tHPbKZv0vBYzEAZrSIv+u2w/yplVJMvDdLCzJVaY/xo0l4kINqz0IOTMZftfOF3
    bbveG6OFFXx1AYmA6bGtJRsf2lCYu/e2l7CcVLbHR3tEx/i2B8uxAc6Zu8Gy7Rip
    BIPj8Ddycb1rgjVO23kH/31o4lUEoh9dcoFQCZxw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=rcX+Qi2u x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=rcX+Qi2u x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJPqjCctzpycbBUMrgDYRizZbTmQvTmTIIwj9Yk2Luzji2KtnoBMz5IEEzVjfq86u0KZdgoxDL52nLG70YCucUlyaQJVAsJUxfxkS/gAX/nJr//KlnMT
    iIPjRBu1jGIMhtACiPrvNj4+Ew+hMurDRPVxU7gAqMHbu6hTDHCc5GN11AvnW3pAtGE5LekkV/L7Bs2nRjetV1pqtlmU0rRAW4xFJVM8E/Wx332cga1BZ/rQ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=zAyngx5bAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=LY6Ug91mmT4cBBZjW7EA:9 a=QEXdDO2ut3YA:10 a=4LA4qAFo6bo561LpWNDU:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030258AbeEXLDf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968396AbeEXJzn (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 100/165] scsi: qla2xxx: Fix memory corruption during hba reset test
Date: Thu, 24 May 2018 11:38:26 +0200
Message-Id: <20180524093626.059713786@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

[ Upstream commit 2ce87cc5b269510de9ca1185ca8a6e10ec78c069 ]

This patch fixes memory corrpution while performing HBA Reset test.

Following stack trace is seen:

[  466.397219] BUG: unable to handle kernel NULL pointer dereference at 0000000000000020
[  466.433669] IP: [<ffffffffc06f5dd0>] qlt_free_session_done+0x260/0x5f0 [qla2xxx]
[  466.467731] PGD 0
[  466.476718] Oops: 0000 [#1] SMP

Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_os.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3581,6 +3581,8 @@ qla2x00_remove_one(struct pci_dev *pdev)
 	}
 	qla2x00_wait_for_hba_ready(base_vha);
 
+	qla2x00_wait_for_sess_deletion(base_vha);
+
 	/*
 	 * if UNLOAD flag is already set, then continue unload,
 	 * where it was set first.
