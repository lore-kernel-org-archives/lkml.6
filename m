Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755796AbeDCXIW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 19:08:22 -0400
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:52182 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753948AbeDCXIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 19:08:21 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3866:3871:4321:5007:8660:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13095:13148:13230:13255:13311:13357:13439:14659:21080:21433:21627:30012:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: month60_82c5589634f03
X-Filterd-Recvd-Size: 1544
Message-ID: <1522796897.11653.73.camel@perches.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake:
 "Stoping" -> "Stopping"
From: Joe Perches <joe@perches.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Colin King <colin.king@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
Date: Tue, 03 Apr 2018 16:08:17 -0700
In-Reply-To: <20180403185423.GA8683@lenoch>
References: <20180330154420.6903-1-colin.king@canonical.com>
         <20180403134540.GA29017@lenoch> <1522770597.11653.49.camel@perches.com>
         <20180403173044.GA6031@lenoch> <1522779423.11653.63.camel@perches.com>
         <20180403185423.GA8683@lenoch>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-03 at 20:54 +0200, Ladislav Michl wrote:
> > 
> > No  dai device.
> 
> As all call sites are already providing error message, so what about just
> removing this one completely?

No idea, none of this is code I know or care about.
Do what's appropriate.
