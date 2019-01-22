Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8127FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6111720870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfAVSTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:19:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46484 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfAVSTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:19:11 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C7B2D2084E; Tue, 22 Jan 2019 19:19:08 +0100 (CET)
Received: from localhost (unknown [80.12.58.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6CA9A20654;
        Tue, 22 Jan 2019 19:18:58 +0100 (CET)
Date:   Tue, 22 Jan 2019 19:18:57 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jan Kotas <jank@cadence.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] rtc: Add a driver for Cadence RTC
Message-ID: <20190122181857.GH16702@piout.net>
References: <20190122104216.12077-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122104216.12077-1-jank@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2019 10:42:14+0000, Jan Kotas wrote:
> This patchset adds a driver support for Cadence RTC IP.
> It supports time, date and wakeups from sleep.
> 
> Changes since v2:
> 	Fixed a typo in the bindings documentation.
> 
> Changes since v1:
> 	Added devm_rtc_allocate_device before requesting an IRQ
> 	Added range_min, range_max values
> 	Return -EINVAL for read_time() if RTC is disabled
> 	Fixed some typos
> 
> Jan Kotas (2):
>  dt-bindings: rtc: Add bindings for Cadence RTC
>  rtc: Add Cadence RTC driver
> 
> Jan Kotas (2):
>   dt-bindings: rtc: Add bindings for Cadence RTC
>   rtc: Add Cadence RTC driver
> 
Both applied, thanks (only once ;))

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
