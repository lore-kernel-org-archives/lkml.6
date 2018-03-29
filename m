Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeC2NSk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:18:40 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:38914 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751227AbeC2NSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:18:39 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3867:3870:3872:4250:4321:4362:5007:6119:7903:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12296:12438:12740:12760:12895:13069:13141:13230:13311:13357:13439:13869:14659:14721:21063:21080:21433:21499:21627:30005:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: land91_4b5192ad89f32
X-Filterd-Recvd-Size: 2075
Message-ID: <1522329516.2210.32.camel@perches.com>
Subject: Re: [PATCH] qed: fix a bunch of spelling mistakes/typos
From: Joe Perches <joe@perches.com>
To: Colin Ian King <colin.king@canonical.com>,
        Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 29 Mar 2018 06:18:36 -0700
In-Reply-To: <96d001c9-9e14-9b5a-b0ca-a2e402840351@canonical.com>
References: <20180329124144.27841-1-colin.king@canonical.com>
         <1522328485.2210.30.camel@perches.com>
         <96d001c9-9e14-9b5a-b0ca-a2e402840351@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-29 at 14:13 +0100, Colin Ian King wrote:
> On 29/03/18 14:01, Joe Perches wrote:
> > On Thu, 2018-03-29 at 13:41 +0100, Colin King wrote:
> > > Trivial fix to spelling mistakes/typos in various DP_* messages.
> > 
> > []
> > > diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
> > 
> > []
> > > @@ -231,7 +231,7 @@ static void qed_vf_pf_acquire_reduce_resc(struct qed_hwfn *p_hwfn,
> > >  {
> > >  	DP_VERBOSE(p_hwfn,
> > >  		   QED_MSG_IOV,
> > > -		   "PF unwilling to fullill resource request: rxq [%02x/%02x] txq [%02x/%02x] sbs [%02x/%02x] mac [%02x/%02x] vlan [%02x/%02x] mc [%02x/%02x] cids [%02x/%02x]. Try PF recommended amount\n",
> > > +		   "PF unwilling to fulfil resource request: rxq [%02x/%02x] txq [%02x/%02x] sbs [%02x/%02x] mac [%02x/%02x] vlan [%02x/%02x] mc [%02x/%02x] cids [%02x/%02x]. Try PF recommended amount\n",
> > 
> > Substituting one typo for another
> > 
> > fulfil->fulfill
> > 
> 
> Ah, US english vs non-US english issue. I can resend if required.

Thanks.

OK, nevermind then.  It's not sensible to convert valid spellings.
