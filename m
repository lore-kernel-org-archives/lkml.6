Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeC0HfM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:35:12 -0400
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:35399 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750913AbeC0HfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:35:11 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2540:2559:2563:2612:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3000:3022:3138:3139:3140:3141:3142:3622:3865:3868:3870:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:8784:9025:10004:10400:10848:11232:11658:11914:12043:12679:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:21691:30054:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: dime08_ffcdb8094d49
X-Filterd-Recvd-Size: 1449
Message-ID: <1522136107.12357.58.camel@perches.com>
Subject: Re: [PATCH script] hwmon: Use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        patches@opensource.cirrus.com
Date: Tue, 27 Mar 2018 00:35:07 -0700
In-Reply-To: <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
References: <1522096136.12357.21.camel@perches.com>
         <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-26 at 23:33 -0700, Guenter Roeck wrote:
> Since the hwmon subsystem has been labeled as both "obsolete" and "obscure",

fyi: It's marked Maintained in MAINTAINERS

HARDWARE MONITORING
M:	Jean Delvare <jdelvare@suse.com>
M:	Guenter Roeck <linux@roeck-us.net>
L:	linux-hwmon@vger.kernel.org
W:	http://hwmon.wiki.kernel.org/
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
S:	Maintained
F:	Documentation/hwmon/
F:	drivers/hwmon/
F:	include/linux/hwmon*.h
