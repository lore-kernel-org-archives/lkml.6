Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeBJO7u (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 09:59:50 -0500
Received: from smtprelay0048.hostedemail.com ([216.40.44.48]:54242 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751009AbeBJO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 09:59:48 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:46:150:153:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3872:3873:4321:5007:10004:10400:10848:11232:11658:11914:11984:12740:12760:12895:13069:13311:13357:13439:14659:21080:21611:21627:30054:30056:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: coal43_724475e04f146
X-Filterd-Recvd-Size: 1664
Message-ID: <1518274783.6579.2.camel@perches.com>
Subject: Re: Software evolution around
 =?UTF-8?Q?=E2=80=9Ccheckpatch=2Epl=E2=80=9D=3F?=
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Jiri Kosina <jikos@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Sat, 10 Feb 2018 06:59:43 -0800
In-Reply-To: <20180210145336.233c721d@archlinux>
References: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net>
         <20180204112346.0977e938@archlinux>
         <9420fc82-1a37-3601-bafe-f57ef953bfcd@users.sourceforge.net>
         <87DF341A-1356-4B1B-8D25-14D5B0AAB01D@jic23.retrosnub.co.uk>
         <f008911b-c595-6e0f-d85f-076e994ae7db@users.sourceforge.net>
         <20180210145336.233c721d@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-02-10 at 14:53 +0000, Jonathan Cameron wrote:
> While it would be great to improve checkpatches false
> positive rate, it's very nature as a string matcher makes
> this hard.

true.

what are the false positives you see?
