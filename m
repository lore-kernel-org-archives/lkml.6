Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751024AbeDMSch (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 14:32:37 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33383 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeDMScf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 14:32:35 -0400
X-Google-Smtp-Source: AIpwx4//G2mMV86k+meYqzQLlYAR82odGDrJpknZCRp52/GuLWliAU5EtvdeUiT0e04k3ouqLVCJOw==
Date: Fri, 13 Apr 2018 13:32:33 -0500
From: Rob Herring <robh@kernel.org>
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        phil.edworthy@renesas.com, buserror+upstream@gmail.com,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 5/8] dt-bindings: arm: Document the RZN1D-DB board
Message-ID: <20180413183233.2mf7fttoccc3jl2n@rob-hp-laptop>
References: <1523349015-37985-1-git-send-email-michel.pollet@bp.renesas.com>
 <1523349015-37985-6-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523349015-37985-6-git-send-email-michel.pollet@bp.renesas.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 09:30:05AM +0100, Michel Pollet wrote:
> This documents the RZ/N1 bindings for the RZN1D-DB board.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
