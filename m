Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbeERQFe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:05:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58789 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbeERQF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:05:28 -0400
Message-ID: <1526659527.3948.16.camel@pengutronix.de>
Subject: Re: [PATCH] gpu: ipu-csi: add rgb/bgr888 24bit support to
 mbus_code_to_bus_cfg
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
        dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
Date: Fri, 18 May 2018 18:05:27 +0200
In-Reply-To: <20180502125226.24149-1-m.grzeschik@pengutronix.de>
References: <20180502125226.24149-1-m.grzeschik@pengutronix.de>
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

On Wed, 2018-05-02 at 14:52 +0200, Michael Grzeschik wrote:
> The 24bit RGB format configuration is currently missing, we add
> it now.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Applied to imx-drm/next.

regards
Philipp
