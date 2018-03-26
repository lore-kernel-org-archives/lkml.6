Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeCZXFT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 19:05:19 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:34029 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752035AbeCZXFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 19:05:18 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2691:2828:2859:2917:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6742:8985:9025:10004:10400:10848:11658:11914:12043:12679:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21326:21451:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: skin28_4b1c3eef5eb1e
X-Filterd-Recvd-Size: 1725
Message-ID: <1522105514.12357.38.camel@perches.com>
Subject: Re: [PATCH] mm: Use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: David Rientjes <rientjes@google.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Mon, 26 Mar 2018 16:05:14 -0700
In-Reply-To: <alpine.DEB.2.20.1803261535460.93873@chino.kir.corp.google.com>
References: <2e032ef111eebcd4c5952bae86763b541d373469.1522102887.git.joe@perches.com>
         <alpine.DEB.2.20.1803261535460.93873@chino.kir.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-26 at 15:36 -0700, David Rientjes wrote:
> extending some of these lines to be >80 characters also improves 
> the readability imo.

Right.

I have no personal objection to very occasionally using
line lengths < ~100 chars instead of 80.

AFAIK: neither does Linus.

https://lkml.org/lkml/2016/12/15/749

Beyond that, I believe it's too much left-right eyeball
movement for quick and easy reading comprehension.
