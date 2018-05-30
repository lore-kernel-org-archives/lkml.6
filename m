Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeE3LT2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:19:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37732 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752969AbeE3LQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:16:53 -0400
X-Google-Smtp-Source: ADUXVKKEbm5WetIH3mpqsYMpPOq5w35MuyQGXQnacma0uQaDaFL7LSs84sLB59/2chWb1SsJOs9TIA==
Date: Wed, 30 May 2018 12:16:49 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v2 0/6] mfd/regulator/clk: bd71837: ROHM BD71837 PMIC
 driver
Message-ID: <20180530111649.GB8038@dell>
References: <20180528090003.GA8778@localhost.localdomain>
 <20180529073958.GB4790@dell>
 <20180529083541.GA13528@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180529083541.GA13528@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018, Matti Vaittinen wrote:

> Hello,
> 
> On Tue, May 29, 2018 at 08:39:58AM +0100, Lee Jones wrote:
> > On Mon, 28 May 2018, Matti Vaittinen wrote:
> > 
> > > Patch series adding support for ROHM BD71837 PMIC.
> > FYI, this patch-set is going to be difficult to manage since it was
> > not sent 'threaded'.
> > 
> > If/when you send a subsequent version, could you please ensure you
> > send the set threaded so the patches keep in relation to one another
> > as they are reviewed?
> 
> Thanks for the guidance. I have not sent so many patches to community so
> I am grateful also from all the practical tips =) Just one slight problem.
> I have only seen emails being threaded when one is replying to an email.
> So how should I send my patches in same thread? Just send first one and
> then send subsequent patches as replies?
> 
> I just killed some unused definitions and one unused variable from the
> code so I am about to send new version. I'll try doing that as a threaded
> series and resend all the patches as v3.

You don't need to do this manually.

Just use `git send-email` with the correct arguments.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
