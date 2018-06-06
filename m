Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Seps8p+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1ADD96070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeFFFOm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 01:14:42 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39512 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbeFFFOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 01:14:40 -0400
X-Google-Smtp-Source: ADUXVKINMEXm2y/DxRD7SLt7W/p3uk9V2rwdd4s0ClVP2yTbX0a/Wpu5tGXSmOeNdiucxIkOMtQtwA==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Wed, 6 Jun 2018 08:14:36 +0300
To: Rob Herring <robh@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v5 2/4] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180606051436.GC20078@localhost.localdomain>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <6509bbe0238c20c16930c9f23d63656b1d5f4af2.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <20180605154757.GA26812@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605154757.GA26812@rob-hp-laptop>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 09:47:57AM -0600, Rob Herring wrote:
> On Mon, Jun 04, 2018 at 04:18:30PM +0300, Matti Vaittinen wrote:
> > Document devicetree bindings for ROHM BD71837 PMIC MFD.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 76 ++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> 
> I've replied on the prior version discussion. Please don't send new 
> versions if the last one is still under discussion.

Allright. I thought this was a good way to suggest something which I
thought might address your concerns. But you are correct, it is better
to continue discussion in one emai thread. Sorry for adding this
version. I'll write further replies in v4 thread untill we get some
conclusion.

Br,
	Matti Vaittinen
