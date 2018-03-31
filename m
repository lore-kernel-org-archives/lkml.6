Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-670115-1522461436-2-15535688574387514738
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522461435; b=qjAwpyKhCKhxpnZSx7pACYGmHOZMktrWp5GaxhP1rNqbJRHdvL
    BbrekYjhtPX/CZVfTmTMEFvV1KDK8s8kRe6uRlmF9ZGNtpSpI/vaNdSAYPcbYgCD
    RUVW4ptDvdpMLBQHyx6mVCh+opktzbkjz1SV8XRfOqqtgw2ZEgTpp3BP87FMz9Ut
    gBx/LkJQjjHS2Zk1NAvPPj/vA4gll0wasZ+JrFjPZMXNaJfRrtfdDkEJAS1yyRuI
    qnYLxecLbq7x5g8kmf1Ao0LBismYui274qx5wrz7SRQkqWoKzyyTGLDszwjGztFN
    dppF13XM3nAV2bYc1UDihkZn+Nt7vhrUgIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522461435; bh=gWtQvN1q0uRwxOIFXptStCTmDTf4Ey
    Bc9G9wCadDO7M=; b=moDukyO1rbbch/N04YRrml97yyx164RlGP93g859EhwIoM
    CAaewlw85Psh7hVEgZCoDRrCC3BFOvO6kRenOZoRbUX9lsWfTTxui1ZbuxBsss6G
    xjvjHnP69WcH3fZ+PnHH2Fgy2nMPWfpUvD4cSfTc2JiNeADr4PZvSjyRmtizSpXI
    rHoGIk+LvK7vN1aowq/C1dApew7DXL+0eX1Vy28sSQbMCEkJEftXIoLsAlkUI4Eg
    8QbxJP/U/PCFh+rjitxoVgwMan0vXxvp4ySXgCoItivPt73EEiMB1iBcZS1lHMKj
    eNyQQUqqrqe2/Q12MZT5o/8dT+KrLwoGsnxUj5ew==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMDrk29vxGE4isIXFU2cG77CGLkPizq8qx+J9WfvlCwlVFFwAgnTpofF2s7eovlrEA7R3WNIE+ZmWHzIbVuoF6ifQavaRMmCuob9qejqB6jBCEpVHxOa
    FJitdkFXBpodUwhw6zqYPYAoh/UG5I+teIOZmdcCY4ZcagQYoKm9gl/JlLwAviGIqONYidatgFvil4e1sEfJi5cJ2qUdsFbp2A/gycDZNy8r+Z4zJtUJ01YV
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=fmudEVSGTFKl2g307FAA:9 a=HUqATDVKn4QA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbeCaB5N (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 21:57:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752603AbeCaB5M (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 30 Mar 2018 21:57:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059EC20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] f2fs: truncate preallocated blocks in error case
Date: Fri, 30 Mar 2018 18:57:10 -0700
Message-Id: <20180331015710.72893-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c9-goog
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If write is failed, we must deallocate the blocks that we couldn't write.

Cc: stable@vger.kernel.org
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8068b015ece5..f18f62dd60a3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2911,6 +2911,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	ret = generic_write_checks(iocb, from);
 	if (ret > 0) {
+		bool preallocated = false;
+		size_t target_size;
 		int err;
 
 		if (iov_iter_fault_in_readable(from, iov_iter_count(from)))
@@ -2927,6 +2929,9 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 				}
 
 		} else {
+			preallocated = true;
+			target_size = iocb->ki_pos + iov_iter_count(from);
+
 			err = f2fs_preallocate_blocks(iocb, from);
 			if (err) {
 				clear_inode_flag(inode, FI_NO_PREALLOC);
@@ -2939,6 +2944,10 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		blk_finish_plug(&plug);
 		clear_inode_flag(inode, FI_NO_PREALLOC);
 
+		/* if we couldn't write data, we should deallocate blocks. */
+		if (preallocated && i_size_read(inode) < target_size)
+			f2fs_truncate(inode);
+
 		if (ret > 0)
 			f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
 	}
-- 
2.15.0.531.g2ccb3012c9-goog
