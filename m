Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753137AbeCEVJo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 16:09:44 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33327 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeCEVJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 16:09:41 -0500
X-Google-Smtp-Source: AG47ELvR47HxFvqQKwl2iZVnq9OsQED1bDSpQOR0djpdpa0UeE+xfn8V2E//y2u4DZ23DHrPEF2plA==
Date: Mon, 5 Mar 2018 15:09:39 -0600
From: Rob Herring <robh@kernel.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: geert@linux-m68k.org, horms@verge.net.au,
        sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] dt-bindings: iommu/ipmmu-vmsa: Add R-Car M3-N
 (R8A77965)
Message-ID: <20180305210939.c74lfn7jwd3vvolm@rob-hp-laptop>
References: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519667836-31330-6-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519667836-31330-6-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 06:57:13PM +0100, Jacopo Mondi wrote:
> Add Renesas R-Car M3-N (R8A77965) compat string to IPMMU DT bindings
> documentation.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
