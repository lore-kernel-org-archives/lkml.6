Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3119014-1526413724-2-10807089824830845410
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526413723; b=Fs6DkJ+Uzxnu98CpfW0a2husr9yjHCA3Kp8+67leG90LsG6rKq
    6s7Ugt1ddcJtRq9+uUhPXkgvdlsz9u1H0iWPNwI/A5wE0ljU3VpndJtjIOqBI9z9
    aWV0eBzgQfoXqiPozfh6iCCOxyazsAqwszNPRyn8xUg5SBlbQo7QnuGcI5s3dhkR
    P9FRQpZ8TIeM51zBvYAbDL0oKrxmCS95Tbw+DiuHGkXqG0Gn3zYZ4u92XID/4+Ar
    E2d6WLgVEi65Q+XuDh17/xEKTlc1Q92Kfb2giqhTAkHVEG/J7mEOZwi7/aMtljup
    vnLk0wjO3ECnks5/rD9SPxxXh8HhObnwbfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526413723; bh=aV0zK1PznXYfEt6GO8rPIiepeHsL1/
    gSDaK/ji0mc/0=; b=XTfk6jdRPwXkCE70acjL0kbf9qGTNdfG3lANmEkemoDadQ
    Te5XwWtWXZ18SK8zO7DEJx2YT1H4Njn31SVQnZsZvqWIaQU2vrVpebajfKPQcAVV
    4jYyWzJm8nesPG0AEc6ypetclfgqa4oPcujWMzObMY2k/otqVNqspn5/5c5ce1km
    AQAhS4/yfURiNhGzytKtZtFp5fYjX6esNwzIB14JTOHiN41rLcmkXinLmPvNKSsT
    eDVZ39DHq5Ja2oxb/IUSiTngnB9yTRa1QZHNcYY5K8yPflFTtuO33S0MKquBeWR2
    ywx35ZNv6VL9m3aeKB7DT69OCd/eYZ7jzMAkh34A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=Ynd1qMtT
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=Ynd1qMtT
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
X-CM-Envelope: MS4wfPH6Xwn4Mb+8j4NfsyUsN+zfTIN8E3PnxQcAufbb5Av1y/5Kob9QKi0z6m67ww8wseaeNbc4QFJ9cxC3N3DQXEWKNY8TO0wX8ivBImRVhRkvlRPSvM9E
    B390GAzs1/IaDvJNdMIdWZG+MwcagCGxkzvF8WT7JEUme19xtkOPVNI7sfBnjt2UoGjeYWiTTG26eOzwCOiBMTg2x2YP7lvbgJecBIWlsjhVuAjOFZM8hc2O
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8
    a=lViJMyulAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EvFik-jsUyARxXK7UvUA:9
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=gb9IC-u5QvZuJU0a8fSk:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeEOTsl (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:48:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeEOTsk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 May 2018 15:48:40 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: aio poll and a new in-kernel poll API V11
Date: Tue, 15 May 2018 21:48:01 +0200
Message-Id: <20180515194833.6906-1-hch@lst.de>
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

    git://git.infradead.org/users/hch/vfs.git aio-poll.11

Gitweb:

    http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/aio-poll.11

Libaio changes:

    https://pagure.io/libaio.git io-poll

Seastar changes (not updated for the new io_pgetevens ABI yet):

    https://github.com/avikivity/seastar/commits/aio


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
