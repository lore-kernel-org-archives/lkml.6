Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2401354-1526988679-2-5976926590666964412
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526988678; b=Wj2bEbgBF7Ws/diHQsOt0wycdpVUTO04n1yKndDD2FIMiCzLvs
    VugbgPBbJF2LykD4oeuV2ILbI4NGQrYjR2HgVpxCLMP0CA/VA5w9gDTmbmjIgiD6
    7skON82j1kZRRNrmN1xhYlzVaia9kRci/6nYVKW5mc49q0ZlvPfr00VWJj+EEiiW
    tM9eyhrypBj51TQOWtOVvJjaUsmD5KqWFylmpuGoFhOEUtnZiYvEy5Mxy+WviGlL
    J0e1qleQHOD/5muurHFZqw2ffjYjotzDK8ay1PcWwyHvLi1pxiyIGd+/Ta0Ev+lZ
    0gGy6OBrPBT8lGuyMJgB9lzlzF6nv7IuFj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526988678; bh=n6aYf0J1h5bHXWmIXZc6LjfucyVswd
    eAtPBKhRf2VIo=; b=LvqD7UZ4NiwRBrJLXeV+zPJoLCgNhJTLNuTqVLrJe6jZ9k
    p+SGwylXlbsTmBz0yoe39Uxe59EzuiEaBMN37nY6M2jFaybGaJKJe0DUuSg50mZE
    91YEfnKWMmnGD4BKbFbIVOdrOohHb4+AJGB4Jrc2xiJ9Nftb7B02YubjzB/i41Bv
    zP0PIwzhjEUCCbiHYSXZML0DFH74QydgFpixU8cRORNClo4HEhOTw0cPjZfvb6bx
    Vc0V+4SxrWcn/n2KtJ3/L9EoP3i+ALYKxeRR1Q9F1DnBKcW53U/rY45yh2d1e0+o
    PvPLjRq9+NoYxKQEu1fbuEt8y4k/lvb2bhAh/l4w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=RvNIL3BN
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=RvNIL3BN
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
X-CM-Envelope: MS4wfCKn/EA7oOqIvuUle9ctIB5L4Jhxi0xpg/zEEWVDarRwY8agAUoHszy4HBLlGTz0Kn5+gdUnyz8FF9lAuydZKYbKaU+0PVSZs3uuhuEiRkG0giPEj8xR
    RTlMRsgJdGt+8OftIsR/Dd1E0uEnpRHNmx0afpyQ2sElx3GxE6ACSEi8KkQJKWhxorz821JRrzrLCRGlnzSLbzABTApxgXSQe4cWIaQhD+lp9hbm2/ma8GNh
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8
    a=lViJMyulAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=6vigZOl8d8-jUZ2uSXwA:9
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=gb9IC-u5QvZuJU0a8fSk:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbeEVLbP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:31:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeEVLbO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 07:31:14 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: aio poll and a new in-kernel poll API V12
Date: Tue, 22 May 2018 13:30:37 +0200
Message-Id: <20180522113108.25713-1-hch@lst.de>
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

    git://git.infradead.org/users/hch/vfs.git aio-poll.12

Gitweb:

    http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/aio-poll.12

Libaio changes:

    https://pagure.io/libaio.git io-poll

Seastar changes (not updated for the new io_pgetevens ABI yet):

    https://github.com/avikivity/seastar/commits/aio

Changes since v11:
 - simplify cancellation by completion poll requests from a workqueue
   if we can't take the ctx_lock

Changes since v10:
 - fixed a mismerge that let a sock_rps_record_flow sneak into
   tcp_poll_mask
 - remove the now unused struct proto_ops get_poll_head method

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
