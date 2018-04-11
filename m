Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbeDKIJh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:09:37 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:52682 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbeDKIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:09:35 -0400
Date: Wed, 11 Apr 2018 10:09:31 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        kvm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfio: platform: Fix reset module leak in error
 path
Message-ID: <20180411080930.6knha76gu5f6qgnw@verge.net.au>
References: <1523375627-23746-1-git-send-email-geert+renesas@glider.be>
 <1523375627-23746-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523375627-23746-2-git-send-email-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 05:53:46PM +0200, Geert Uytterhoeven wrote:
> If the IOMMU group setup fails, the reset module is not released.
> 
> Fixes: b5add544d677d363 ("vfio, platform: make reset driver a requirement by default")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
