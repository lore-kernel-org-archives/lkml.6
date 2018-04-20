Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754375AbeDTJtB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:49:01 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:38740 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754194AbeDTJs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:48:59 -0400
Date: Fri, 20 Apr 2018 11:48:55 +0200
From: Simon Horman <horms@verge.net.au>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: magnus.damm@gmail.com, geert@linux-m68k.org,
        laurent.pinchart@ideasonboard.com, niklas.soderlund@ragnatech.se,
        sergei.shtylyov@cogentembedded.com, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas =?utf-8?Q?S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH v3 5/5] arm64: dts: renesas: eagle: Enable HDMI output
Message-ID: <20180420094855.ikfsjjn4m7vp54fp@verge.net.au>
References: <1523520841-16455-1-git-send-email-jacopo+renesas@jmondi.org>
 <1523520841-16455-6-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523520841-16455-6-git-send-email-jacopo+renesas@jmondi.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 10:14:01AM +0200, Jacopo Mondi wrote:
> Enable HDMI output on Renesas R-Car V3M Eagle board.
> 
> The HDMI ouput is enabled connecting the DU LVDS output to the

s/ouput/output/

> transparent LVDS converter THC63LVD1024, and successively routing its
> RGB output to the ADV7511W HDMI encoder.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> [for THC63LVD1024: ]
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Thanks, applied.
