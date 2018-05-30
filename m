Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeE3QtX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:49:23 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:47363 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753847AbeE3QtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:49:17 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1560:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:9025:10004:10400:10848:11232:11658:11914:12043:12740:12760:12895:13069:13311:13357:13439:13845:14181:14659:14721:21080:21433:21451:21627:21788:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: prose74_8ae888ec3a215
X-Filterd-Recvd-Size: 1241
Message-ID: <c04eb59fdc916202875cd01952d944d876569196.camel@perches.com>
Subject: Re: checkpatch.pl: Perl regression in "improve patch recognition"
From: Joe Perches <joe@perches.com>
To: Charlemagne Lasse <charlemagnelasse@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>
Date: Wed, 30 May 2018 09:49:12 -0700
In-Reply-To: <CAFGhKbzv9mTOv-cttiyDLNSx8Sc-QiHCVfrAtsa+PcGGOW2Wog@mail.gmail.com>
References: <CAFGhKbzv9mTOv-cttiyDLNSx8Sc-QiHCVfrAtsa+PcGGOW2Wog@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-30 at 18:25 +0200, Charlemagne Lasse wrote:
> Since the commit 9dd0c31c6cc0 ("checkpatch: improve patch
> recognition"), the checkpatch.pl in linux-next is only printing a lot
> of error messages when started (with and without arguments):

https://lkml.org/lkml/2018/5/29/932
