Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B383C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4BF20817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4BF20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbeK0VXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:23:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbeK0VXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:23:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FC1442BBC;
        Tue, 27 Nov 2018 10:25:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96BB65C737;
        Tue, 27 Nov 2018 10:25:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CACT4Y+boXfNjHT1M5B6OttHiUFKsvL7AFH2Gfd+DbkNoQD4YVg@mail.gmail.com>
References: <CACT4Y+boXfNjHT1M5B6OttHiUFKsvL7AFH2Gfd+DbkNoQD4YVg@mail.gmail.com> <CACT4Y+ajxhUaRg+XSuqQZN8rD96S820yMTWx2GpRVRb9Maz50g@mail.gmail.com> <0000000000006082bd05752f92bb@google.com> <29979.1536223287@warthog.procyon.org.uk> <23632.1536696987@warthog.procyon.org.uk> <20180912063454.0620abb4@canb.auug.org.au> <31735.1536701042@warthog.procyon.org.uk>
To:     Dmitry Vyukov <dvyukov@google.com>, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        syzbot <syzbot+762a577f56cfb1574647@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Levin, Alexander" <alexander.levin@verizon.com>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        nikolaus.voss@loewensteinmedical.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: linux-next boot error (2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30485.1543314330.1@warthog.procyon.org.uk>
Date:   Tue, 27 Nov 2018 10:25:30 +0000
Message-ID: <30486.1543314330@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 27 Nov 2018 10:25:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> wrote:

> Please either use the Reported-by tag (for amended linux-next fixes
> Tested-by can make more sense and is recognized too), or tell syzbot
> separately:

It got folded in as that's better than carrying a separate patch.

I'll ask Al how he wants to deal with this since he's carrying the patches
now.

David
