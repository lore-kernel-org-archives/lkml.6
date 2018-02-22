Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932093AbeBVLe7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:34:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59563 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753669AbeBVLe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:34:57 -0500
Message-ID: <1519299294.7447.4.camel@pengutronix.de>
Subject: Re: [PATCH v4] reset: add support for non-DT systems
From: Philipp Zabel <p.zabel@pengutronix.de>
To: David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>
Date: Thu, 22 Feb 2018 12:34:54 +0100
In-Reply-To: <8ef4b901-f38d-d885-e7bc-657202a2e248@lechnology.com>
References: <20180219165837.28913-1-brgl@bgdev.pl>
         <72cd2af4-ed6b-8c1b-2488-b999976b894a@lechnology.com>
         <1519123185.3470.5.camel@pengutronix.de>
         <8ef4b901-f38d-d885-e7bc-657202a2e248@lechnology.com>
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

On Tue, 2018-02-20 at 10:40 -0600, David Lechner wrote:
[...]
> > In your case the platform code that adds the lookup may be identical to
> > the code that registers the struct reset_controller_dev, but that
> > doesn't have to be the case. I'm not sure how that is supposed to work
> > for the phy framework (I see no platform code adding phy lookups, only
> > drivers).
> > 
> In our use case, we would be adding the lookup in the driver rather than
> in the platform code, which is why I am suggesting doing it like the phy
> framework.

Shouldn't it be the job of the platform code to describe the connections
between reset controller and peripheral module reset
inputs?

regards
Philipp
