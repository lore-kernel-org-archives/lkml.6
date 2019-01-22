Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54EAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E0020861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PAVS9Q2p";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PAVS9Q2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfAVGVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:21:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVGVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:21:12 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6CEFC60791; Tue, 22 Jan 2019 06:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548138071;
        bh=LDfVY4OBvhykBqwTPatfg6bh6g1i4r+JOjnCvsS0TFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PAVS9Q2pEzviZgq2ryLda2340fu+5hHV8gKzcyMkvdEx/eGrsyuhi0/X8174KwFFu
         4Sz6uhNP09Nb+N94io6ZU3RNKF3KSDbvH/FzKZL6R8ybq5qTW2tTl8NdeRtVxWkkxz
         hKymykh8OOpx1i0S7p1mIiCgS/CofY3hCZY6ynAE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E1B4C60791;
        Tue, 22 Jan 2019 06:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548138071;
        bh=LDfVY4OBvhykBqwTPatfg6bh6g1i4r+JOjnCvsS0TFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PAVS9Q2pEzviZgq2ryLda2340fu+5hHV8gKzcyMkvdEx/eGrsyuhi0/X8174KwFFu
         4Sz6uhNP09Nb+N94io6ZU3RNKF3KSDbvH/FzKZL6R8ybq5qTW2tTl8NdeRtVxWkkxz
         hKymykh8OOpx1i0S7p1mIiCgS/CofY3hCZY6ynAE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Jan 2019 11:51:10 +0530
From:   alokc@codeaurora.org
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        linux-spi-owner@vger.kernel.org
Subject: Re: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
In-Reply-To: <20190121124327.GB12679@sirena.org.uk>
References: <1548069703-26595-1-git-send-email-alokc@codeaurora.org>
 <1548069703-26595-5-git-send-email-alokc@codeaurora.org>
 <20190121124327.GB12679@sirena.org.uk>
Message-ID: <454e656457c339c57f69deb38fa453cb@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-21 18:13, Mark Brown wrote:
> On Mon, Jan 21, 2019 at 04:51:41PM +0530, Alok Chauhan wrote:
>> Get the interconnect paths for SPI based Serial Engine device
>> and vote accordingly based on maximum supported SPI frequency.
> 
> I don't have any of the other patches in this series or a cover letter 
> -
> what's going on with dependencies here?

I am extremely sorry to waste your time. Looks like I missed some 
mailing list while sending patches upstream. I will resend patches 
today.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
