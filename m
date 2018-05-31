Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbeEaHVw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:21:52 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41690 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbeEaHVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:21:49 -0400
X-Google-Smtp-Source: ADUXVKKHu+6NNZKCDjhXqy2u9pfC5ze2wJbTXxZ39QzBWZbLTTVlBygQMx32n9v6mQpJdfoLfPSobg==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Thu, 31 May 2018 10:21:45 +0300
To: Rob Herring <robh@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v4 3/6] regulator: bd71837: Devicetree bindings for
 BD71837 regulators
Message-ID: <20180531072145.GH13528@localhost.localdomain>
References: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <318229ca7ffcceb090fc8d0c43f887decc3082f0.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <20180531030436.GB16122@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180531030436.GB16122@rob-hp-laptop>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 10:04:36PM -0500, Rob Herring wrote:
> On Wed, May 30, 2018 at 11:42:32AM +0300, Matti Vaittinen wrote:
> > Document devicetree bindings for ROHM BD71837 PMIC regulators.
> > +ROHM BD71837 Power Management Integrated Circuit (PMIC) regulator bindings
> > +
> > +BD71837MWV is a programmable Power Management
> > +IC (PMIC) for powering single-core, dual-core, and
> > +quad-core SoC’s such as NXP-i.MX 8M. It is optimized
> > +for low BOM cost and compact solution footprint. It
> > +integrates 8 Buck regulators and 7 LDO’s to provide all
> > +the power rails required by the SoC and the commonly
> > +used peripherals.
> 
> Why duplicate this from the core binding?

I can remove this. I just thought it is nice to see what this chip is
doing even without opening the MFD binding doc. Just same question as in
the other patch - how should I deliver the change? This was already
applied to Mark's tree - should I do new patch on top of the Mark's tree
- or do patch against tree which does not yet contain this change? If I
  do it on top of Mark's tree then Mark should apply it, right? If I do
 it against some other three, thene there will be merge conflict with
 Mark, right?

> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks!

Br,
    Matti Vaittinen
