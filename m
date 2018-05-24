Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161701-2-5759344304484033856
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161701; b=NYJxVfu2bqv5ishRowh0upp/ZlJ0P2RHwls6F82cTQrnV4GOq3
    uYqUrxnf6NpRIDdDb8gcPdXlpue2QpvhKfdU8ArQHeWijP4NYKRHWNxpicfcoiUU
    HrYC55ZbkwvLAswkJM0+TF/RJCIgL/YFxGF5fqiW41AMBTaiJIxCoYdX/ORAGFC0
    xWV5A1nuYX4HmEEa6mhZoDU5nZnkkBabotzPtXhsWnLr0Lyt8PaSPi9IuyxGCVSb
    8zdRzwHPaDSvru16cBchvXpfJU7nAzo/v7d9CtdMqON9HUEqmhZfUHyrfMkRqviT
    o3GoDTStno6inlvS5jOBPJWDdn8oHUXePffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161701; bh=oJCJrj9BevASfad3n3PNKfsRSk8Bqk
    UocYX50/Jdar0=; b=hDMNXSmF+Gnagl/37TSLzNxXV8hdpuzi0W3GWE10EaO9sO
    1DwF9BWPRS5ImBsjqb23Q/anZQVM7xpg9W2tnoQDbqopohHLCgbDNNbYMjonu4+P
    fyNQt8zr9n4Z8GUMd3lSAnG+1Uqe6o2vfG+xnZNHlDe5t6TmHZ1pb09CFf8Fl4YJ
    dGhJnc1Sye13BpnPN5b3PKyhiRrmPBd21vKG04ib4UiiCs+joB7JfVhV9HIYgGYh
    LX2pYZdd8Vb3v7tD/r/Ejba7WbdgtYVwBXTaQndJZXft9vpyOrraw5QztkYqNp6I
    lzNIZUUKMNIz1LTc2WYg07mE4LZm5ZupvSGoZW5w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=vldDcmut x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=vldDcmut x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFIrAltedGPi1jSqfCwDLYl3PZYRNv4avq0KvlOUaeqTyaGpyMZgSyCq/NXyQ9hfB2iORXScv4j9YMKsHVUdCKb1DsADYvxWcQZ5wWIy/q0I7bX2Q6A1
    d2LwqbV3T2wIsbUc2kiXKYyGrb9e5ocFlDD4JZOFpThE8UfVcb7LwwNosEj7rpMGL/jsfxX6eiqTLC+09NH2mb7/WMIdlw3b9728O7m1CbJe6QqgSpUPipvE
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=3uY1OGifAAAA:8 a=v3ZZPjhaAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=xxG_gJrs1X5CW_1k0CwA:9 a=QEXdDO2ut3YA:10
    a=d_xNPB-V-J0lr6ltNwaW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967563AbeEXLem (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:34:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967182AbeEXJuS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Ning <lining916740672@icloud.com>,
        Jeremy Cline <jeremy@jcline.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 61/96] scsi: sd: Keep disk read-only when re-reading partition
Date: Thu, 24 May 2018 11:38:44 +0200
Message-Id: <20180524093608.968221280@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Cline <jeremy@jcline.org>

[ Upstream commit 20bd1d026aacc5399464f8328f305985c493cde3 ]

If the read-only flag is true on a SCSI disk, re-reading the partition
table sets the flag back to false.

To observe this bug, you can run:

1. blockdev --setro /dev/sda
2. blockdev --rereadpt /dev/sda
3. blockdev --getro /dev/sda

This commit reads the disk's old state and combines it with the device
disk-reported state rather than unconditionally marking it as RW.

Reported-by: Li Ning <lining916740672@icloud.com>
Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2401,6 +2401,7 @@ sd_read_write_protect_flag(struct scsi_d
 	int res;
 	struct scsi_device *sdp = sdkp->device;
 	struct scsi_mode_data data;
+	int disk_ro = get_disk_ro(sdkp->disk);
 	int old_wp = sdkp->write_prot;
 
 	set_disk_ro(sdkp->disk, 0);
@@ -2441,7 +2442,7 @@ sd_read_write_protect_flag(struct scsi_d
 			  "Test WP failed, assume Write Enabled\n");
 	} else {
 		sdkp->write_prot = ((data.device_specific & 0x80) != 0);
-		set_disk_ro(sdkp->disk, sdkp->write_prot);
+		set_disk_ro(sdkp->disk, sdkp->write_prot || disk_ro);
 		if (sdkp->first_scan || old_wp != sdkp->write_prot) {
 			sd_printk(KERN_NOTICE, sdkp, "Write Protect is %s\n",
 				  sdkp->write_prot ? "on" : "off");
