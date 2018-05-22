Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeEVNYV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:24:21 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:40938 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVNYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:24:17 -0400
Date: Tue, 22 May 2018 15:24:13 +0200
From: Simon Horman <horms@verge.net.au>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        niklas.soderlund@ragnatech.se, geert@glider.be, magnus.damm@gmail.com,
        robh+dt@kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] arm64: dts: renesas: draak: Describe CVBS input
Message-ID: <20180522132411.7szrsk4pxvwrqrxf@verge.net.au>
References: <1526913942-15426-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526913942-15426-3-git-send-email-jacopo+renesas@jmondi.org>
 <1958464.yiJe0NDHa3@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1958464.yiJe0NDHa3@avalon>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 05:50:50PM +0300, Laurent Pinchart wrote:
> Hi Jacopo,
> 
> Thank you for the patch.
> 
> On Monday, 21 May 2018 17:45:41 EEST Jacopo Mondi wrote:
> > Describe CVBS video input through analog video decoder ADV7180
> > connected to video input interface VIN4.
> > 
> > The video input signal path is shared with HDMI video input, and
> > selected by on-board switches SW-53 and SW-54 with CVBS input selected
> > by the default switches configuration.
> > 
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks Niklas, applied.
