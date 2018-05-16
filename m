Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeEPHtT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:49:19 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:51191 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeEPHtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:49:15 -0400
Date: Wed, 16 May 2018 09:49:11 +0200
From: Simon Horman <horms@verge.net.au>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com,
        geert@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: media: rcar-vin: Add R8A77995 support
Message-ID: <20180516074911.7wecz52sldocczyn@verge.net.au>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526032802-14376-2-git-send-email-jacopo+renesas@jmondi.org>
 <20180511133513.25dldevvnlnxl7y6@verge.net.au>
 <20180515083627.GR5956@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515083627.GR5956@w540>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 10:36:27AM +0200, jacopo mondi wrote:
> Hi Simon,
> 
> On Fri, May 11, 2018 at 03:35:14PM +0200, Simon Horman wrote:
> > On Fri, May 11, 2018 at 12:00:00PM +0200, Jacopo Mondi wrote:
> > > Add compatible string for R-Car D3 R8A7795 to list of SoCs supported by
> > > rcar-vin driver.
> > >
> > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> >
> 
> Does this goes in through your tree? I will send a v2, should I
> include this one or you have collected it already?

No, it means I am reviewing it with the expectation that it will
go through someone else's tree. So if you need to post a v2 please include
this patch with my Reviewed-by tag.
