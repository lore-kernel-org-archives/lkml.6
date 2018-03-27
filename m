Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753795AbeC0Qw6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:52:58 -0400
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:60303 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752026AbeC0Qwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:52:55 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2110:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3743:3865:3866:3867:3868:3870:3871:3872:3873:4321:5007:6119:7903:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:21063:21080:21324:21433:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: angle35_538da28df8052
X-Filterd-Recvd-Size: 1902
Message-ID: <1522169571.12357.81.camel@perches.com>
Subject: Re: [PATCH script] hwmon: Use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        patches@opensource.cirrus.com
Date: Tue, 27 Mar 2018 09:52:51 -0700
In-Reply-To: <9e908abe-2dc8-dbba-97f9-d9614fa4b199@roeck-us.net>
References: <1522096136.12357.21.camel@perches.com>
         <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
         <1522136107.12357.58.camel@perches.com>
         <5ec8703b-2979-7a1d-fbc3-bd528d7a5e29@roeck-us.net>
         <1522151285.12357.78.camel@perches.com>
         <9e908abe-2dc8-dbba-97f9-d9614fa4b199@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-27 at 08:44 -0700, Guenter Roeck wrote:
> On 03/27/2018 04:48 AM, Joe Perches wrote:
> > On Tue, 2018-03-27 at 03:28 -0700, Guenter Roeck wrote:
> > > On 03/27/2018 12:35 AM, Joe Perches wrote:
> > > > On Mon, 2018-03-26 at 23:33 -0700, Guenter Roeck wrote:
> > > > > Since the hwmon subsystem has been labeled as both "obsolete" and "obscure",
[]
> > In what sense do you mean hwmon is obsolete?
[]
> _I_ did not say it was obsolete. It was described as obsolete by a maintainer
> of a different subsystem at a conference a couple of years ago. If I wasn't too
> lazy, I could try to find the presentation, but I don't see the point.

Then it seems you were just being obscure on purpose.
You wrote obsolete without context.

cheers, Joe
