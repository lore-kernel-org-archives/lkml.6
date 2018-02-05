Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeBEVvH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:51:07 -0500
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]:38879 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752029AbeBEVvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:51:01 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3865:3866:3867:3870:3871:3872:3874:4250:4321:5007:6117:7901:10004:10400:10848:11232:11658:11914:12048:12740:12760:12895:13069:13095:13311:13357:13439:14659:21080:21433:21611:21627:30045:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: drug92_428ba627a6e2a
X-Filterd-Recvd-Size: 1634
Message-ID: <1517867453.7489.261.camel@perches.com>
Subject: Re: [PATCH v2 15/16] mmc: sdhci-omap: Add SPDX identifier
From: Joe Perches <joe@perches.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Mon, 05 Feb 2018 13:50:53 -0800
In-Reply-To: <20180205125029.21570-16-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
         <20180205125029.21570-16-kishon@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding Kate Stewart)

On Mon, 2018-02-05 at 18:20 +0530, Kishon Vijay Abraham I wrote:
> The SPDX identifier is a legally binding shorthand,

As far as I know that "legally binding" bit is unproven.
So maybe, maybe not.

I don't doubt that it should be added, but I would be
hesitant to state in a commit message that it is
legally binding.

> which can be used
> instead of the full boiler plate text.

I would also be hesitant to remove existing license text.
