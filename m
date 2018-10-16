Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACAAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E0F20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E0F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJPPKl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:10:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36864 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbeJPPKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:10:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1156F2072C; Tue, 16 Oct 2018 09:21:35 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id D5CCB20712;
        Tue, 16 Oct 2018 09:21:34 +0200 (CEST)
Date:   Tue, 16 Oct 2018 09:21:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        David Lechner <david@lechnology.com>,
        Thierry Reding <treding@nvidia.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/2] Neutis N5 support
Message-ID: <20181016072136.3belesnmrvbejiro@flea>
References: <1539339841-22235-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539604192-17561-1-git-send-email-aleksandr.aleksandrov@emlid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1539604192-17561-1-git-send-email-aleksandr.aleksandrov@emlid.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 02:49:48PM +0300, Aleksandr Aleksandrov wrote:
> This patch addes Neutis N5 support.
> Emlid Neutis N5 is a SoM based on Allwinner H5.
> The patch includes device tree file for Dev board
> and dtsi file for SoM needs.
> 
> Changes from v1: separate dts file: dtsi for SoM
> and motherboard dts file that inlcudes dtsi file.
> 
> Changes from v2 (5 oct 2018):
> - makefile: dtb-$(CONFIG_ARCH_SUNXI) - ordered alphabetically
> 
> Changes from v3 (12 oct 2018):
> - fix commit prefix for 1/2 patch
> - use an SPDX header instead of the full license text
> - compatible: "emlid,neutis-n5" instead of "emlid,emlid-neutis-n5"
> 
> Changes from v4 (15 oct 2018):
> - fix dt-bindings commit prefix
> - update license header for dts files
> - make interfaces be alphabetically in devboard dts file

Queued both for 4.21, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
