Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C730C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 16:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C225F20869
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 16:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OMMzxaLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C225F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeHYTz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 15:55:59 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43023 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbeHYTz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 15:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=FpAVXZHCsZY5YXPvhXqhn83nKjrg+OoKZbhKLEUZ0Cs=;
        b=OMMzxaLcoAB7EUrqR7xxbWAHQLUWMU9t2cNZQ5Zze7X1rlg9u0SibNQlSoRpJwiN8bN6FqqPe+cbmrbPxCSn7EpU0Rw2XTfCvqJQXM2DHGoPTf/pqKKvehIWwUiBmz8ODk/wTq77+ojq9xbCVeNC5R9Q9Grf6DQ57x2BHWKjdIo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ftbEe-000625-NU; Sat, 25 Aug 2018 18:16:24 +0200
Date:   Sat, 25 Aug 2018 18:16:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 02/17] zinc: introduce minimal cryptography library
Message-ID: <20180825161624.GB22750@lunn.ch>
References: <20180824213849.23647-1-Jason@zx2c4.com>
 <20180824213849.23647-3-Jason@zx2c4.com>
 <20180825062951.GC726@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180825062951.GC726@sol.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems you still don't explicitly clarify anywhere in the source itself that
> the copyright holders of the code from OpenSSL have relicensed it under GPLv2.
> I only see a GPLv2 license slapped on the files, yet no such license is presence
> in the OpenSSL originals, at least in the one I checked.  If you did receive
> explicit permission, then you should include an explicit clarification in each
> file like the one in arch/arm/crypto/sha1-armv4-large.S.

Better yet, get the copyright holders to publicly send a
signed-off-by: or acked-by: so it is clear they agree to this.

	       Andrew
