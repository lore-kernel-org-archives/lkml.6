Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426877AbeCBSNd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:13:33 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34727 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeCBSN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:13:29 -0500
X-Google-Smtp-Source: AG47ELs4Fj8/3z1MY38jnRsd4DGAgmgXY2lO9HGQFlsRQydZEmOa/Wa+DZIiRJs11IPBNp7Qg461Yw==
Date: Fri, 2 Mar 2018 12:13:28 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org, monstr@monstr.eu,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Rob Herring <robherring2@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Cartwright <josh.cartwright@ni.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] arm: zynq: Add Xilinx cc108 board
Message-ID: <20180302181328.wbgnnw2jsuorfahi@rob-hp-laptop>
References: <cover.1519398009.git.michal.simek@xilinx.com>
 <eb2fec632fcb7fbfed39dcbeae92b38a98518618.1519398009.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb2fec632fcb7fbfed39dcbeae92b38a98518618.1519398009.git.michal.simek@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 04:00:19PM +0100, Michal Simek wrote:
> The board contains 7z010 with 512MB memory, ethernet, qspi, uart, usbs
> and sd. But board is not supporting booting from sd card.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt |  5 ++
>  arch/arm/boot/dts/Makefile                       |  1 +
>  arch/arm/boot/dts/zynq-cc108.dts                 | 75 ++++++++++++++++++++++++
>  3 files changed, 81 insertions(+)
>  create mode 100644 arch/arm/boot/dts/zynq-cc108.dts

Reviewed-by: Rob Herring <robh@kernel.org>
