Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeBSCxx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 21:53:53 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39522 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbeBSCxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 21:53:51 -0500
X-Google-Smtp-Source: AH8x227W85HppeDPU9jsZ3RMtY/PHB5GKq3+yp4xQgN+oCWmgGCZFBqM77Z/WPhLli/IuvzcHjC0MQ==
Date: Sun, 18 Feb 2018 20:53:49 -0600
From: Rob Herring <robh@kernel.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] clk: renesas: cpg-msr: Add support for R-Car M3-N
Message-ID: <20180219025349.2rctveegmwh7lj4n@rob-hp-laptop>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-3-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518515162-23663-3-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:45:49AM +0100, Jacopo Mondi wrote:
> Initial support for R-Car M3-N (r8a77965), including core and module
> clocks.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  .../devicetree/bindings/clock/renesas,cpg-mssr.txt |   1 +
>  drivers/clk/renesas/Kconfig                        |   5 +
>  drivers/clk/renesas/Makefile                       |   1 +
>  drivers/clk/renesas/r8a77965-cpg-mssr.c            | 333 +++++++++++++++++++++
>  drivers/clk/renesas/renesas-cpg-mssr.c             |   6 +
>  drivers/clk/renesas/renesas-cpg-mssr.h             |   1 +
>  include/dt-bindings/clock/r8a77965-cpg-mssr.h      |  62 ++++
>  7 files changed, 409 insertions(+)
>  create mode 100644 drivers/clk/renesas/r8a77965-cpg-mssr.c
>  create mode 100644 include/dt-bindings/clock/r8a77965-cpg-mssr.h

For the DT bits:

Reviewed-by: Rob Herring <robh@kernel.org>
