Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD09ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EDE2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EDE2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbeGQU53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:57:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55585 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbeGQU53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:57:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B524220728; Tue, 17 Jul 2018 22:23:09 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 55D8C206F6;
        Tue, 17 Jul 2018 22:22:59 +0200 (CEST)
Date:   Tue, 17 Jul 2018 22:22:59 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] mtd: rawnand: ams-delta: use GPIO lookup table
Message-ID: <20180717222259.4145d307@bbrezillon>
In-Reply-To: <1706255.htvcsQMCeE@z50>
References: <20180525222046.11200-1-jmkrzyszt@gmail.com>
        <20180709193850.20191-1-jmkrzyszt@gmail.com>
        <20180717213736.3cd0a747@bbrezillon>
        <1706255.htvcsQMCeE@z50>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 22:20:00 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Hi Boris,
> 
> On Tuesday, July 17, 2018 9:37:36 PM CEST Boris Brezillon wrote:
> > ...
> > Sorry, but we can't apply this patch now because of the dependency on
> > those 2 commits. I guess it's not a big issue if we defer it to 4.20.
> > Alternatively, we could consider queuing it to mtd/fixes after 4.19-rc1
> > is out, but we'll need a good reason to do that (like a regression
> > that this patch is supposed to fix). Note for your future contributions:
> > for this kind of cross-subsystem changes, it's better to let everything
> > go through a single tree (usually done by sending all patches in a
> > single series and explaining the dependencies between the patches in
> > the cover letter),  
> 
> Good advice, Sine I have in my queue a patch for OMAP that depends on this 
> one, and still another one with the same dependency issues, I'll take the path 
> you suggest and resend those three as a series to be merged via OMAP.

Sounds good.

