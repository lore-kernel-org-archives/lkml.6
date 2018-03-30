Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeC3QTY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 12:19:24 -0400
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:50163 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751239AbeC3QTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 12:19:23 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1567:1593:1594:1711:1714:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3866:3870:3871:4321:5007:10004:10400:10848:11232:11658:11914:12043:12555:12740:12760:12895:13069:13095:13311:13357:13439:13870:14659:14721:21080:21212:21433:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: week16_6ebfb0795bb25
X-Filterd-Recvd-Size: 1659
Message-ID: <1522426759.2210.46.camel@perches.com>
Subject: Re: [PATCH] ISDN: eicon: message: remove redundant check
From: Joe Perches <joe@perches.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Armin Schindler <mac@melware.de>, Karsten Keil <isdn@linux-pingi.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2018 09:19:19 -0700
In-Reply-To: <20180330154648.GA13995@embeddedgus>
References: <20180330154648.GA13995@embeddedgus>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-30 at 10:46 -0500, Gustavo A. R. Silva wrote:
> Check on plci->internal_command is unnecessary.

Probably all of these are unnecessary too:

$ for length in {7..2} ; do \
    grep-2.5.4 -rP --include=*.[ch] -n "^\t{$length,$length}break;\n\t{$(($length-1)),$(($length-1))}break;" * ; \
  done
drivers/staging/wilc1000/wilc_wlan.c:691:				break;
			break;
drivers/media/dvb-frontends/drxd_hard.c:2261:				break;
			break;
drivers/media/dvb-frontends/drxd_hard.c:2266:				break;
			break;
drivers/media/usb/gspca/sn9c20x.c:1860:			break;
		break;
drivers/isdn/i4l/isdn_common.c:624:			break;
		break;
drivers/isdn/i4l/isdn_common.c:642:			break;
		break;
drivers/isdn/i4l/isdn_common.c:654:			break;
		break;
drivers/isdn/hardware/eicon/message.c:13890:			break;
		break;
sound/usb/mixer_quirks.c:1832:			break;
		break;
