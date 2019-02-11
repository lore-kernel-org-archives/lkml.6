Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DA4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF02222B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jrqOqUvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfBKOBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:01:42 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:46856 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfBKOBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hPgGrsRM/R34krWPVEoGv/u0Tf8qVNTWxmAPKKgu/XU=; b=jrqOqUvEq7b+3jj+iqDnMOwJXh
        eZP3aY3i4AUbpwYDAeC7yRabfXNbWNqSH4/ndCgwL8JMXDr1BmhtdfGsbA2qyvLmzE9/MFnivImhf
        mSntputxyIEG4VNW6kGpvKHY58ImDgHRQANlJvLNaUbvOXZm0R2qqqi2EQjyFW3LZg5Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gtC9S-0006Ch-Ib; Mon, 11 Feb 2019 15:01:38 +0100
Date:   Mon, 11 Feb 2019 15:01:38 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] i2c:ocores: stop transfer on timeout
Message-ID: <20190211140138.GA19023@lunn.ch>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
 <20190211083122.32485-2-federico.vaga@cern.ch>
 <20190211102424.5xnzyxvfd2yhf6ui@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211102424.5xnzyxvfd2yhf6ui@ninjato>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Applied to for-next, thanks!

Hi Wolfram

Could you drop these patches and wait for a new version?  I don't
think you have pushed it out yet? So it won't be a visible rebase.

Thanks
	Andrew


