Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbeDDI3s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:29:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43361 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbeDDI3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:29:43 -0400
Message-ID: <1522830577.5562.6.camel@pengutronix.de>
Subject: Re: [PATCH] drm/imx: Remove last traces of struct imx_drm_crtc
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, David Airlie <airlied@linux.ie>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Wed, 04 Apr 2018 10:29:37 +0200
In-Reply-To: <CAOMZO5Bojjfi-c5cCCNZvPTidicqVASh=kjc8=ARAR1dYVcm7Q@mail.gmail.com>
References: <ed466ff48d5b23a6225ee6c270d70cf3923dfe05.1522186448.git.leonard.crestez@nxp.com>
         <CAOMZO5Bojjfi-c5cCCNZvPTidicqVASh=kjc8=ARAR1dYVcm7Q@mail.gmail.com>
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

On Tue, 2018-04-03 at 20:56 -0300, Fabio Estevam wrote:
> On Tue, Mar 27, 2018 at 6:39 PM, Leonard Crestez
> <leonard.crestez@nxp.com> wrote:
> > When the definition of this struct was removed a forward declaration and an
> > unused struct member were still left around. Remove them because they serve
> > no purpose.
> > 
> > Fixes 44b460cfe554 ("drm: imx: remove struct imx_drm_crtc and imx_drm_crtc_helper_funcs")
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Thank you, applied to imx-drm/next.

regards
Philipp
