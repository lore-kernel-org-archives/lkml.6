Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeETIRJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 04:17:09 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:49954 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeETIRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 04:17:08 -0400
From: Richard Weinberger <richard@nod.at>
To: Stefan M Schaeckeler <sschaeck@cisco.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: mtdoops: optionally dump boottime
Date: Sun, 20 May 2018 10:17:05 +0200
Message-ID: <2141312.dtCrDzBczl@blindfold>
In-Reply-To: <20180520033940.GA35444@sjc-ads-587.cisco.com>
References: <20180520033940.GA35444@sjc-ads-587.cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan,

Am Sonntag, 20. Mai 2018, 05:39:40 CEST schrieb Stefan M Schaeckeler:
> Optionally dump boottime on the mtd device in the form of
> 
> <0>[   0.000000] Boot time mm/dd/yyyy hh:mm:ss
> 
> Time-stamps of oops messages are in seconds since boottime. Recording also
> the boottime helps correlating oopses with other events having occured at
> the same time. This correlation will be otherwise lost after (multiple)
> reboots.

I get the use-case, but why is this only for mtdoops?
IMHO this needs to go into generic code such that all kmsg dumpers can
benefit from it.

Thanks,
//richard
