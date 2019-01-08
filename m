Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C84EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B1720883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfAHPjJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:39:09 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:51558 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfAHPjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:39:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7A804608A387;
        Tue,  8 Jan 2019 16:39:06 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2rCypIHhzuQr; Tue,  8 Jan 2019 16:39:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2C436608A386;
        Tue,  8 Jan 2019 16:39:06 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qzqZMvpGr69y; Tue,  8 Jan 2019 16:39:06 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 5BCEF6088978;
        Tue,  8 Jan 2019 16:39:05 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Andreas Bombe <andreas.bombe@gmail.com>,
        Andreas Henriksson <andreas@fatal.se>,
        Jaroslav Skarvada <jskarvad@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        util-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mpluskal@suse.com, base-system@gentoo.org,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: Future of dosfstools project (FAT)
Date:   Tue, 08 Jan 2019 16:39:04 +0100
Message-ID: <2431182.t5fd7Oadsi@blindfold>
In-Reply-To: <CAHp75VfJpy572t8swsEsz0kPKfpOE-v0SZVxM2aakX0hkjX4=Q@mail.gmail.com>
References: <20180929084038.an6pfhnsd6tblejl@pali> <20181227221748.zsz6bwqqia7ybfwj@pali> <CAHp75VfJpy572t8swsEsz0kPKfpOE-v0SZVxM2aakX0hkjX4=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 8. Januar 2019, 16:32:55 CET schrieb Andy Shevchenko:
> On Fri, Dec 28, 2018 at 12:18 AM Pali Rohár <pali.rohar@gmail.com> wrote:
> > On Monday 17 December 2018 10:50:04 Pali Rohár wrote:
> > > On Wednesday 12 December 2018 14:57:36 Pali Rohár wrote:
> 
> > > Thanks for review of #94! As next you can take #92 from list.
> >
> > Andreas, can you look at next pull requests?
> 
> Looking from a side how slow this is being processed I think the best
> option to fork and abandon the old project if author / maintainer by
> some reason wouldn't like to give a push rights.

+1

Thanks,
//richard


