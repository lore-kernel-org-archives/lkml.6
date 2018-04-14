Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeDNQFr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 12:05:47 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:54446 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750996AbeDNQFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 12:05:46 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3350:3622:3865:3867:3871:4250:4321:5007:10004:10400:10848:11026:11232:11473:11658:11914:12043:12114:12438:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21067:21080:21365:21451:21627:30054:30064:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: stew51_8950c2f38521f
X-Filterd-Recvd-Size: 1769
Message-ID: <e4b6b26ff58ee1ec9f92efacdd37e8fabbb7c8d6.camel@perches.com>
Subject: Re: [PATCH v2] IB: make INFINIBAND_ADDR_TRANS configurable
From: Joe Perches <joe@perches.com>
To: Greg Thelen <gthelen@google.com>, dennis.dalessandro@intel.com
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Tarick Bedeir <tarick@google.com>
Date: Sat, 14 Apr 2018 09:05:42 -0700
In-Reply-To: <CAHH2K0YTCa99ZfCdvq0WEJVvszo7+kUiVP_cz0igqE4TZSNYGQ@mail.gmail.com>
References: <9ad4563e701a38915d58552f9eee5b3602833ddf.camel@wdc.com>
         <20180413172708.30286-1-gthelen@google.com>
         <b1f20a68-2ed4-935f-4a9c-8a28c142ceee@intel.com>
         <CAHH2K0YTCa99ZfCdvq0WEJVvszo7+kUiVP_cz0igqE4TZSNYGQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-04-14 at 15:34 +0000, Greg Thelen wrote:
> On Sat, Apr 14, 2018 at 8:13 AM Dennis Dalessandro <
> dennis.dalessandro@intel.com> wrote:
> 
> > On 4/13/2018 1:27 PM, Greg Thelen wrote:
> > > Allow INFINIBAND without INFINIBAND_ADDR_TRANS.
> > > 
> > > Signed-off-by: Greg Thelen <gthelen@google.com>
> > > Cc: Tarick Bedeir <tarick@google.com>
> > > Change-Id: I6fbbf8a432e467710fa65e4904b7d61880b914e5
> > Forgot to remove the Gerrit thing.
> > -Denny
> 
> Ack.  My bad.  Will repost.  Unfortunately checkpatch didn't notice.

Probably because Change-Id: is after a Signed-off-by: line
