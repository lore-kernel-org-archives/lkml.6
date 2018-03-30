Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3779118-1522424102-2-12883994833601960869
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522424101; b=HNnOT5HtrmCMXIRJQWLRa+12yqJ7vvZA2RVu5wxPiar5+9Bvls
    eRt8ZfEp06E5sW/f5VJ9Yjcs2DvzxZM9hUBUCuE5lxPxFXkWxys7avG/MBItvTIC
    JMeHaQTmaoxaxMprOWrWhjc6KQm84AAKIkYeu+nkEnkDv5zxShaYWPBl+FrIt/IW
    CdDN/ajBcjxZ4qxVmQcPbQwPCU1bFmPhCBjs3XuxHZSO847bX4+OwyBc3NO/OkHf
    mZiD7m6WshqTE9i8oxn3xgtO598jwX0GpaqxzJWOE16uroin/EZpTaRLA1KNJhKd
    ld3eAlazbhfXKh6dkOT0zH9ikDsgOHTuhxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522424101; bh=w5FW6jvJoSK9b70HO1z1BNWs/h9dFY
    JmDwNKwNqgtdU=; b=SxraAuz8Gl+hTfWJSxWiaHq81bTfvoINTya+vhMvfcfSqX
    Tkv3WftpbXvaXC8usixaD2mbHv210oBaT0T/n5DqwW4KYYxsJKUZO6znjOXlZr8m
    xYiNCvpFsk00ojtcvgOsFR0TWhSzFw6BK16LiZcMOHu7dsJUnSQ/e/mVhpL57SqM
    dMziFhSgkttSShrv/SgqjeMC71Y94eXKD48jNnEqo5yY2VmebugBILPLwbD7eGxk
    yqNQH0z88TEeU2cC8Vxk869D0dZqZC+yja/glu+FULh4ppvpSC7csi7WAUc7PrGZ
    a4DcKr1QpMlgE/ORNshiX4y65/9RZrS+qH9vHy5w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=GJX7Mlr/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=GJX7Mlr/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJMfMEJE2bupPpjCfuePXgQQqCrHH4Ew2UI0PimwNvEo1xvdRHkKn5ECPrlorXdYRt2X8aY6tD016pXEuLDsn3qGEUsSgldJHpIgaTMghikoc5oO/xvp
    Q5OIyVJtgDmszQRNESasf7yRnpzthnnwF6vLl7TnwOdScuDRi5SqhONHgGpcLKqBH7Jwed69295HYJeZ5qE/Ex6WTAWVhPj+Q+VIANGGNmUhrWuzgp3x4wTh
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=JfrnYn6hAAAA:8
    a=lViJMyulAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=l86m8yidz1PAlMsIhS4A:9
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=gb9IC-u5QvZuJU0a8fSk:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeC3Peg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 11:34:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753228AbeC3Pee (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Mar 2018 11:34:34 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: aio poll and a new in-kernel poll API V9
Date: Fri, 30 Mar 2018 17:07:37 +0200
Message-Id: <20180330150809.28094-1-hch@lst.de>
X-Mailer: git-send-email 2.14.2
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

    git://git.infradead.org/users/hch/vfs.git aio-poll.9

Gitweb:

    http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/aio-poll.9

Libaio changes:

    https://pagure.io/libaio.git io-poll

Seastar changes (not updated for the new io_pgetevens ABI yet):

    https://github.com/avikivity/seastar/commits/aio

Changes since V9:
 - make delayed cancellation conditional again
 - add a cancel_kiocb file operation to split delayed vs normal cancel

Changes since V8:
 - make delayed cancellation safe and unconditional

Changes since V7:
 - reworked cancellation

Changes since V6:
 - small changelog updates
 - rebased on top of the aio-fsync changes

Changes since V4:
 - rebased ontop of Linux 4.16-rc4

Changes since V3:
 - remove the pre-sleep ->poll_mask call in vfs_poll,
   allow ->get_poll_head to return POLL* values.

Changes since V2:
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

Changes since V1:
 - handle the NULL ->poll case in vfs_poll
 - dropped the file argument to the ->poll_mask socket operation
 - replace the ->pre_poll socket operation with ->get_poll_head as
   in the file operations
