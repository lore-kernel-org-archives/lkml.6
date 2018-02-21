Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934342AbeBURUb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:20:31 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:55927 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934251AbeBURU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:20:28 -0500
Date: Wed, 21 Feb 2018 18:20:24 +0100
From: Simon Horman <horms@verge.net.au>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: geert@linux-m68k.org, magnus.damm@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/19] ARM64: dts: r8a77965: Add SCIF device nodes
Message-ID: <20180221172024.k7eqivf7xzksl32y@verge.net.au>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-15-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519139541-18783-15-git-send-email-jacopo+renesas@jmondi.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 04:12:16PM +0100, Jacopo Mondi wrote:
> Add SCIF[0-5] device nodes for M3-N (r8a77965) SoC.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied with prefix updated to:

arm64: dts: renesas: r8a77965:
