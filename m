Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754324AbeDZIaH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:30:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44255 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754213AbeDZI35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:29:57 -0400
Date: Thu, 26 Apr 2018 10:29:51 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] gpio: eic: Add edge trigger emulation for EIC
Message-ID: <20180426082951.rfnyyd3d6ux65ld5@pengutronix.de>
References: <bdaaa8823cc3aef44352ee867fb6274278f2a2a9.1522392153.git.baolin.wang@linaro.org>
 <CACRpkdY+rbEqk3CqkrD09WEO=zLsD4VK1P56K4o=k_4gATaS0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdY+rbEqk3CqkrD09WEO=zLsD4VK1P56K4o=k_4gATaS0w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On Thu, Apr 26, 2018 at 10:10:11AM +0200, Linus Walleij wrote:
> On Fri, Mar 30, 2018 at 9:02 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> 
> > The Spreadtrum debounce EIC and latch EIC can not support edge trigger,
> > but most GPIO users (like gpio-key driver) only use the edge trigger,
> > thus the EIC driver need add some support to emulate the edge trigger
> > to satisfy this requirement.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> 
> Patch applied.
> 
> The patch is fine and in line with other kernel drivers doing edge
> trigger emulation and we do not hold back on useful features.
> 
> But I want to take this opportunity to ping Uwe Kleine-König about
> his ideas for an edge trigger emulation library in the gpiolib core,
> and whether this also follows the pattern.

up to now it's still only this: an idea.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
