Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeEUJfV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:35:21 -0400
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:59610 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751027AbeEUJfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:35:20 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7903:9707:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:13548:13618:14181:14659:14721:21080:21088:21451:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: wind05_2e5151cb4ec23
X-Filterd-Recvd-Size: 1924
Message-ID: <09146e67a7227a44e0cab612ea3c02e1bb5bb40b.camel@perches.com>
Subject: Re: [PATCH v3 1/4] rcu: Add comment documenting how rcu_seq_snap
 works
From: Joe Perches <joe@perches.com>
To: Joel Fernandes <joel@joelfernandes.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Colin King <colin.king@canonical.com>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Date: Mon, 21 May 2018 02:35:16 -0700
In-Reply-To: <20180521054826.GA137980@joelaf.mtv.corp.google.com>
References: <20180521044220.123933-1-joel@joelfernandes.org>
         <20180521044220.123933-2-joel@joelfernandes.org>
         <b1f55cf4-c1cc-f755-ad4d-2bd69280cb42@infradead.org>
         <20180521054826.GA137980@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-05-20 at 22:48 -0700, Joel Fernandes wrote:
> Also I realize I need some better automated tools to catch these issues
> (spelling errors in commit, diffs etc). Probably checkpatch.pl should
> have such checks for these common things too.

checkpatch already does typo checking using the input file
scripts/spelling.txt.

You are welcome to add more typos to that file.

and fyi: 'incase||in case' is not there, perhaps because
it is a alternate spelling of encase, but it does seem
every use of "incase" in the kernel should be "in case"

$ git grep -w -i incase | wc -l
43
