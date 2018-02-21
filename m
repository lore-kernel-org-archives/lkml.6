Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbeBURD2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:03:28 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:55704 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753945AbeBURDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:03:24 -0500
Date: Wed, 21 Feb 2018 18:03:19 +0100
From: Simon Horman <horms@verge.net.au>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: geert@linux-m68k.org, magnus.damm@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/19] ARM64: Add Renesas R-Car M3-N config symbol
Message-ID: <20180221170319.3w2ylymp5dtjxxqg@verge.net.au>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-8-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519139541-18783-8-git-send-email-jacopo+renesas@jmondi.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 04:12:09PM +0100, Jacopo Mondi wrote:
> Add configuration option for the R-Car M3-N (R8A77965) SoC.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks, I have applied this after updating the subject to:

arm64: add Renesas R8A77965 support

Please use "arm64" rather than ARM64 as a prefix.
(But "ARM" rather than "arm"!).
