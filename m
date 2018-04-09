Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754752AbeDIUTe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:19:34 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42239 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbeDIUTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:19:32 -0400
X-Google-Smtp-Source: AIpwx4+yWaUVlyIy9IwwpVm4U9vNfw9bEec7iFxczvqNSvrtbVaebuDBHZoOoqOQvxum1Fo6hhLhLg==
Date: Mon, 9 Apr 2018 15:19:30 -0500
From: Rob Herring <robh@kernel.org>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: mark.rutland@arm.com, heiko@sntech.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: dt-bindings: Add rk808 PMIC reset property
Message-ID: <20180409201930.urz35eovzffrx2mn@rob-hp-laptop>
References: <1522334683-22169-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522334683-22169-1-git-send-email-d.schultz@phytec.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 04:44:43PM +0200, Daniel Schultz wrote:
> Add documentation about a new rk808 devicetree property. This can enable
> the rk805/rk808/rk818 PMIC reset, instead of using soft resets from the
> Control and Reset Module.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
> Changes:
> 	v2: Changed commit message
> 
>  Documentation/devicetree/bindings/mfd/rk808.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
