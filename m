Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeEPHet (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:34:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60473 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeEPHed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:34:33 -0400
Date: Wed, 16 May 2018 09:33:51 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, David Brown <david.brown@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>, openbmc@lists.ozlabs.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Joel Stanley <joel@jms.id.au>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andy Gross <andy.gross@linaro.org>,
        Peter Korsgaard <jacmet@sunsite.dk>, linuxppc-dev@lists.ozlabs.org,
        Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: busses: make use of i2c_8bit_addr_from_msg
Message-ID: <20180516073351.y5avitvaj5ouu6m3@pengutronix.de>
References: <20180516071647.29277-1-peda@axentia.se>
 <20180516071647.29277-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180516071647.29277-3-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

On Wed, May 16, 2018 at 09:16:47AM +0200, Peter Rosin wrote:
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de> [emf32 and imx]

s/emf/efm/

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
