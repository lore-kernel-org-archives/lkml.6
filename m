Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755129AbeEHNT1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:19:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53371 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754601AbeEHNT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:19:26 -0400
Date: Tue, 8 May 2018 15:19:14 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com, f.fainelli@gmail.com,
        opendmb@gmail.com, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, thomas.petazzoni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 00/12] Sunxi: Add SMP support on A83T
Message-ID: <20180508131914.6sy7cd6urnfg3tam@flea>
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180504190545.5114-1-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 04, 2018 at 09:05:33PM +0200, Mylène Josserand wrote:
> Hello everyone,
> 
> This is a V9 of my series that adds SMP support for Allwinner sun8i-a83t.
> Based on sunxi's tree, sunxi/for-next branch.
> Depends on a patch from Doug Berger that allows to include the "cpu-type"
> header on assembly files that I included in my series (patch 01).

I applied the patches, with the remarks done by Russell on v8 fixed,
and the function sun8i_a83t_cntvoff_init made static.

> The difference with the v8 is just that the machine is renamed in sun8i-a83t
> (see patch 07), according to Maxime's review.

The machine name hasn't changed, and the name sun8i-a83t still doesn't
make much sense. I've fixed it as well.

Thanks,
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
