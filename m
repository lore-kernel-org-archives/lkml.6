Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB05C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D918C218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbfBON4R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:56:17 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58677 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfBON4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:56:17 -0500
X-Greylist: delayed 83851 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Feb 2019 08:56:16 EST
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0B9D7FF805;
        Fri, 15 Feb 2019 13:56:13 +0000 (UTC)
Date:   Fri, 15 Feb 2019 14:56:13 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
Message-ID: <20190215135613.sdz56vtiawqeryi5@flea>
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
 <20190214130910.9201-5-tiny.windzz@gmail.com>
 <20190214143842.nqsh6trwdjxq2ecd@flea>
 <CAEExFWuxrVC1J0g93R3ifaDxOGy-20B4jftoHw932V7+wqhtxw@mail.gmail.com>
 <CAEExFWv_K_07e30dgPbafVhDD_smwZkpi6Fqk6yzCahesdnrGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAEExFWv_K_07e30dgPbafVhDD_smwZkpi6Fqk6yzCahesdnrGg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, Feb 15, 2019 at 12:56:03AM +0800, Frank Lee wrote:
> How about to implement a thermal driver that is not integrated with
> gpadc ？
> 
> GPADC on soc is rarely used now.

You mean GPADC in general, or the gpadc driver in particular?
Otherwise, yes, having a driver for the thermal sensor in the H6
sounds like a good plan for thermal throttling, but I don't see it as
a dependency for that whole series.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
