Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C550C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111E8205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394290AbfAPQro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:47:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35715 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbfAPQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:47:44 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gjoLr-0000gN-2x; Wed, 16 Jan 2019 17:47:39 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gjoLq-0003Un-4i; Wed, 16 Jan 2019 17:47:38 +0100
Date:   Wed, 16 Jan 2019 17:47:38 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-i2c@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, wsa@the-dreams.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabio.estevam@nxp.com, leoyang.li@nxp.com
Subject: Re: [PATCH v2 1/2] i2c: imx: fix dma_request_chan error handling
Message-ID: <20190116164738.ax5mmj2hqse3sqck@pengutronix.de>
References: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jan 16, 2019 at 01:28:54PM +0200, Laurentiu Tudor wrote:
> Use the correct error pointer when extracting the error code.
> 
> Fixes: ea1e5f176e97 ("i2c: imx: notify about real errors on dma i2c_imx_dma_request")
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
