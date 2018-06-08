Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RfNdAP0iGlv1XQAAmS7hNA
	; Fri, 08 Jun 2018 06:32:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8D4EA6089E; Fri,  8 Jun 2018 06:32:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CB0CA606FA;
	Fri,  8 Jun 2018 06:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB0CA606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751181AbeFHGc1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:32:27 -0400
Received: from muru.com ([72.249.23.125]:46342 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbeFHGc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:32:26 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 32B58807E;
        Fri,  8 Jun 2018 06:34:56 +0000 (UTC)
Date: Thu, 7 Jun 2018 23:32:22 -0700
From: Tony Lindgren <tony@atomide.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
        devicetree@vger.kernel.org,
        Javier Martinez Canillas <javier@dowhile0.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: igep: Relicense the IGEP boards under
 GPLv2/X11
Message-ID: <20180608063222.GL5738@atomide.com>
References: <20180606152500.14034-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606152500.14034-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Enric Balletbo i Serra <enric.balletbo@collabora.com> [180606 08:27]:
> The current GPLv2 only licensing on IGEP boards makes it very impractical
> for other software components licensed under another license.
> 
> In order to make it easier for them to reuse our device trees, relicense
> all boards under a GPLv2/X11 dual-license. Also switch to use the SPDX
> identifiers and remove the boiler plate license text.

I don't think you have all the people in Cc who have already
contributed patches to these files, can you please check the
files with git log?

Regards,

Tony
