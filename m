Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF346C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEAC20817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p5TssebA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEAC20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeKSEGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 23:06:32 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:39593 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbeKSEGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 23:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=4rZ8isI6TA5kCsU63EsZvRrTrUT153IBkoRznrrf4Es=;
        b=p5TssebAKWw2Jg72+cHcM+61Ag37f9idVh2wbw6ycJjh0VFRE2nIwydgL7TaLEHsCSJoZRUiobRKrvGAcOZ6T5wTRZy6oJpQX2LJy9jr9cJ3qfNZbKJH6z7BnM6lptNvgKp2sBet676K5zxIymxpdYvgyIZ4f3b/cjYOQrYT9X0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gOR8V-0001yw-Jg; Sun, 18 Nov 2018 18:45:31 +0100
Date:   Sun, 18 Nov 2018 18:45:31 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] net: phy: icplus: allow configuring the interrupt
 function on IP101GR
Message-ID: <20181118174531.GA7446@lunn.ch>
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
 <20181117182007.14791-8-martin.blumenstingl@googlemail.com>
 <20181118171340.GG5591@lunn.ch>
 <CAFBinCBkH3OrtxROpcbqF-1BtRY=6QqS2zkhZTo=W==1FKqZsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCBkH3OrtxROpcbqF-1BtRY=6QqS2zkhZTo=W==1FKqZsw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll wait a few days for more feedback and re-send this series with
> that issue fixed

Hi Martin

In networking world, you should expect feedback within 3 days. So i
was actually a bit slow. If i'd of waited much longer, David would of
merged the patches very soon.

So feel free to respin the patchset now if you want.

   Andrew
