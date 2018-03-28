Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeC1UoS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 16:44:18 -0400
Received: from smtprelay0015.hostedemail.com ([216.40.44.15]:38263 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752090AbeC1UoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 16:44:17 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:965:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:1978:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3872:3873:3874:4321:4390:5007:10004:10400:10848:11232:11658:11914:12296:12679:12740:12760:12895:13069:13095:13161:13229:13311:13357:13439:14181:14659:14721:21080:21433:21627:21740:30054:30070:30083:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: dirt27_7c694a1a4842e
X-Filterd-Recvd-Size: 1704
Message-ID: <1522269853.12357.135.camel@perches.com>
Subject: Re: [PATCH v4 14/16] powerpc: Use generic free_initrd_mem.
From: Joe Perches <joe@perches.com>
To: Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 28 Mar 2018 13:44:13 -0700
In-Reply-To: <20180328203659.18692-15-shea@shealevy.com>
References: <20180328152714.6103-1-shea@shealevy.com>
         <20180328203659.18692-1-shea@shealevy.com>
         <20180328203659.18692-15-shea@shealevy.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-28 at 16:36 -0400, Shea Levy wrote:
> Signed-off-by: Shea Levy <shea@shealevy.com>

Most people seem to want some form of commit message
and not just your sign-off.

And btw:

It seems you used get_maintainer to determine who to
send these patches to.

I suggest you add --nogit and --nogit-fallback to the
get_maintainer command line you use to avoid sending
these patches to people like me that have done drive-by
cleanup work on these files.
