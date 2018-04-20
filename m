Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754306AbeDTJbc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:31:32 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:38519 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754202AbeDTJbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:31:31 -0400
Date: Fri, 20 Apr 2018 11:31:25 +0200
From: Simon Horman <horms@verge.net.au>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: magnus.damm@gmail.com, geert@linux-m68k.org,
        laurent.pinchart@ideasonboard.com, niklas.soderlund@ragnatech.se,
        sergei.shtylyov@cogentembedded.com, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH v3 2/5] arm64: dts: renesas: r8a77970: add VSPD support
Message-ID: <20180420093125.apsnijk744z2g5l2@verge.net.au>
References: <1523520841-16455-1-git-send-email-jacopo+renesas@jmondi.org>
 <1523520841-16455-3-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523520841-16455-3-git-send-email-jacopo+renesas@jmondi.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 10:13:58AM +0200, Jacopo Mondi wrote:
> From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Describe VSPD0 in the R8A77970 device tree; it will be used by DU in
> the next patch...
> 
> Based on the original (and large) patch by Daisuke Matsushita
> <daisuke.matsushita.ns@hitachi.com>.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, applied.
