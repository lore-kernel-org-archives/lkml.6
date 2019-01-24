Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC35C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3878321855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfAXKK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:10:56 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53825 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXKK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:10:56 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gmby8-0007Ex-1K; Thu, 24 Jan 2019 11:10:44 +0100
Message-ID: <1548324643.6014.8.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/3] firmware: xilinx: Add reset API's
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Michal Simek <michal.simek@xilinx.com>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, rajanv@xilinx.com,
        jollys@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com
Date:   Thu, 24 Jan 2019 11:10:43 +0100
In-Reply-To: <e0f6e1d3-e443-040e-8c07-79359e2af37a@xilinx.com>
References: <20190125074654.10950-1-nava.manne@xilinx.com>
         <20190125074654.10950-2-nava.manne@xilinx.com>
         <1548322989.6014.4.camel@pengutronix.de>
         <e0f6e1d3-e443-040e-8c07-79359e2af37a@xilinx.com>
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

On Thu, 2019-01-24 at 10:49 +0100, Michal Simek wrote:
> On 24. 01. 19 10:43, Philipp Zabel wrote:
> > On Fri, 2019-01-25 at 13:16 +0530, Nava kishore Manne wrote:
> > > This Patch Adds reset API's to support release, assert
> > > and status functionalities by using firmware interface.
> > > 
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > 
> > Michal, Should I merge this through the reset tree together with the
> > reset driver?
> 
> It would be better if this goes via my tree. There is at least one
> series which also touches the same parts in these files that's why there
> will be collisions.
> 
> If you can review that I will take it via my tree and arm-soc guys to
> mainline.

Ok, thanks. Feel free to add my

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

to to reset patches and pick them up together into your tree.

regards
Philipp
