Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539844-1523804478-2-3979699770906363850
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
    1523804478; b=Knud9CB9ED+Tu/34FqMm3XaF4fmT57Un5B4HWw7JUKCpoj+DN/
    X7vRJVoKRacYJjrhjuIfAJxp6W4qKbzk3YOWZxvkorZF8BafNzI6YMmvttMOP3nJ
    NWqmr8PTnr5XkTg9LDZPyPM+vDneOaj/l6FoblV3rO8/2mMFvyAH7tuPQSWTSgNo
    w97sXMgRf/92TitLbE+eJlcCddYP/h1AT139MoYWuZb+3xcb4kvj9oWntYu52/f0
    5DZYdDj/nvbepVRvpKQkhE3ayBag/bmAivWBuZcxgdYpx/l2lEEMYwEIK96XeUt3
    uDOJIM6g++Zn7G7l3O6O+JRsdTWR/2sYJbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523804478; bh=pGB2HvB9SI/tBx6VAAD2pyGvlmvfD6
    5BCX36qhe5KXM=; b=Mju95i141DCZr4V3abppCbEzRz5EEdoxOs5TmjnVu6GIx3
    fl5TiC8oKdkNhcUzbT6Na9B+2CsyNkO4FHIcY5hFcXwic0sWmkJo/RMHQiKDssbZ
    jO0qACrmTg2W2X14RjhGJ03ZwOe6oGGQYwrohgHqiWdpWw5z1ifOxZc0REOzAv1U
    EfPmy9NqwHf3Krd1WyaqNKfEfBegLS6FN+kBproUwnBgZoVeUuPJtlR5Oyc6Qmli
    4UnCmbJU4aboRYP1XBAkWCi5yngtRE41jwedR0yrqwNQ/mocJ5CqS9bhYVitlcRn
    OZ/8oEpO8f4azq4BhStLJu5Sq2vjCkQbinAvI3QQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=SXVxiuNO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=SXVxiuNO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFc/3kzpt8eXYz+2GR4RMToVbZ0jB49vHhoXGisi2wi2wpB3Lhpx28PxAEobDaeIzq6wDP4dQOOuIj/Jnxit1nDnht+wG/Rrcw1rxr/t2YWSoq2+/NUu
    T4EyMap25K0HZvHhYQNZU+r3oL5tqnpu4gfwkZ5qURoNTbBx13IRN0L6mlk15A4hCI57t7DG3v7unfbYqVb8qfuhTPgoBxq4Hb4OtTVlAO6368Wd5Oksdrnv
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=JfrnYn6hAAAA:8
    a=VwQbUJbxAAAA:8 a=cttBgKo4hoVpVbv6kvAA:9 a=x8gzFH9gYPwA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeDOPBQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 11:01:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbeDOPBQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 15 Apr 2018 11:01:16 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: io_pgetevents & aio fsync V3
Date: Sun, 15 Apr 2018 17:01:01 +0200
Message-Id: <20180415150108.1341-1-hch@lst.de>
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

    git://git.infradead.org/users/hch/vfs.git aio-fsync.3

Gitweb:

    http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/aio-fsync.3

Changes since V2:
 - don't introduce a use after free for lockdep sb release tracking
 - set up list for cancellation before I/O submission

Changes since V1:
 - remove a BUG_ON_ONE(is_sync_kiocb(kiocb));
 - moved cancellation patches to the poll series
 - improve a list_empty check
