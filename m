Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbeCYXwM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 19:52:12 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32893 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeCYXwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 19:52:10 -0400
X-Google-Smtp-Source: AG47ELurHU5mPiXebdqjFns4HQVAMD2An7YnprKEnJ5ZLL6M9kIXLfdQ2rOArU24Ku8/EyXiyvZG2g==
Date: Sun, 25 Mar 2018 18:52:05 -0500
From: Rob Herring <robh@kernel.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, jcliang@chromium.org,
        robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
        Mark Rutland <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 09/14] dt-bindings: iommu/rockchip: Add clock property
Message-ID: <20180325235205.fkrz3chbkfj7eo64@rob-hp-laptop>
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
 <20180323073814.5802-10-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323073814.5802-10-jeffy.chen@rock-chips.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 03:38:09PM +0800, Jeffy Chen wrote:
> Add clock property, since we are going to control clocks in rockchip
> iommu driver.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---

Reviewed-by: Rob Herring <robh@kernel.org>
