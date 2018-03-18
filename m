Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754673AbeCRM5K (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:57:10 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41592 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeCRMwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:52:09 -0400
X-Google-Smtp-Source: AG47ELvf0thIBh4GcyfPwfsa5fW50mi58l7HEccJ9jbgGOjUlL9+DCt3vGoa/SlfLSCBXh2tOP0EFw==
Date: Sun, 18 Mar 2018 07:52:07 -0500
From: Rob Herring <robh@kernel.org>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: mark.rutland@arm.com, heiko@sntech.de, w.egorov@phytec.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: dt-bindings: Add PMIC reset property
Message-ID: <20180318125207.5dotrxc37owbeyyb@rob-hp-laptop>
References: <1521111530-39920-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521111530-39920-1-git-send-email-d.schultz@phytec.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 11:58:50AM +0100, Daniel Schultz wrote:
> Add documentation about a new rk808 devicetree property, which can
> enable resets by the PMIC.

The subject needs to be more specific that this is for Rockchip PMIC.

> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>  Documentation/devicetree/bindings/mfd/rk808.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
> index 91b6522..fa1a30f 100644
> --- a/Documentation/devicetree/bindings/mfd/rk808.txt
> +++ b/Documentation/devicetree/bindings/mfd/rk808.txt
> @@ -20,6 +20,8 @@ Optional properties:
>    default output clock name
>  - rockchip,system-power-controller: Telling whether or not this pmic is controlling
>    the system power.
> +- rockchip,system-reset-controller: Telling whether or not this pmic is controlling
> +  the system reset.

Would you ever really have power and reset controlled by different 
things? IOW, why do we need 2 properties?

Rob
