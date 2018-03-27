Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752399AbeC0CGT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 22:06:19 -0400
Received: from smtprelay0155.hostedemail.com ([216.40.44.155]:58463 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752128AbeC0CGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 22:06:18 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:965:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2911:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4321:4390:4425:5007:7903:8531:10007:10400:10848:11232:11658:11914:12663:12740:12760:12895:13069:13311:13357:13439:14659:21080:21212:21324:21326:21627:21740:30054:30070:30091,0,RBL:172.58.35.125:@perches.com:.lbl8.mailshell.net-62.8.0.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:1:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: frame62_36beb6614473e
X-Filterd-Recvd-Size: 2018
Message-ID: <1522116373.12357.42.camel@perches.com>
Subject: Re: [PATCH 1/2] Move kfree_call_rcu() to slab_common.c
From: Joe Perches <joe@perches.com>
To: Rao Shoaib <rao.shoaib@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        brouer@redhat.com, linux-mm@kvack.org
Date: Mon, 26 Mar 2018 19:06:13 -0700
In-Reply-To: <1e8c4382-b97f-659a-59fa-07c71efad970@oracle.com>
References: <1514923898-2495-1-git-send-email-rao.shoaib@oracle.com>
         <20180102222341.GB20405@bombadil.infradead.org>
         <3be609d4-800e-a89e-f885-7e0f5d288862@oracle.com>
         <20180104013807.GA31392@tardis>
         <be1abd24-56c8-45bc-fecc-3f0c5b978678@oracle.com>
         <64ca3929-4044-9393-a6ca-70c0a2589a35@oracle.com>
         <20180104214658.GA20740@bombadil.infradead.org>
         <3e4ea0b9-686f-7e36-d80c-8577401517e2@oracle.com>
         <20180104231307.GA794@bombadil.infradead.org>
         <20180104234732.GM9671@linux.vnet.ibm.com>
         <20180105000707.GA22237@bombadil.infradead.org>
         <1515134773.21222.13.camel@perches.com>
         <1e8c4382-b97f-659a-59fa-07c71efad970@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-26 at 18:56 -0700, Rao Shoaib wrote:
> Folks,
> 
> Is anyone working on resolving the check patch issue as I am waiting to 
> resubmit my patch. Will it be fine if I submitted the patch with the 
> original macro as the check is in-correct.

Yes.  Of course.  Anytime a person knows better,
checkpatch output should be ignored.

> I do not speak perl but I can do the process work. If folks think Joe's 
> fix is fine I can submit it and perhaps someone can review it ?

I think it's fine too ;)
Submit away...
