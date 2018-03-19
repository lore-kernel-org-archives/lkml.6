Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2356021-1521448555-2-10647328194300582656
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521448554; b=FX8ZrPlrRfHhYBE4JVdZ6WEgFjHtnQbuBE+/tFUDs2rWttD
    LXoO6U/z6O5p13BHW366C3T5GNkHmvM03MWkcxJ2ku8IUW2c/cKsucbrS1PB0uUm
    NLxNoN6I9hf4wJNI+uETS00fuu9D+YX7Aqq/cyV6lxlgHCn6uoGFIpdrNLy5qleW
    5f1ATCiCM1nGIo5jUy+TtJ5LYBj1v4v0ehxddIlP6JdwbX6SNFC03BBHIYJ4YSbQ
    g8qKvq5kjvxX0YkPGXpaGm1GHDpgfCH0C6cYucEAsYnxBbzjOY6zqlucR2uNE8uO
    wJZcq2qBb4p8GoRO0AOzozHMogrw4sDCUCL6w4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521448554; bh=P04viyHtw6AalIUG8+Xx/DCyWl
    wWYzk+b0YQ0Y+dcDI=; b=w/9mz2S59+i1/0txcn5rDW32xVEXVQ9BNGONN52/NB
    LbjlWRIUNkFAEyei022aMNs1gH/ulEXU741es9Wc++gvOzr1rQkhWxOLs+ZK2ABd
    Qv4VxTTH7BA9LtybJfqYBzIEKbsu8AKb1MIW2uUBn0MCpZhzK8NV+p6EcTFEXAv1
    3NsSkPQrPxgaTCWtYNORXisVSmJkcsZZ/vSUiEMU/swMXQJwZNZzPi0y1/Yh7S2m
    g30FSOy1xl3TNhgs3fsZIrf9JvQsgV8WiLoiVxirceYNiuv4k7Vle3kKqsEgAAR5
    cuDdphBNtgU/hKxfClKmEufvDZzZ9cs+WYD+3OnLY0Yw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpeevhhhrihhsthhophhhucfjvghllhifihhguceohhgthheslhhsthdruggvqeenucffohhmrghinhepkhhvrggtkhdrohhrghdpkhgvrhhnvghlrdhorhhgpdhprghguhhrvgdrihhopdhgihhthhhusgdrtghomhdpihhnfhhrrgguvggrugdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddvudefrdelhedruddurddvuddunecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehlihhnuhigqdgrphhiqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegieegleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpeevhhhrihhsthhophhhucfjvghllhifihhguceohhgthheslhhsthdruggvqeenucffohhmrghinhepkhhvrggtkhdrohhrghdpkhgvrhhnvghlrdhorhhgpdhprghguhhrvgdrihhopdhgihhthhhusgdrtghomhdpihhnfhhrrgguvggrugdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddvudefrdelhedruddurddvuddunecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehlihhnuhigqdgrphhiqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegieegleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754531AbeCSIfw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 04:35:52 -0400
Received: from verein.lst.de ([213.95.11.211]:57750 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753013AbeCSIfu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 19 Mar 2018 04:35:50 -0400
Date: Mon, 19 Mar 2018 09:35:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: aio poll, io_pgetevents and a new in-kernel poll API V5
Message-ID: <20180319083548.GA21224@lst.de>
References: <20180305212743.16664-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305212743.16664-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi everyone,

this posting has been out for 2 weeks now, without any replies except
for Jeff reminding of the missing reviews he already gave me in the
previous version.

Canwe make some progress on this?  Especially as all the aio bits
have gotten reviews from Jeff.

On Mon, Mar 05, 2018 at 01:27:07PM -0800, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds support for the IOCB_CMD_POLL operation to poll for the
> readyness of file descriptors using the aio subsystem.  The API is based
> on patches that existed in RHAS2.1 and RHEL3, which means it already is
> supported by libaio.  To implement the poll support efficiently new
> methods to poll are introduced in struct file_operations:  get_poll_head
> and poll_mask.  The first one returns a wait_queue_head to wait on
> (lifetime is bound by the file), and the second does a non-blocking
> check for the POLL* events.  This allows aio poll to work without
> any additional context switches, unlike epoll.
> 
> To make the interface fully useful a new io_pgetevents system call is
> added, which atomically saves and restores the signal mask over the
> io_pgetevents system call.  It it the logical equivalent to pselect and
> ppoll for io_pgetevents.
> 
> The corresponding libaio changes for io_pgetevents support and
> documentation, as well as a test case will be posted in a separate
> series.
> 
> The changes were sponsored by Scylladb, and improve performance
> of the seastar framework up to 10%, while also removing the need
> for a privileged SCHED_FIFO epoll listener thread.
> 
>     git://git.infradead.org/users/hch/vfs.git aio-poll.5
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/aio-poll.5
> 
> Libaio changes:
> 
>     https://pagure.io/libaio.git io-poll
> 
> Seastar changes (not updated for the new io_pgetevens ABI yet):
> 
>     https://github.com/avikivity/seastar/commits/aio
> 
> Changes since V4:
>  - rebased ontop of Linux 4.16-rc4
> 
> Changes since V3:
>  - remove the pre-sleep ->poll_mask call in vfs_poll,
>    allow ->get_poll_head to return POLL* values.
> 
> Changes since V2:
>  - removed a double initialization
>  - new vfs_get_poll_head helper
>  - document that ->get_poll_head can return NULL
>  - call ->poll_mask before sleeping
>  - various ACKs
>  - add conversion of random to ->poll_mask
>  - add conversion of af_alg to ->poll_mask
>  - lacking ->poll_mask support now returns -EINVAL for IOCB_CMD_POLL
>  - reshuffled the series so that prep patches and everything not
>    requiring the new in-kernel poll API is in the beginning
> 
> Changes since V1:
>  - handle the NULL ->poll case in vfs_poll
>  - dropped the file argument to the ->poll_mask socket operation
>  - replace the ->pre_poll socket operation with ->get_poll_head as
>    in the file operations
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
---end quoted text---
