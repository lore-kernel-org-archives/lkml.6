Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935941AbeCHQjp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:39:45 -0500
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:46681 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933478AbeCHQjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:39:43 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3870:3871:3872:3874:4321:4605:5007:6119:7903:10004:10400:10848:11026:11232:11473:11658:11914:12109:12555:12740:12760:12895:12986:13069:13311:13357:13439:14180:14659:14721:14777:21060:21080:21433:21627:30022:30046:30054:30060:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: goat58_1a3ecc9baad63
X-Filterd-Recvd-Size: 1787
Message-ID: <1520527178.11634.9.camel@perches.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the rdma-fixes
 tree
From: Joe Perches <joe@perches.com>
To: Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Whitcroft <apw@canonical.com>
Cc: Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Date: Thu, 08 Mar 2018 08:39:38 -0800
In-Reply-To: <20180308161845.GC6773@mellanox.com>
References: <20180308164058.2ad5a158@canb.auug.org.au>
         <20180308161845.GC6773@mellanox.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-08 at 09:18 -0700, Jason Gunthorpe wrote:
> On Thu, Mar 08, 2018 at 04:40:58PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Commit
> > 
> >   aa0de36a40f4 ("RDMA/mlx5: Fix integer overflow while resizing CQ")
> > 
> > is missing a Signed-off-by from its author.
> 
> Thanks Stephen,
> 
> May I suggest to the checkpatch maintainers that checkpack should look
> for this too?

No such commit in current -hext
$ git status HEAD
HEAD detached at next-20180308

checkpatch doesn't try to match email sender to sign-off
as the email sender doesn't have to sign-off on a patch.

It currently does:

	if ($is_patch && $has_commit_log && $chk_signoff && $signoff == 0) {
		ERROR("MISSING_SIGN_OFF",
		      "Missing Signed-off-by: line(s)\n");
	}
