Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbeBRUSF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 15:18:05 -0500
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:53205 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751554AbeBRUSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 15:18:03 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1434:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6298:7514:7901:8985:9010:9025:10004:10400:10848:11232:11657:11658:11854:11914:12043:12555:12702:12737:12740:12760:12895:13069:13161:13229:13311:13357:13439:14180:14181:14659:14721:21060:21080:21451:21611:21625:30054:30070:30083:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: start19_bdd5851c5814
X-Filterd-Recvd-Size: 2859
Message-ID: <1518985080.1894.40.camel@perches.com>
Subject: Re: [PATCH] auxdisplay: Replace licenses with SPDX identifiers
From: Joe Perches <joe@perches.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Linus Walleij <triad@df.lth.se>,
        robin@protonic.nl, Paul Burton <paul.burton@mips.com>,
        LKML <linux-kernel@vger.kernel.org>
Date: Sun, 18 Feb 2018 12:18:00 -0800
In-Reply-To: <CAMuHMdUpRpa7HtbvMxv3yThMb54-aEiVtvD3QFpdnmVi-uBLfQ@mail.gmail.com>
References: <20180217193955.shfhvp3afwiurzfm@gmail.com>
         <CAOFm3uHHzfV3R3Q9AyhzDLp0uKNHpSTp2MsY3uSL+YsBL6w+dg@mail.gmail.com>
         <CAMuHMdUpRpa7HtbvMxv3yThMb54-aEiVtvD3QFpdnmVi-uBLfQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-18 at 20:37 +0100, Geert Uytterhoeven wrote:
> Hi Philippe,
> 
> On Sun, Feb 18, 2018 at 8:04 PM, Philippe Ombredanne
> <pombredanne@nexb.com> wrote:
> > On Sat, Feb 17, 2018 at 8:39 PM, Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > > Cc: Willy Tarreau <w@1wt.eu>
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Cc: Linus Walleij <triad@df.lth.se>
> > > Cc: Robin van der Gracht <robin@protonic.nl>
> > > Cc: Paul Burton <paul.burton@mips.com>
> > > Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> > > ---
> > 
> > <snip>
> > 
> > > diff --git a/include/linux/cfag12864b.h b/include/linux/cfag12864b.h
> > > index b454dfce60d9..aa960efc32f6 100644
> > > --- a/include/linux/cfag12864b.h
> > > +++ b/include/linux/cfag12864b.h
> > > @@ -1,25 +1,11 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > 
> > Per the doc [1] you should be using instead this in a .h:
> > /* SPDX-License-Identifier: GPL-2.0 */
> > 
> > I know this can be surprising. This has been discussed on list quite
> > lot and the doc has some rationale.
> > 
> > <snip>
> > 
> > > diff --git a/include/linux/ks0108.h b/include/linux/ks0108.h
> > > index cb311798e0bc..2a1c985fedea 100644
> > > --- a/include/linux/ks0108.h
> > > +++ b/include/linux/ks0108.h
> > > @@ -1,25 +1,11 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > 
> > Same comment as above.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
> > 
> 
> Obviously we need a check in scripts/checkpatch.pl, to catch this
> before submission...
> 
> Care to send a patch?

There's one already in progress.
https://lkml.org/lkml/2018/2/8/712
