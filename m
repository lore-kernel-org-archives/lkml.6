Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2859260-1522260966-2-2705570283691244297
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522260966; b=b3G2DfYr6+NxhTrOz61ZdAh3/Uh4+EHIL/I1Vs/p7+v4aDD
    1voFEg5DXiGNuJEvvq5dMNkHEvrAkAY+W+d1dfhfrqnUVsQsBy5bcJtKvrECF6zG
    RlPti26HoaTQ36Gwsp2UGpqFTKiR0cKLmVeha29PGNj9wjY/yXbt/uMQfb6yWRwP
    FhUxgSLcKGW4g1Z5MUQtasFYnkFXjaTePgB6DNR7tTVrMM7oMnsw853/nKhkCiEH
    M5SGBWVRDCsZlK31Yb8hWInwrVfRUAPRnlsjrLEHdeFpVrh/gi52mvqkFIrje+QK
    z6DjkNqpweGR6ldt3SuZRQCrHpm3DAHWUI7IZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1522260966; bh=hJI7X6GZfQdBKztgVOHLEGHN5L2HYDbNc3S
    iUfcwXp0=; b=d527+FzWKg8CTEaal5QQZGaEThuFEcHvSWhs6NGQpW5vmeRsjBK
    3DZCuqxBAwQ9+wvnmlS3a4ERy1yN7b2AHuSsy/Ow+lelG7aNoL8ygI9ZyfbR41Qp
    SoqoKlM5pfY0IIfkmxxNbEPiGhEY1HSskVYyZtJjO53bLWbKQpit88IHm3MIze7H
    Tp3W7lEwWX5X86IMwJKRAfh7hU8vlc3TNwhBgkV+R1OolxJB4jP9tMIMGz279QX0
    x6a0SiB9vcAtKQ2hY2leO+25/3GP/SAZtoYlHgDQnWYa5/q1JJhNwZp/hUHtgtqp
    1wpJ6jLv8Xyi7wQnC8U9tslenknzSipda2A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHQy6YJOGi0aE3caOusPZWDVLK89gUPMjsa9qaY6zwgSjGOGLveAm10dWSzlHabrNMigVPELgR2DTHqZqdlA5QD5DRxK8LMNMEwSlBiwSx8qBFQJufXV
    +v89SNbWMIGMP84N9GsduxJMksquvmUM78w9C9C7f5vIBQeL2XF8u8Qg3oxI2Eq/4kMdjGm0j9f65L4GzbZLgWIiuyJNyuzShFNDy5ojUcjJjSom4A2ptLpr
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=vQBBkBfzAAAA:8
    a=sxGew2JaZx_vYpgoXSoA:9 a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753666AbeC1SPu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:15:50 -0400
Received: from osg.samsung.com ([64.30.133.232]:55251 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753561AbeC1SNN (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 14:13:13 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH for v3.18 17/18] media: v4l2-compat-ioctl32: use compat_u64 for video standard
Date: Wed, 28 Mar 2018 15:12:36 -0300
Message-Id: <2ba9505436180b463d47d6da4ce5e059b383938e.1522260310.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1522260310.git.mchehab@s-opensource.com>
References: <cover.1522260310.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1522260310.git.mchehab@s-opensource.com>
References: <cover.1522260310.git.mchehab@s-opensource.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Instead of using the "v4l2_std_id" typedef, use compat_u64,
as otherwise it fails to properly handle some ioctls.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
index e03aa0961360..c76438dd3ead 100644
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -686,7 +686,7 @@ struct v4l2_input32 {
 	__u32	     type;		/*  Type of input */
 	__u32	     audioset;		/*  Associated audios (bitfield) */
 	__u32        tuner;             /*  Associated tuner */
-	v4l2_std_id  std;
+	compat_u64   std;
 	__u32	     status;
 	__u32	     capabilities;
 	__u32	     reserved[3];
-- 
2.14.3
