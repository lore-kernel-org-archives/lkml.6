Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5631C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F87120862
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F87120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeKKUu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 15:50:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbeKKUu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 15:50:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DEFC308624C;
        Sun, 11 Nov 2018 11:02:14 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-74.ams2.redhat.com [10.36.116.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D44E55D736;
        Sun, 11 Nov 2018 11:02:09 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Cc:     Willy Tarreau <w@1wt.eu>, Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
        <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
        <20181111081725.GA30248@1wt.eu>
        <3664a508-ca74-4ff0-39a6-34543194a24e@gmail.com>
Date:   Sun, 11 Nov 2018 12:02:04 +0100
In-Reply-To: <3664a508-ca74-4ff0-39a6-34543194a24e@gmail.com> (Michael
        Kerrisk's message of "Sun, 11 Nov 2018 11:53:54 +0100")
Message-ID: <878t1zx4gj.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 11 Nov 2018 11:02:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Kerrisk:

> I'm not sure I'd view the glibc position quite so harshly (although 
> it is disappointing to me that bug 6399 remains open). I think they
> are simply short of people to work on this task. There was a lengthy
> period where no syscall wrappers were being added (pretty much from
> 2.16 to 2.24, as far as I can tell), but that has changed.

People may have disappeared from glibc development who have objected to
gettid.  I thought this was the case with strlcpy/strlcat, but it was
not.

At present, it takes one semi-active glibc contributor to block addition
of a system call.  The process to override a sustained objection has
never been used successfully, and it is a lot of work to get it even
started.

Thanks,
Florian
