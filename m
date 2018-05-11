Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3845081-1526037867-2-11013091713621182319
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526037866; b=fc+CBPdU2ViZFZZ4CjRJl32ZaSHTFIT2Sqc4MMreids+VGwH3A
    S+0HvJPhUnYhdPVeEfYb3C5vy6cXDJoSePeDjRKDFnxB6bk1JS3l1Rldn7ZbjVZw
    plSicgtoi9WdV2xiZnsXehJld+wJgoKUBv9gXe/zIQjkhgaVxVIRxHSm1l7TFQkh
    3vTt1KAcNgwKsS28IKd+AQURex/x9vbuaje1hkVOfRdNqPSw37RF8iIUU4DZEiat
    xlCD/EydVY35AcIt2Ird9HQpOTszRfMkt7ocvnClErCP9+J+kiAD43ggh5tD4bBi
    dp8i8J2g4tE4zoyp3m1EXfSdDlOx8NGbW3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526037866; bh=8cU5KhdkpsAE4YTcdGl8El38B+TwCS
    vqROMKLqI19mo=; b=CkrmhE5q6IGwK16Q98tfCcB5bggVVfj6pkIU46NROVizhd
    9bTzm8CBQq5FMbYp1Dr603KFpdP+DoSoKykKJ2F1EDfMiIqQc3AGQUrhoihwjKLu
    zsDjoPFy7IpYui3ZTjIovQ2B3wDNlf2w57ytNno0u/HeeCiqJivKzwWe9p6twq0B
    aYDaN33/SxICf90Eh+U3FQY+4eMn3Su0EcKEM9082W2Kz8zRHSxQ8GIx9NeJ2wse
    mrEaAjNM2eEUoDRyn6wF/FXS2swXp5oS+EeAQqguZNdFCjoBq1tE6JoahDR7E7V0
    qFCcS77qe8jKyPm9iq4Px5PRIdDX81I7KpN3CAuA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=qPEK1Ywp
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=qPEK1Ywp
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMaKrA95HMaLXQ1GT9lTtNg5akNYPJELXF4dVlWm2I0cagiM3+iD/j8boMeiCu+U0/zuKR9Hl/wFF389wPJc0RhHQvllpOnlTlPK5p25gEdCJ2tGegcg
    x0A7sEd5rTVaxLTjyUMgI59mPCKgCzMGZ6/Td+yPz/EVMLymycxX9S2jEda6FStOrhwqdmgiG03u9z42qC5yyhXiaTkcOYkkMWla3uGceK4O7aA9qUfR2JhQ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8
    a=lViJMyulAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=u_zrgKmGurK_WgzgJR0A:9
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=gb9IC-u5QvZuJU0a8fSk:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbeEKLYA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:24:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeEKLIP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:08:15 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: aio poll and a new in-kernel poll API V10
Date: Fri, 11 May 2018 13:07:31 +0200
Message-Id: <20180511110803.10910-1-hch@lst.de>
X-Mailer: git-send-email 2.17.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

this series adds support for the IOCB_CMD_POLL operation to poll for the
readyness of file descriptors using the aio subsystem.  The API is based
on patches that existed in RHAS2.1 and RHEL3, which means it already is
supported by libaio.  To implement the poll support efficiently new
methods to poll are introduced in struct file_operations:  get_poll_head
and poll_mask.  The first one returns a wait_queue_head to wait on
(lifetime is bound by the file), and the second does a non-blocking
check for the POLL* events.  This allows aio poll to work without
any additional context switches, unlike epoll.

This series sits on top of the aio-fsync series that also includes
support for io_pgetevents.

The changes were sponsored by Scylladb, and improve performance
of the seastar framework up to 10%, while also removing the need
for a privileged SCHED_FIFO epoll listener thread.

    git://git.infradead.org/users/hch/vfs.git aio-poll.10

Gitweb:

    http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/aio-poll.10

Libaio changes:

    https://pagure.io/libaio.git io-poll

Seastar changes (not updated for the new io_pgetevens ABI yet):

    https://github.com/avikivity/seastar/commits/aio


Changes since v9:
 - add to the delayed_cancel_reqs earlier to avoid a race
 - get rid of POLL_TO_PTR magic

Changes since v8:
 - make delayed cancellation conditional again
 - add a cancel_kiocb file operation to split delayed vs normal cancel

Changes since v7:
 - make delayed cancellation safe and unconditional

Changes since v6:
 - reworked cancellation

Changes since v5:
 - small changelog updates
 - rebased on top of the aio-fsync changes

Changes since v4:
 - rebased ontop of Linux 4.16-rc4

Changes since v3:
 - remove the pre-sleep ->poll_mask call in vfs_poll,
   allow ->get_poll_head to return POLL* values.

Changes since v2:
 - removed a double initialization
 - new vfs_get_poll_head helper
 - document that ->get_poll_head can return NULL
 - call ->poll_mask before sleeping
 - various ACKs
 - add conversion of random to ->poll_mask
 - add conversion of af_alg to ->poll_mask
 - lacking ->poll_mask support now returns -EINVAL for IOCB_CMD_POLL
 - reshuffled the series so that prep patches and everything not
   requiring the new in-kernel poll API is in the beginning

Changes since v1:
 - handle the NULL ->poll case in vfs_poll
 - dropped the file argument to the ->poll_mask socket operation
 - replace the ->pre_poll socket operation with ->get_poll_head as
   in the file operations
