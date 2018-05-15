Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeEOBWH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 21:22:07 -0400
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:46769 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752031AbeEOBWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 21:22:06 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1536:1559:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3868:4321:5007:8957:10004:10400:10848:11026:11232:11473:11658:11914:12196:12296:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: truck65_2f2030c9d781b
X-Filterd-Recvd-Size: 1582
Message-ID: <56600822d01be60bd96c45afe1bbcad823ac948d.camel@perches.com>
Subject: Re: [PATCH 18/18] rcu: Use pr_fmt to prefix "rcu: " to logging
 output
From: Joe Perches <joe@perches.com>
To: paulmck@linux.vnet.ibm.com
Cc: Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org
Date: Mon, 14 May 2018 18:22:02 -0700
In-Reply-To: <20180515003205.GT26088@linux.vnet.ibm.com>
References: <cover.1525964381.git.joe@perches.com>
         <41d9686471d67f6f98d160e5891bf61061515b6d.1525964386.git.joe@perches.com>
         <20180514202910.GI26088@linux.vnet.ibm.com>
         <32216d8f154b29400d4c11bae91850591114f7f8.camel@perches.com>
         <20180514222456.GO26088@linux.vnet.ibm.com>
         <3c7770a062355650fb61e48a5fbeb9653d98d85a.camel@perches.com>
         <20180514235832.GR26088@linux.vnet.ibm.com>
         <0cb282d85c37d9b626933a03574848d17430f04c.camel@perches.com>
         <20180515003205.GT26088@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-14 at 17:32 -0700, Paul E. McKenney wrote:
> So this change does not affect WARN_ON_ONCE() and friends?

Changing define pr_fmt does not modify WARN_ON output.
