Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeBAD5I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 22:57:08 -0500
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:54812 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751190AbeBAD5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 22:57:04 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3867:3868:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:8531:8985:9025:10004:10400:10848:11232:11658:11914:12043:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21611:21627:30012:30054:30064:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: farm99_3d767c903ca19
X-Filterd-Recvd-Size: 1660
Message-ID: <1517457420.7489.24.camel@perches.com>
Subject: Re: [PATCH 1/2] dmaengine: dmatest: change symbolic permissions to
 octal values
From: Joe Perches <joe@perches.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vinod.koul@intel.com>
Cc: Yang Shunyong <shunyong.yang@hxt-semitech.com>,
        Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 31 Jan 2018 19:57:00 -0800
In-Reply-To: <CAOh2x=kE4uKYnVs0tWnjBHk0t=BQp+=otr89+NHZ0m2GWbNRrA@mail.gmail.com>
References: <1516617881-30044-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <20180129044801.GL18649@localhost>
         <CAOh2x=naBBc-Os=+yFocc3fTri2pebMqdR4=qN+vpHrD0gvunQ@mail.gmail.com>
         <20180201034507.GZ18649@localhost>
         <CAOh2x=kE4uKYnVs0tWnjBHk0t=BQp+=otr89+NHZ0m2GWbNRrA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-01 at 09:16 +0530, Viresh Kumar wrote:
> On Thu, Feb 1, 2018 at 9:15 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> > Right but lets no go changing to octals everywhere, new code sure :)
> > I don't see plans to remove representations entirely from kernel yet.
> 
> Sure. I was just pointing out to the discussion where the *preferred* thing
> happened.

Not really true.  Linus prefers actual octal
and suggested treewide conversions.

https://lwn.net/Articles/696229/
