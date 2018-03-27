Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeC0J0V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:26:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40055 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeC0J0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:26:19 -0400
Message-ID: <1522142748.3345.7.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/8] ARM: davinci: complete the conversion to using
 the reset framework
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 27 Mar 2018 11:25:48 +0200
In-Reply-To: <20180327092031.11251-1-brgl@bgdev.pl>
References: <20180327092031.11251-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-27 at 11:20 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series converts the only user of the handcoded, mach-specific reset
> routines in the davinci platform to using the reset framework.
> 
> Patches 1-3 add necessary lookups/DT-properties.
> 
> Patches 4-6 fix issues found in the remoteproc davinci driver.
> 
> Patch 7 converts the davinci-rproc driver to the reset framework.
> 
> Patch 8 removes now dead code.
> 
> Philipp: it turned out that it's indeed better to use the reset
> controller's device name for the entry lookup.
> 
> Tested both in DT and legacy modes by booting the examples from
> ti-ipc-rtos recipe in meta-ti.
> 
> This series applies on top of David Lechner's common-clk-v9 branch[1]
> with Philipp Zabel's reset/next branch[2] pulled in.
> 
> It can be found in my github tree as well[3].
> 
> [1] git://github.com/dlech/ev3dev-kernel.git common-clk-v9
> [2] git://git.pengutronix.de/git/pza/linux reset/next

I have moved the relevant patches onto a separate, immutable branch,
which is merged into reset/next:

  git://git.pengutronix.de/git/pza/linux reset/lookup

regards
Philipp
