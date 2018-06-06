Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvcdUUvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 873D66070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeFFFKY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 01:10:24 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45495 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeFFFKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 01:10:22 -0400
X-Google-Smtp-Source: ADUXVKJSUSvelqejpInXaxKjzRVAfExOUuXqO1hCaa+ZkoNkAxhsHaem11UTgzySoVNd3GlJi8aU5g==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Wed, 6 Jun 2018 08:10:17 +0300
To: Rob Herring <robh@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v5 3/4] clk: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180606051017.GB20078@localhost.localdomain>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <da121dede6d79460c5653a5bc360d413cb988c74.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <20180605154932.GA20204@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605154932.GA20204@rob-hp-laptop>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 09:49:32AM -0600, Rob Herring wrote:
> On Mon, Jun 04, 2018 at 04:18:53PM +0300, Matti Vaittinen wrote:
> > Document devicetree bindings for ROHM BD71837 PMIC clock output.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  .../bindings/clock/rohm,bd71837-clock.txt          | 38 ++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt b/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
> > new file mode 100644
> > index 000000000000..771acfe34114
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
> > @@ -0,0 +1,38 @@
> > +ROHM BD71837 Power Management Integrated Circuit clock bindings
> 
> This needs to be added to the MFD doc. One node should be covered by at 
> most 1 document.

I was thinking of that too. But then I asked why? I also thought that if
one knows there is clock block in the chip - where does he look for
binding document? From clock folder. Then I saw how bindings for
MAX77686 chip were written and thought that this is beneficial for all.
MFD document directs to clock and regulator docs and on othe other hand,
clock document clearly states that properties it describes must be
present "in main device node of the MFD chip".

Don't you think on searching for clock bindings should find something
from clock folder? I can follow your instruction here but I think
the user might be happy if he found something under bindings/clock for
clock related properties.

Br,
	Matti Vaittinen
