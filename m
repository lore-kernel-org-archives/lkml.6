Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeC0LsL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:48:11 -0400
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:33206 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750914AbeC0LsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:48:09 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2565:2570:2682:2685:2703:2828:2859:2892:2933:2937:2939:2942:2945:2947:2951:2954:3022:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6117:8985:9025:10004:10400:11658:12740:13069,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: judge42_29ea083f2ad1b
X-Filterd-Recvd-Size: 2161
Message-ID: <1522151285.12357.78.camel@perches.com>
Subject: Re: [PATCH script] hwmon: Use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        patches@opensource.cirrus.com
Date: Tue, 27 Mar 2018 04:48:05 -0700
In-Reply-To: <5ec8703b-2979-7a1d-fbc3-bd528d7a5e29@roeck-us.net>
References: <1522096136.12357.21.camel@perches.com>
         <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
         <1522136107.12357.58.camel@perches.com>
         <5ec8703b-2979-7a1d-fbc3-bd528d7a5e29@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-27 at 03:28 -0700, Guenter Roeck wrote:
> On 03/27/2018 12:35 AM, Joe Perches wrote:
> > On Mon, 2018-03-26 at 23:33 -0700, Guenter Roeck wrote:
> > > Since the hwmon subsystem has been labeled as both "obsolete" and "obscure",
> > 
> > fyi: It's marked Maintained in MAINTAINERS
> > 
> 
> I did not say that it was not maintained, and I am aware of the information
> in the MAINTAINERS file, thanks.

As am I.

I do agree that hwmon is obscure.  Almost everything about
anything is obscure to those that don't fully understand it.

I am unaware though of any use of "obsolete" in drivers/hwmon/
or in Documentation/ about hwmon or the wiki/

In what sense do you mean hwmon is obsolete?

And the cocci script?

Anything later than:
https://systeme.lip6.fr/pipermail/cocci/2016-December/003887.html
https://github.com/groeck/coccinelle-patches/tree/master/hwmon
?

btw: I think the perl scripts I posted for DEV_ATTR_<RW|RO|WO>
transforms are simpler and less prone to tool versioning
issues.

https://lkml.org/lkml/2017/12/22/844

It'd be fairly simple to add SENSOR_ support.
