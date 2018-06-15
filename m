Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AE94DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E6A208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E6A208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965773AbeFOLX6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:23:58 -0400
Received: from gloria.sntech.de ([95.129.55.99]:39132 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965641AbeFOLXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:23:55 -0400
Received: from ip5f5a8448.dynamic.kabel-deutschland.de ([95.90.132.72] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fTmpa-0001yC-7L; Fri, 15 Jun 2018 13:23:50 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: rockchip: Add missing cooling device properties for CPUs
Date:   Fri, 15 Jun 2018 13:23:49 +0200
Message-ID: <5093249.sUvQcHjlij@diego>
In-Reply-To: <d7f32cb0c3b77901cb5e37320a454e5e1dfed958.1527225682.git.viresh.kumar@linaro.org>
References: <cover.1527225682.git.viresh.kumar@linaro.org> <d7f32cb0c3b77901cb5e37320a454e5e1dfed958.1527225682.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 25. Mai 2018, 07:40:05 CEST schrieb Viresh Kumar:
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
> 
> Add such missing properties.
> 
> Do minor rearrangement as well to keep ordering consistent.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

applied for 4.19


Thanks
Heiko


