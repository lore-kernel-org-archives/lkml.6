Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753020AbeC1T0u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:26:50 -0400
Received: from smtprelay0181.hostedemail.com ([216.40.44.181]:60712 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752611AbeC1T0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:26:48 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1537:1560:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3874:4321:5007:6742:10004:10400:10848:11232:11658:11914:12050:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:21080:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: flock42_1df35ccacb00b
X-Filterd-Recvd-Size: 1607
Message-ID: <1522265204.12357.128.camel@perches.com>
Subject: Re: [PATCH] mm: Use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Wed, 28 Mar 2018 12:26:44 -0700
In-Reply-To: <20180328190726.GR9275@dhcp22.suse.cz>
References: <2e032ef111eebcd4c5952bae86763b541d373469.1522102887.git.joe@perches.com>
         <20180328130623.GB8976@dhcp22.suse.cz>
         <1522251891.12357.102.camel@perches.com>
         <20180328190726.GR9275@dhcp22.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-28 at 21:07 +0200, Michal Hocko wrote:
> I wasn't aware that checkpatch can perform changes as well.

Someone (probably me) should write some better documentation
for checkpatch one day.

The command-line --help output isn't obvious.
