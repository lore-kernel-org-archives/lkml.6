Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnxjE0sj"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EDB760764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932350AbeFFHol (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:44:41 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38592 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932216AbeFFHoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:44:39 -0400
X-Google-Smtp-Source: ADUXVKLGlFqpNqrSU29CIXMMwPFydhBuVjHyCuX6Xe6XoCJZm7GYi9F15MDvuE2g/f6Aapt9v9qSPg==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Wed, 6 Jun 2018 10:44:34 +0300
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, mazziesaccount@gmail.com,
        linux-clk@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v3 6/6] regulator: bd71837: BD71837 PMIC regulator driver
Message-ID: <20180606074434.GE20078@localhost.localdomain>
References: <cover.1527587295.git.matti.vaittinen@fi.rohmeurope.com>
 <68b0cf2c7ab5578eef2f71a33315bc8ab9a68a39.1527587295.git.matti.vaittinen@fi.rohmeurope.com>
 <CAHp75VeVSbZd12vXew9f0z2m1=BFz+cOKomga3SZEzg=kx9CFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeVSbZd12vXew9f0z2m1=BFz+cOKomga3SZEzg=kx9CFw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jun 05, 2018 at 04:58:43PM +0300, Andy Shevchenko wrote:
> On Tue, May 29, 2018 at 1:02 PM, Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> > Support for controlling the 8 bucks and 7 LDOs the PMIC contains.
> 

Thanks for the comments Andy. The regulator part of patch set v4 was
already applied by Mark but I am going to do some further work on this
afer I get the MFD and clk portions done. I'll store these comments and
address issues in next set of patches.

Br,
	Matti Vaittinen
