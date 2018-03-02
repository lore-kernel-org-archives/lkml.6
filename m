Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946605AbeCBQA0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:00:26 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42117 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423884AbeCBQAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:00:24 -0500
X-Google-Smtp-Source: AG47ELvqKtGkpjX5VaX4YjFKAO3rRBhgQ0AegiiLSFjpelCJLE4AFvef1PFnHJmNzXj9rSPMeRiQRw==
Date: Fri, 2 Mar 2018 10:00:22 -0600
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/19] dt-bindings: arm: mediatek: add support for
 more mt7623 reference boards
Message-ID: <20180302160022.ub6vinw6br3l2dyb@rob-hp-laptop>
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <e77690ea7f7332e9e1ee64204a4e72c759c41aa9.1519378871.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e77690ea7f7332e9e1ee64204a4e72c759c41aa9.1519378871.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 06:16:24PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Update binding document for more mt7623[A,N] reference boards being
> supported.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
