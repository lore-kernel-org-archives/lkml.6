Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1359032-1525295698-2-17826437711375345013
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
    1525295697; b=CF438mK9Ll9vU0QPJ5eO5NDYLPxrOqQkZ8C9Lt4nEBF45FHA/6
    1bvloW2RNS8v9D8XMVe9oHwwVhzju4DbYWo8GSxaiDaKvc8yObkdq274JUNFMcNq
    N8w0owQJ+DJdEuNeq5W7H3zgDgqU4ZY2yJopBiYo4TMHRAHWGNmsHNL+b7mXrAlB
    6O4RzOliU3zeCfy57caoGLmg4OREVSOkJCIxi4ztY1yiuE94ENQKQStjUBz8+j3g
    tE8Lb3lXKvjuqBG8YNKiV99I5ot7T9gsmYFuH7MOE97iioJCBqqEpGjaMuuHDmHX
    9joaK9d3v9PAubfkR+LDXufuaTTFvMiT40SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525295697; bh=geO7/JCPGIIuo18BkrI1qZAinQ2Rym
    x/tmYvAzm72So=; b=jSGJOWTP1Ve2adTb2GyHNP5RWxg4a7gw7NL0ewLelMWJ1D
    E+6tUoVqQt36gOfIrbBveJjQuizFUBv15OgIMvVgFKzpHtQHN33HUVhIQAZ7omlw
    9v5qZJMVKaERfvvBVCkKuK0WGFu51eFtDxBtqPFN48bgpVfNnf9UYe8hF7lmoVaE
    MwfSICRrVXTIxQdIOj+xJO4J8evoqfdFHMOrQmk7j16FY+KsbvK4/f6CrTillXg/
    rp2XQSKYyupqNULwUCKuwji3w7wGhmajdLyY/po/XuuIOaxgoMchpqADhP790vgh
    z0aVnlUFBH3vzkE+6JsCeRd6hdcqVdm3CSIdzOYA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=LnLv+vvC
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
      header.d=infradead.org header.i=@infradead.org header.b=LnLv+vvC
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
X-CM-Envelope: MS4wfMXky+qb1kOWv+X6DmFDyq80Q0UUmiW4yVG4nYlgGulhVO17JafaY6/58n15SXOXFjsTQKTOMqjS/OEF2Yh3/TsSXjnWXpkdjOuVHNhlITda6lod0mEs
    zq5eHtEjhB+7vioS7XRVFqHH8N9exRp4BVYLzvgTrO5XomqTARKwJFZ5fAhAA4a03ckGc99G2BRC9wxOHuBZlbTMbr0Ivb76bWlMWKCW21/4kPLl7NzTGHHb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8
    a=VwQbUJbxAAAA:8 a=JX01Dp2AdO8ibKKr4L8A:9 a=x8gzFH9gYPwA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeEBVOz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:14:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeEBVOz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 17:14:55 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: io_pgetevents & aio fsync V4
Date: Wed,  2 May 2018 23:14:41 +0200
Message-Id: <20180502211448.18276-1-hch@lst.de>
X-Mailer: git-send-email 2.17.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

this patch adds workqueue based fsync offload.  Version of this
patch have been floating around for a couple years, but we now
have a user with seastar used by ScyllaDB (who sponsored this
work) that really wants this in addition to the aio poll support.
More details are in the patch itself.

Because the iocb types have been defined sine day one (and probably
were supported by RHEL3) libaio already supports these calls as-is.

This also pulls in the aio cleanups and io_pgetevents support previously
submitted and review as part of the aio poll series.  The aio poll
series will be resubmitted on top of this series

A git tree is available here:

    git://git.infradead.org/users/hch/vfs.git aio-fsync.4

Gitweb:

    http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/aio-fsync.4

Changes since V3:
 - rebased on top of 4.17-rc3
 - improved/added a few comments

Changes since V2:
 - don't introduce a use after free for lockdep sb release tracking
 - set up list for cancellation before I/O submission

Changes since V1:
 - remove a BUG_ON_ONE(is_sync_kiocb(kiocb));
 - moved cancellation patches to the poll series
 - improve a list_empty check
