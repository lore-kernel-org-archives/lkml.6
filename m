Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030574AbeEXRoe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:44:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36685 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968459AbeEXRob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:44:31 -0400
Date: Thu, 24 May 2018 19:44:25 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: imx: drop CTS/RTS handling from shutdown
Message-ID: <20180524174425.2b6b7xb7c6vvrodo@pengutronix.de>
References: <20180524173024.20936-1-sebastian.reichel@collabora.co.uk>
 <20180524173024.20936-2-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180524173024.20936-2-sebastian.reichel@collabora.co.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 07:30:23PM +0200, Sebastian Reichel wrote:
> According to Documentation/serial/driver the shutdown function should
> not disable RTS, so drop it.
> 
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Great idea! :-)

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
