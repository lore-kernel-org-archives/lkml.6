Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E432FC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61842146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K1IaFcoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfBHN46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:56:58 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:43927 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfBHN46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eJruefPcMHEKq234LqT7fqJHZS65f9i7tRyihQ55IMA=; b=K1IaFcoyAp8CGcWGrnMi5i7cgT
        ZvaCidjrp07atWvi3dIHtBX8K53u83v0IP+wR4zsPGWqvZ0dOc+sDpwmN/cFsM7Nc5ia5+J8yWlvi
        jyW99oQOzXD2pRpJl4efDRlozHFs8aR47BaLd8I/N6crobsyXc7aRXhNniWOpMXWOB20=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gs6eA-0007LG-49; Fri, 08 Feb 2019 14:56:50 +0100
Date:   Fri, 8 Feb 2019 14:56:50 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Coles <coles.david@gmail.com>
Cc:     devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: add description of Netgear RN NV+v2 LCD
Message-ID: <20190208135650.GD26594@lunn.ch>
References: <20190208045305.8759-1-coles.david@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208045305.8759-1-coles.david@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 08:53:05PM -0800, David Coles wrote:
> GPIO pin mapping taken from NetGear NV+ v2 5.3.13 kernel sources[1]
> (see arch/arm/plat-feroceon/mv_hal/rtc/ext_rtc/usiLCD.c).

Kirkwood! It has been a while since we had a kirkwood patch. Some NAS
boxes seem to never die. Nice to see somebody still hacking on them.

> Signed-off-by: David Coles <coles.david@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
