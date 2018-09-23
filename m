Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E0AC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 16:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82D3214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 16:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82D3214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitmer.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeIWWvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 18:51:35 -0400
Received: from 50-87-157-213.static.tentacle.fi ([213.157.87.50]:51819 "EHLO
        bitmer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbeIWWvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 18:51:35 -0400
X-Greylist: delayed 1741 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Sep 2018 18:51:33 EDT
Received: from dsl-hkibng31-54fab1-197.dhcp.inet.fi ([84.250.177.197] helo=[192.168.1.36])
        by bitmer.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <jarkko.nikula@bitmer.com>)
        id 1g47At-00058t-Kq; Sun, 23 Sep 2018 19:23:59 +0300
Subject: Re: [PATCH 3/3] ARM: OMAP2PLUS: Remove references to AM3517-EVM since
 it's in DT
To:     Adam Ford <aford173@gmail.com>, linux-omap@vger.kernel.org
Cc:     =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
References: <20180923153718.15095-1-aford173@gmail.com>
 <20180923153718.15095-3-aford173@gmail.com>
From:   Jarkko Nikula <jarkko.nikula@bitmer.com>
Message-ID: <adbc42d6-efae-20cf-64a2-994ccdffcd87@bitmer.com>
Date:   Sun, 23 Sep 2018 19:23:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180923153718.15095-3-aford173@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en_US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/23/18 18:37, Adam Ford wrote:
> Since the audio codecs used on the AM3517-EVM are now available
> in device tree, and the audio driver wasn't really being used
> anyway, this patch removes the remaining AM3517 legacy board
> options and sound soc drivers.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
For sound/soc/omap/ changes:

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
