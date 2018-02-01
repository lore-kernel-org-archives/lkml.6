Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeBAH50 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 02:57:26 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55089 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbeBAH5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 02:57:24 -0500
Date: Thu, 1 Feb 2018 08:57:20 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?=
        <benoit.thebaudeau.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: imx25-pinfunc: Always set SION for
 eSDHC CMD
Message-ID: <20180201075720.3fj7ozvclpp6yovz@pengutronix.de>
References: <20180131213544.4508-1-benoit.thebaudeau.dev@gmail.com>
 <20180131213544.4508-2-benoit.thebaudeau.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180131213544.4508-2-benoit.thebaudeau.dev@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 10:35:44PM +0100, Benoît Thébaudeau wrote:
> The eSDHC does not work properly if the SION bit is not set for the
> bidirectional CMD signal, whatever the eSDHC instance and the selected
> pad. Therefore, setting SION is mandatory for all eSDHC CMD ports. Do
> this for MX25_PAD_*__ESDHCn_CMD in imx25-pinfunc.h in order to enforce
> this behavior for all boards.
> 
> This had already been done for eSDHC1, but not for eSDHC2. Also, define
> MX25_PAD_FEC_MDC__ESDHC2_CMD so that all the possible cases are covered
> from now on.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Benoît Thébaudeau <benoit.thebaudeau.dev@gmail.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
