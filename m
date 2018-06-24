Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A840C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FB524E64
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FB524E64
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeFXJGu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 05:06:50 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:45407 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeFXJGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 05:06:49 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 8F98334D956;
        Sun, 24 Jun 2018 11:06:47 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Joanne Dow <jdow@earthlink.net>
Subject: Re: moving affs + RDB partition support to staging? (was: Re: Moving unmaintained filesystems to staging)
Date:   Sun, 24 Jun 2018 11:06:46 +0200
Message-ID: <1910962.ItDVNtUG5Q@merkaba>
In-Reply-To: <CAOmrzkKunsjZzwpj9gtovKwXVkj1kTt81ea1zmB7BCDtZz409g@mail.gmail.com>
References: <20180425154602.GA8546@bombadil.infradead.org> <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com> <CAOmrzkKunsjZzwpj9gtovKwXVkj1kTt81ea1zmB7BCDtZz409g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Michael Schmitz - 27.04.18, 04:11:
> test results at https://bugzilla.kernel.org/show_bug.cgi?id=43511
> indicate the RDB parser bug is fixed by the patch given there, so if
> Martin now submits the patch, all should be well?

Ok, better be honest than having anyone waiting for it:

I do not care enough about this, in order to motivate myself preparing 
the a patch from Joanne Dow´s fix.

I am not even using my Amiga boxes anymore, not even the Sam440ep which 
I still have in my apartment.

So RDB support in Linux it remains broken for disks larger 2 TB, unless 
someone else does.

Thanks.
-- 
Martin


