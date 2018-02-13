Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965552AbeBMSu7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:50:59 -0500
Received: from smtprelay0061.hostedemail.com ([216.40.44.61]:46001 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965425AbeBMSu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:50:56 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:800:960:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2540:2553:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3866:3867:3873:4321:5007:7809:7903:8527:10004:10400:10471:10848:11232:11658:11914:12043:12663:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21212:21433:21451:21611:21627:30054:30059:30065:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: snake91_7bceef0b9b74c
X-Filterd-Recvd-Size: 1592
Message-ID: <1518547848.22190.50.camel@perches.com>
Subject: Re: [PATCH] efi/apple-properties: Delete an error message for a
 failed memory allocation in unmarshal_devices()
From: Joe Perches <joe@perches.com>
To: Lukas Wunner <lukas@wunner.de>,
        SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Tue, 13 Feb 2018 10:50:48 -0800
In-Reply-To: <20180213184033.GA24299@wunner.de>
References: <145f8fac-9297-b362-d89f-886632e2507f@users.sourceforge.net>
         <20180213184033.GA24299@wunner.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-13 at 19:40 +0100, Lukas Wunner wrote:
> On Tue, Feb 13, 2018 at 06:00:26PM +0100, SF Markus Elfring wrote:
> > --- a/drivers/firmware/efi/apple-properties.c
> You didn't cc me on your submission even though I'm the author of
> 99% of this file.  Please make an effort prior to submission to
> identify interested parties.

If you want to receive patches for this file, even
if you are not a maintainer or an upstream path,
you should add yourself as a reviewer to the
MAINTAINERS file like:

APPLE EFI PROPERTIES
R:	Lukas Wunner <lukas@wunner.de>
F:	drivers/firmware/efi/apple-properties.c
