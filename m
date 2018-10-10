Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0DFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E505214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E505214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeJJWWW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:22:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56098 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbeJJWWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:22:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A3199208E7; Wed, 10 Oct 2018 16:59:46 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 71BC120618;
        Wed, 10 Oct 2018 16:59:36 +0200 (CEST)
Date:   Wed, 10 Oct 2018 16:59:37 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
        Mark Van den Borre <mark@fosdem.org>,
        Gerry Demaret <gerry@fosdem.org>,
        Luc Verhaegen <libv@skynet.be>
Subject: Re: [PATCH 3/4] ARM: dts: sun7i: Add pinmux configuration for LCD0
 RGB888 pins
Message-ID: <20181010145937.lkknbbrt5vznjlat@flea>
References: <20181010114134.8211-1-contact@paulk.fr>
 <20181010114134.8211-3-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181010114134.8211-3-contact@paulk.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 01:41:33PM +0200, Paul Kocialkowski wrote:
> This adds the pin muxing definition for configuring the PD pins in LCD0
> mode for a RGB888 format to the sun7i device-tree.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

OUr policy so far has been that if there's no user for that pin group,
we won't merge it in order not to cripple the DTSI with useless groups.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
