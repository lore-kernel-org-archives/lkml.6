Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F049C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE15218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfBKMnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:43:37 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:39558 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbfBKMnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:43:37 -0500
Received: from a1i15 (host2092.kph.uni-mainz.de [134.93.134.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ulm)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 64D70335D3E;
        Mon, 11 Feb 2019 12:43:34 +0000 (UTC)
From:   Ulrich Mueller <ulm@gentoo.org>
To:     Domenico Andreoli <cavok@debian.org>
Cc:     Kristian Fiskerstrand <k_f@gentoo.org>,
        Ben Finney <bignose@debian.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        919356@bugs.debian.org, debian-legal@lists.debian.org,
        linux-kernel@vger.kernel.org,
        Martin Steigerwald <martin.steigerwald@proact.de>,
        Jens Axboe <jens.axboe@oracle.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: Licensing of include/linux/hash.h
References: <20190115170017.5gxarqxzfezgr5ld@dumbo>
        <20190123085000.fp7lhtjxcyzw3m4x@dumbo>
        <c3aa1b37-60bb-aceb-10ba-9768157a2a5a@gentoo.org>
        <20190211072259.GA19224@nouveau>
Date:   Mon, 11 Feb 2019 13:43:31 +0100
In-Reply-To: <20190211072259.GA19224@nouveau> (Domenico Andreoli's message of
        "Mon, 11 Feb 2019 08:22:59 +0100")
Message-ID: <w6gva1qzea4.fsf@kph.uni-mainz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 11 Feb 2019, Domenico Andreoli wrote:

> On Mon, Feb 11, 2019 at 12:08:32AM +0100, Kristian Fiskerstrand wrote:
>> It was [pointed out] by one of our license group that [hash.h]  is the
>> same that has a GPL-2+ in [fio] which has a signed-off-by.
>> 
>> References:
>> [pointed out]
>> https://bugs.gentoo.org/677586#c1
>> 
>> [hash.h]
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/fio.git/commit/hash.h?id=bdc7211e190482f0c17c109a0d90834a6611be1c

> Yes, the Signed-off-by is from Jens Axboe (in CC) but he's not the
> original author, I guess he just copied the file as Arnaldo did. The
> file he committed has not any reference to the license.

>> [fio]
>> https://metadata.ftp-master.debian.org/changelogs/main/f/fio/fio_3.12-2_copyright

> I'm afraid that this entry in wrong. I'll seek confirmation with
> Martin Steigerwald.

Not sure if this will help, but hash.h originally appeared in
Linux 2.5.7. In the following commit one can see that most of its code
was moved or copied from mm/filemap.c:
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=882ad449046cec136c484dd2b3659fb4c683e0a3

filemap.c has a copyright line by Linus, but git blame shows that
the relevant code was added in 2002 with a commit by Rik van Riel:
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=e5191c50d12621e04f8bc247dcb6a0f4ad76ae26

The relevant thread in LKML is here:
https://lkml.org/lkml/2002/2/18/1970

Ulrich
