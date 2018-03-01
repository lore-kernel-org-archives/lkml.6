Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162329AbeCAVlk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:41:40 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35621 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162060AbeCAVlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:41:36 -0500
X-Google-Smtp-Source: AG47ELv8BlYNpjM4Ai/CwIO5WCPri2QIkalrvsTh1l9SYV0cfPz1ZYtfim56h9NuIApAXofGhMQ9cQ==
Date: Thu, 1 Mar 2018 15:41:27 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/42] dt-bindings: clock: Add new bindings for TI
 Davinci PLL clocks
Message-ID: <20180301214127.7fk3p66w6ikfj6kk@rob-hp-laptop>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
 <1519071723-31790-2-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519071723-31790-2-git-send-email-david@lechnology.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 02:21:22PM -0600, David Lechner wrote:
> This adds a new binding for the PLL IP blocks in the mach-davinci
> family of processors. Currently, only da850 has device tree support
> but these bindings can also work for other SoCs in this family just
> by adding new compatible strings.
> 
> Note: Although these PLL controllers are very similar to the TI Keystone
> SoCs, we are not re-using those bindings. The Keystone bindings use a
> legacy one-node-per-clock binding. Furthermore, the mach-davinici SoCs
> have a slightly different PLL register layout and a number of quirks
> that can't be handled by the existing bindings, so the keystone bindings
> could not be used as-is anyway.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v7 changes:
> - None (there was some debate about having child nodes, but the consensus was
>   that this is "good enough" as it is)
> 
> v6 changes:
> - Added clock-names property
> - Added ti,clkmode-square-wave property
> - Added pllout child node
> - Added obsclk child node
> - Expanded examples
> 
> 
>  .../devicetree/bindings/clock/ti/davinci/pll.txt   | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/pll.txt

Reviewed-by: Rob Herring <robh@kernel.org>
