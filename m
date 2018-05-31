Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755484AbeEaPPu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:15:50 -0400
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:60285 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755134AbeEaPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:15:49 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3352:3622:3867:3871:3872:4321:4384:5007:7903:10004:10400:10848:11026:11658:11914:12296:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: truck41_6cc0e17656916
X-Filterd-Recvd-Size: 1469
Message-ID: <993c7040bd1e5251abd70ff3aa7e3141f28b3505.camel@perches.com>
Subject: Re: [PATCH] ftrace: use non-archaic spelling of failes
From: Joe Perches <joe@perches.com>
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, mingo@redhat.com
Date: Thu, 31 May 2018 08:15:45 -0700
In-Reply-To: <20180531121701.8972-1-cascardo@canonical.com>
References: <20180531121701.8972-1-cascardo@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-31 at 09:17 -0300, Thadeu Lima de Souza Cascardo wrote:
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
[]
> @@ -4788,7 +4788,7 @@ ftrace_set_addr(struct ftrace_ops *ops, unsigned long ip, int remove,
>   * @reset - non zero to reset all filters before applying this filter.
>   *
>   * Filters denote which functions should be enabled when tracing is enabled
> - * If @ip is NULL, it failes to update filter.
> + * If @ip is NULL, it fails to update filter.
>   */
>  int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
>  			 int remove, int reset)

Perhaps fix it treewide?

$ git grep -w -i failes | wc -l
8
