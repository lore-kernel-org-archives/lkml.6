Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DAFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DC4222D0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392295AbfBNJHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:07:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34309 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436912AbfBNJHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:07:44 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1guCzd-00062W-7O; Thu, 14 Feb 2019 10:07:41 +0100
Message-ID: <1550135260.4571.1.camel@pengutronix.de>
Subject: Re: [PATCH] drm: imx: Use of_node_name_eq for node name comparisons
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Date:   Thu, 14 Feb 2019 10:07:40 +0100
In-Reply-To: <CAL_JsqKPJet11X3pru1u5hEUVUH_SCcmncVAaesfDrzxtUEGEg@mail.gmail.com>
References: <20181205195050.4759-7-robh@kernel.org>
         <CAL_JsqKPJet11X3pru1u5hEUVUH_SCcmncVAaesfDrzxtUEGEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, 2019-02-13 at 12:07 -0600, Rob Herring wrote:
> On Wed, Dec 5, 2018 at 1:50 PM Rob Herring <robh@kernel.org> wrote:
> > 
> > Convert string compares of DT node names to use of_node_name_eq helper
> > instead. This removes direct access to the node name pointer.
> > 
> > For instances using of_node_cmp, this has the side effect of now using
> > case sensitive comparisons. This should not matter for any FDT based
> > system which this is.
> > 
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/gpu/drm/imx/imx-drm-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Philipp, can I get an ack on this? I can commit it.

Thank you,
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
