Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC521C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C972086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfANPTT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:19:19 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:39288 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfANPTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:19:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 73239608A38F;
        Mon, 14 Jan 2019 16:19:16 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nwyq1vHO0V8U; Mon, 14 Jan 2019 16:19:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F084B608A3A9;
        Mon, 14 Jan 2019 16:19:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ChKxoGPlh8IF; Mon, 14 Jan 2019 16:19:15 +0100 (CET)
Received: from blindfold.localnet (213-225-15-181.nat.highway.a1.net [213.225.15.181])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 43A12608A38F;
        Mon, 14 Jan 2019 16:19:14 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Date:   Mon, 14 Jan 2019 16:19:12 +0100
Message-ID: <7446280.uGaFHXOlFU@blindfold>
In-Reply-To: <20190114151709.xemy2h4gtgtsos3d@pali>
References: <20180929084038.an6pfhnsd6tblejl@pali> <2431182.t5fd7Oadsi@blindfold> <20190114151709.xemy2h4gtgtsos3d@pali>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 14. Januar 2019, 16:17:09 CET schrieb Pali Rohár:
> On Tuesday 08 January 2019 16:39:04 Richard Weinberger wrote:
> > Am Dienstag, 8. Januar 2019, 16:32:55 CET schrieb Andy Shevchenko:
> > > On Fri, Dec 28, 2018 at 12:18 AM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > On Monday 17 December 2018 10:50:04 Pali Rohár wrote:
> > > > > On Wednesday 12 December 2018 14:57:36 Pali Rohár wrote:
> > > 
> > > > > Thanks for review of #94! As next you can take #92 from list.
> > > >
> > > > Andreas, can you look at next pull requests?
> > > 
> > > Looking from a side how slow this is being processed I think the best
> > > option to fork and abandon the old project if author / maintainer by
> > > some reason wouldn't like to give a push rights.
> > 
> > +1
> 
> I really do not want to create fork or become new "maintainer" of this
> project.
> 
> If somebody else want to take project or create fork, I can prepare
> patches and send them to new place. But still I would like to see code
> review of patches from other people. dosfstools is a project which is
> used by lot of people and is de-facto standard for FAT32 Linux support.
> So breaking something should be prevented as much as possible.
> 
> Richard or Andy, if Andreas really do not have time for dosfstools, what
> about you to take maintenance of dosfstools?

The golden rule is: touch it, own it.
You touched it, sorry. ;-)

Thanks,
//richard



