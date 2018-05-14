Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeENScX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:32:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32795 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeENScV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:32:21 -0400
Date: Mon, 14 May 2018 20:32:19 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 12/21] i2c: imx: make use of i2c_8bit_addr_from_msg
Message-ID: <20180514183219.oqjaopmicx4ngmxw@pengutronix.de>
References: <20180514145330.4857-1-peda@axentia.se>
 <20180514145330.4857-13-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180514145330.4857-13-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 04:53:21PM +0200, Peter Rosin wrote:
> Because it looks neater.
> i2c_imx_dma_write and i2c_imx_write are always called with a
> write in msgs->flags, and i2c_imx_read with a read.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
