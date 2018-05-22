Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeEVNY7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:24:59 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:40965 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEVNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:24:56 -0400
Date: Tue, 22 May 2018 15:24:52 +0200
From: Simon Horman <horms@verge.net.au>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com,
        geert@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: renesas: draak: Describe HDMI input
Message-ID: <20180522132452.z7fwnwmac7ass2ix@verge.net.au>
References: <1526913942-15426-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526913942-15426-4-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526913942-15426-4-git-send-email-jacopo+renesas@jmondi.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 04:45:42PM +0200, Jacopo Mondi wrote:
> Describe HDMI input connector and ADV7612 HDMI decoder installed on
> R-Car Gen3 Draak board.
> 
> The video signal routing to the HDMI decoder to the video input interface
> VIN4 is multiplexed with CVBS input path, and enabled/disabled through
> on-board switches SW-49, SW-50, SW-51 and SW-52.
> 
> As the default board switches configuration connects CVBS input to VIN4,
> leave the HDMI decoder unconnected in DTS.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks Jacopo,

applied.
