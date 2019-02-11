Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0306C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97C92075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfBKMUi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:20:38 -0500
Received: from linux-libre.fsfla.org ([209.51.188.54]:38228 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKMUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:20:37 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2019 07:20:37 EST
Received: from free.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.15.2/8.15.2/Debian-3) with ESMTP id x1BCDC7x016558;
        Mon, 11 Feb 2019 12:13:13 GMT
Received: from livre (livre.home [172.31.160.2])
        by free.home (8.15.2/8.15.2) with ESMTP id x1BCD0Yh143080;
        Mon, 11 Feb 2019 10:13:00 -0200
From:   Alexandre Oliva <lxoliva@fsfla.org>
To:     Tom Li <tomli@tomli.me>
Cc:     James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform Drivers
Organization: Free thinker, not speaking for FSF Latin America
References: <20190208083038.GA1433@localhost.localdomain>
Date:   Mon, 11 Feb 2019 10:13:00 -0200
In-Reply-To: <20190208083038.GA1433@localhost.localdomain> (Tom Li's message
        of "Fri, 8 Feb 2019 16:30:39 +0800")
Message-ID: <orbm3i5xrn.fsf@lxoliva.fsfla.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb  8, 2019, Tom Li <tomli@tomli.me> wrote:

> found Alexandre Oliva has stopped maintaining his tree

?!?

I still merge and tag every one of Torvalds' and Greg KH's releases into
the loongson-community tree, resolving trivial conflicts and trying to
verify that it at least builds and passes a smoke test on actual
hardware (after Linux-libre deblobbing, but still).

Occasionally I notice problems and I try to investigate through
bisecting, but, not being a real Linux developer, I seldom get much
further than that.

Two issues that bother me a bit are frequent failure to reboot/poweroff,
that's been around since around 4.10, and, more recently, a very slow
system overall, that's been present since 4.20.  I haven't checked
whether they're caused by changes in the loongson-community tree that I
still carry, or if they're already present in upstream releases.

I've already tried to bisect the former, but since the issue is
intermittent, that proved to be too tricky and time-consuming for me.

I haven't tried to bisect the latter yet.


I've considered leaving the loongson-community tree behind and using
upstream releases, but every time I was about to do that, something else
came up that led me to keep at it.  I think the last such occurrence was
the removal of the video driver (later reintroduced as a new driver).
So I've kept at it ;-)

-- 
Alexandre Oliva, freedom fighter   https://FSFLA.org/blogs/lxo
Be the change, be Free!         FSF Latin America board member
GNU Toolchain Engineer                Free Software Evangelist
Hay que enGNUrecerse, pero sin perder la terGNUra jamás-GNUChe
