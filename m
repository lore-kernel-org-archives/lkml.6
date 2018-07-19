Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A419C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461A420673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461A420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeGSHXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:23:40 -0400
Received: from muru.com ([72.249.23.125]:52042 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbeGSHXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:23:40 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 260708127;
        Thu, 19 Jul 2018 06:45:20 +0000 (UTC)
Date:   Wed, 18 Jul 2018 23:42:05 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel.lezcano@linaro.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, aford173@gmail.com,
        drivshin@awxrd.com
Subject: Re: [RFC PATCH 1/4] ARM: dts: am33xx: Add all fck timer clocks
Message-ID: <20180719064205.GI99251@atomide.com>
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
 <1531773542-15736-2-git-send-email-narmstrong@baylibre.com>
 <20180717055547.GV99251@atomide.com>
 <70f28466-fd13-58cd-cb5b-9857d7670d69@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f28466-fd13-58cd-cb5b-9857d7670d69@baylibre.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Neil Armstrong <narmstrong@baylibre.com> [180717 20:31]:
> On 17/07/2018 07:55, Tony Lindgren wrote:
> > These should all use the clkctrl clock nodes, see:
> 
> Even the already configured timer1 & timer2 ?

Yeah that way things will work in a generic way for the SoCs
using clkctrl registers. That's omap4 and later and including
ti81xx.

Regards,

Tony
