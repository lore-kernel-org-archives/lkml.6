Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932451AbeE2If4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:35:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37634 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932270AbeE2Ifx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:35:53 -0400
X-Google-Smtp-Source: ADUXVKJctgSmmfuSu36vgju6PGCN6G9qzXpGOaEUE/ovqElhMuhp1qCQ10HoleQrbb8r96hzFB0HwA==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Tue, 29 May 2018 11:35:41 +0300
To: Lee Jones <lee.jones@linaro.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v2 0/6] mfd/regulator/clk: bd71837: ROHM BD71837 PMIC
 driver
Message-ID: <20180529083541.GA13528@localhost.localdomain>
References: <20180528090003.GA8778@localhost.localdomain>
 <20180529073958.GB4790@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529073958.GB4790@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, May 29, 2018 at 08:39:58AM +0100, Lee Jones wrote:
> On Mon, 28 May 2018, Matti Vaittinen wrote:
> 
> > Patch series adding support for ROHM BD71837 PMIC.
> FYI, this patch-set is going to be difficult to manage since it was
> not sent 'threaded'.
> 
> If/when you send a subsequent version, could you please ensure you
> send the set threaded so the patches keep in relation to one another
> as they are reviewed?

Thanks for the guidance. I have not sent so many patches to community so
I am grateful also from all the practical tips =) Just one slight problem.
I have only seen emails being threaded when one is replying to an email.
So how should I send my patches in same thread? Just send first one and
then send subsequent patches as replies?

I just killed some unused definitions and one unused variable from the
code so I am about to send new version. I'll try doing that as a threaded
series and resend all the patches as v3.

Br,
	Matti Vaittinen
