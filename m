Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeCTSrD convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 14:47:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54008 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeCTSrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 14:47:01 -0400
Date: Tue, 20 Mar 2018 19:46:46 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/7] dt-bindings: add binding for the Allwinner A64 DE2
 bus
Message-ID: <20180320184646.dynqv6qubzabroe4@flea>
References: <20180316175354.21437-1-icenowy@aosc.io>
 <20180316175354.21437-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180316175354.21437-3-icenowy@aosc.io>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2018 at 01:53:49AM +0800, Icenowy Zheng wrote:
> All the sub-blocks of Allwinner A64 DE2 needs the SRAM C on A64 SoC to
> be claimed, otherwise the whole DE2 space is inaccessible.
> 
> Add a device tree binding of the DE2 part as a sub-bus.

Where did you get the info that it was a bus?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
