Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2859260-1522260867-2-2094857729405730441
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522260866; b=Blgxi0zci3FXk/WjzzHRBcwVHl3VhxgkNIga0kaBWchc0ip
    Ib6sY4FZ66Dt2V1JUzrUl60W52aUj5YpTznqYpQzaozzPn2TabLnRJF7vutxMnpW
    xOCTKbvRNBo8bpY/v2Wys8x9jinI6l/l9RN51qGzCu+ndaqLSgoYJqzu4bcNRDvO
    U5U/VJRmVBNwqKQQ8x0IZ741Fszf42TWUkW54nw55SsNHUQplzSZYwTKf3meywM2
    98GfLM3qbnkhuA78SyF3AymQ0xbHtxAk/Kpc4Ae2ebn4zmCuUPTkkXSVVLedKVC0
    TL1coOMSvK/KQc2FBCgqjAxZYWmfEk9qLu38oag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1522260866; bh=sRxtJXseHIY5eqpSraAy16BMfc2vPhOz4ap
    FaMKxnFQ=; b=nLJOwWCkAyWBq7xDw9ApidjzB7dllsAyRQzwCFGNOySAS4sX4yK
    I86Bs6gsvpAJKvrJjotWNYoiJ2eUa9+/UZwoXeq4PL17I7jBS6YmcSnV2am8ifPF
    wTkC5MRzolf5fJX8SzKDDLTS+U80EpEdFkPOvmdA2Jb0v0S1M5S7wM6QTXVAz2iG
    cDv1WujdZVKLZJ2H54yx7I7ZKmQmJfXR+PQQV8r6En+DiWDAvu0opO++iqvVDkXM
    ONUPz5WP/Im7TVCuMSjCKUjlfdnPIBv+x8EP/lhLxnM/tlNRr8/LGajvHwF9gARo
    V6QdEcaZc5FBSK/gfEbEFXWj+5zNnXx3DLw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfKl0ONI8QCJxM9pca0wER3Fb/xKDd2Z8s0PKkqy6z+uwvqCp08+cbpjFAMHV71J0Yea1OJ1weRESLZ0OYnFN3PCuYFsxP5bQ39e/qY4XMC36hEUIkLEQ
    UVg4TuOwliEVJXtfAwdy8dVsgvPQrOauE7DLuG7ZEzfMIAJYUr0XSnhj+hlkPF3ml+cB7T7rOfUOSc5iGmPLQ3exDAV9Ea6ynvjyjGku9Z7zzcYMt3hHDSiE
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=vQBBkBfzAAAA:8
    a=Jh8bM-ib2ic79ZFQoF0A:9 a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753637AbeC1SNV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:13:21 -0400
Received: from osg.samsung.com ([64.30.133.232]:43209 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753130AbeC1SNS (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 14:13:18 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH for v3.18 18/18] media: v4l2-compat-ioctl32: initialize a reserved field
Date: Wed, 28 Mar 2018 15:12:37 -0300
Message-Id: <d8a647b26822fb0a86f6ee7dff4d6eb1e85e1398.1522260310.git.mchehab@s-opensource.com>
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

The get_v4l2_create32() function is missing a logic with
would be cleaning a reserved field, causing v4l2-compliance
to complain:

 Buffer ioctls (Input 0):
		fail: v4l2-test-buffers.cpp(506): check_0(crbufs.reserved, sizeof(crbufs.reserved))
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: FAIL

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
index c76438dd3ead..ca0a43ad4ec8 100644
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -247,7 +247,8 @@ static int get_v4l2_create32(struct v4l2_create_buffers __user *kp,
 {
 	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    copy_in_user(kp, up,
-			 offsetof(struct v4l2_create_buffers32, format)))
+			 offsetof(struct v4l2_create_buffers32, format)) ||
+	    copy_in_user(kp->reserved, up->reserved, sizeof(kp->reserved)))
 		return -EFAULT;
 	return __get_v4l2_format32(&kp->format, &up->format,
 				   aux_buf, aux_space);
-- 
2.14.3
