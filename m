Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeERRw5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:52:57 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:43988 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750763AbeERRwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:52:54 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3868:3870:3871:3872:3873:4321:5007:6120:7901:7903:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14659:21080:21451:21627:30012:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: salt08_8d910e94a192e
X-Filterd-Recvd-Size: 1443
Message-ID: <691d9a5d264ec9e3b99a291f9da4f890aa52d27d.camel@perches.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
From: Joe Perches <joe@perches.com>
To: Nadav Amit <namit@vmware.com>, Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>
Date: Fri, 18 May 2018 10:52:50 -0700
In-Reply-To: <B7EA94A4-5AFD-4ED6-BD90-9A5E417FCECB@vmware.com>
References: <20180517161402.78089-1-namit@vmware.com>
         <20180517161402.78089-3-namit@vmware.com>
         <20180518075853.GD12217@hirez.programming.kicks-ass.net>
         <B7EA94A4-5AFD-4ED6-BD90-9A5E417FCECB@vmware.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-18 at 14:22 +0000, Nadav Amit wrote:
> It is hard to make the code readable in C, readable in the generated asm,
> and to follow the coding style imposed by checkpatch (e.g., no space between
> the newline and the asm argument before it).

Ignore checkpatch when you know better.
