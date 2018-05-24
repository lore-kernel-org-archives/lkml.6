Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527155770-2-17856876320781311285
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES encada, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155769; b=Rz3XBG94zpVXAQ6HgOgEMl5UgbQB7f1jmMJixhsbAyMzckj23o
    fCchBCZ/N2OMv5hwfglEMvKNtLmDSlEK/vLjfuF5H2Qa1A6Rgv86cqUUinxwwpsj
    ETP3nmWbASBUeTBjdoAamdznUwA+f5cIz7AjvIEPxexnt16/lHYGEpCzQ3j8zdFy
    5sNdek/Rw1wzzKEJjYSYPp4jxusqYqDKofK51PouNeylJ+3ojG6ZdXBUR5pC/Olf
    zbEj7TmohEKDWBfMjphyH0ljqVY4wpEsMiRAa5ntsLgA52soTbNbJuIjYTzWOAEm
    iQymYhafRTsYFftff5eT6ES/7qkBYKQYUJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155769; bh=n0fiC40lBm80Av6AYCVdl3QUSJVZge
    8PRzuM9PaeGF8=; b=QWFy3HIowGtW1OYrScQ36PhnVlobDgAdjjQATiQy0JFUZV
    AFpI97Fw1jeuESFzbGUmRE4mz/W9hShV4M0hd7FszJOzGEClxVodSO1Se9DRIbxd
    VGlCJX7yFhM8vaDyXmowXCU2Ym3X0tX9yhjyQnuv0pIVW8n76O2F/lrgHTO1j6WO
    dlocZhHpljtZnvL+3VRmlL9XvqD0O9aaylDBgraPJCVFBOYu19Zn91BBG2K7unzX
    K2NDblaSF6fVL+/StQtjgOx3BOEHpAiQHj4Y2Rpov3dexkmfhVtp+GNTC3urbTTU
    5+yGmWvz81+lwCxRAI1PVSQy3LPtsEuUmbNYvtOw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=LsjL344z x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=LsjL344z x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfI8MZndS5A+5D2iS1O/yLLJvlgF5FSD0kLItMaf6u1aCa7l52ioOdnOj9RyNnp/sEb31LKHp94H+D/OEPpJwMHU58zqTFhajUlkxMkdHr8hioetW9Fw8
    /n1/KLuFkE9qbKkjKK0hnBxTWvl+1+kOkXoWVurw0fo6xe0FpTP04VAdo1RqbHpoFvJp8xsLSxp7ovxXEyZr7UvwhR2y7vSk2EbC2/YYjADOj6/jPmsTdBQl
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8 a=vA3e__QJ6ZNYtID03woA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030235AbeEXJ4F (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968415AbeEXJ4A (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 106/165] scsi: storvsc: Increase cmd_per_lun for higher speed devices
Date: Thu, 24 May 2018 11:38:32 +0200
Message-Id: <20180524093626.304795528@linuxfoundation.org>
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

From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>

[ Upstream commit cabe92a55e3a12005a4ac4d3954c9a174b0efe2a ]

Increase cmd_per_lun to allow more I/Os in progress per device,
particularly for NVMe's.  The Hyper-V host side can handle the higher
count with no issues.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/storvsc_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1661,7 +1661,7 @@ static struct scsi_host_template scsi_dr
 	.eh_timed_out =		storvsc_eh_timed_out,
 	.slave_alloc =		storvsc_device_alloc,
 	.slave_configure =	storvsc_device_configure,
-	.cmd_per_lun =		255,
+	.cmd_per_lun =		2048,
 	.this_id =		-1,
 	.use_clustering =	ENABLE_CLUSTERING,
 	/* Make sure we dont get a sg segment crosses a page boundary */
