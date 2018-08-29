Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7A7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791222082A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0wG9gxJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791222082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeH2QtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:49:05 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46297 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbeH2QtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=hBmmpq+C17f+WDWgy6E/A1KiO4j4go6Gcnfwq8y3gOg=;
        b=0wG9gxJ6Jkl2NUXCp87s5FDKJrq+4v9uxmde7Zp2esT91xTLqLhCd5DdgQFk9hcgnGzT3jMhiCEF3S7FIGxEOxmcxuY9N0Hzfpn39B6iQhQ5guUTTmmvWcFn+O90YUSz+VVU89q1cckRv9d0s80nfZz9h+9Mnscmgtyk0C0nrd0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fuzxB-0000cT-VP; Wed, 29 Aug 2018 14:52:09 +0200
Date:   Wed, 29 Aug 2018 14:52:09 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>, aditya@kobol.io,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        gauthier@kobol.io, Alban Browaeys <alban.browaeys@gmail.com>,
        linux-pwm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dennis Gilmore <dennis@ausil.us>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: Re: [PATCH RESEND 1/2] gpio: mvebu: Add support for multiple PWM
 lines per GPIO chip
Message-ID: <20180829125209.GB1955@lunn.ch>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
 <1533522556-55055-2-git-send-email-aditya@kobol.io>
 <CACRpkda2qXxyEj+y8DaZ-_PWcj3pBGtvVAac8qaFCnC0LTNkNA@mail.gmail.com>
 <20180829100229.7566e0db@windsurf>
 <CACRpkdZU36s=-G7ncW3JMb+vXDmpdLO+3zupQD_fwUyfZxx4vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZU36s=-G7ncW3JMb+vXDmpdLO+3zupQD_fwUyfZxx4vA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks yes Andrew is involved, I will wait for Andrew's definitive ACK
> before merging any of this.

Hi Linus

Given the review comments i made so far, it has a NACK.

I will happily review the next version.

  Andrew
