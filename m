Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeB1NTz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:19:55 -0500
Received: from mail.bootlin.com ([62.4.15.54]:32885 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752267AbeB1NTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:19:53 -0500
Date: Wed, 28 Feb 2018 14:19:51 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@bootlin.com, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, mylene.josserand@bootlin.com
Subject: Re: [PATCH 2/3] ARM: dts: sun8i: a711: set regulator for each
 cluster of CPUs
Message-ID: <20180228141951.3a06bc11@windsurf.lan>
In-Reply-To: <07883d44949420891c1ed2411ff15199d53075c0.1519823347.git-series.quentin.schulz@bootlin.com>
References: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
        <07883d44949420891c1ed2411ff15199d53075c0.1519823347.git-series.quentin.schulz@bootlin.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 28 Feb 2018 14:11:21 +0100, Quentin Schulz wrote:

> @@ -136,6 +144,7 @@
>   * An USB-2 hub is connected here, which also means we don't need to
>   * enable the OHCI controller.
>   */
> +
>  &ehci0 {
>  	status = "okay";
>  };

Spurious change.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
