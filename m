Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753935AbeBSUld (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:41:33 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43179 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753903AbeBSUl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:41:26 -0500
X-Google-Smtp-Source: AH8x225Sykh3aPz8NYElITMsGa9YsrD2MBheaBrEZLIGqOt3IXCfWgGX3F8k9+8Z5jY9x3qSuk1mPQ==
Date: Mon, 19 Feb 2018 14:41:25 -0600
From: Rob Herring <robh@kernel.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Jeffery <andrew@aj.id.au>, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 1/3] dt-bindings: aspeed-lpc: Add reset controller
Message-ID: <20180219204125.ralfeo6rm7wzkcnq@rob-hp-laptop>
References: <20180219065438.19933-1-joel@jms.id.au>
 <20180219065438.19933-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219065438.19933-2-joel@jms.id.au>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 05:24:36PM +1030, Joel Stanley wrote:
> This describes the reset controller present in the LPC address space.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt          | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
