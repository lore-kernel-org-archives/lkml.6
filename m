Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbeE3M6s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:58:48 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:41538 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeE3M6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:58:43 -0400
X-Google-Smtp-Source: ADUXVKKcSAChW9Tff1fAtubwmkSkjiUn9A1kL2UALCE+Hc55VM3YEJmGJwwDNoUwiFe31f/az0Yatw==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Wed, 30 May 2018 15:58:28 +0300
To: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: Applied "regulator: bd71837: BD71837 PMIC regulator driver" to
 the regulator tree
Message-ID: <20180530125828.GF13528@localhost.localdomain>
References: <72e644d9855621ea8cfd7ec555e2da02403f21f6.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <E1fNysa-0006jU-41@debutante>
 <20180530111425.GD13528@localhost.localdomain>
 <20180530111714.GJ6920@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530111714.GJ6920@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 12:17:14PM +0100, Mark Brown wrote:
> On Wed, May 30, 2018 at 02:14:25PM +0300, Matti Vaittinen wrote:
> 
> > The patch 1/6 contains the header file
> > include/linux/mfd/bd71837.h with bunch of definitions this patch is
> > requiring.
> 
> Your driver won't actually get built until the MFD parts end up in the
> same tree since the regulator driver depends on the MFD so there's no
> problem, the code will just sit there and not cause any problems.

Oh, right. Thanks! So MFD and clk portions should go through the other
trees then.

Br,
	Matti Vaittinen
