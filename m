Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936129AbeCHRwQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:52:16 -0500
Received: from smtprelay0135.hostedemail.com ([216.40.44.135]:34186 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932087AbeCHRwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:52:14 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3872:4321:5007:7903:10004:10400:10848:11232:11658:11914:12109:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30060:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: cub97_4d673d7e0620c
X-Filterd-Recvd-Size: 1577
Message-ID: <1520531530.11634.18.camel@perches.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the rdma-fixes
 tree
From: Joe Perches <joe@perches.com>
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Whitcroft <apw@canonical.com>, Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Date: Thu, 08 Mar 2018 09:52:10 -0800
In-Reply-To: <20180308174444.GG6773@mellanox.com>
References: <20180308164058.2ad5a158@canb.auug.org.au>
         <20180308161845.GC6773@mellanox.com> <1520527178.11634.9.camel@perches.com>
         <20180308170317.GE6773@mellanox.com>
         <1520529792.11634.12.camel@perches.com>
         <20180308174444.GG6773@mellanox.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-08 at 10:44 -0700, Jason Gunthorpe wrote:
> I only ask becuase I keep seeing these reports from Stephen and
> usuaully by the time it gets to him it requires a disruptive rebase to
> fix..

If it's a part of a series, it will always require a rebase.

Generally, I think it's a small and relatively unlikely
problem for checkpatch to bother with as there's already
a reporting mechanism in-place.
