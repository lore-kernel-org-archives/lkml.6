Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449C1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A78C2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="evCD49A4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbfA3Ssj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:48:39 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:32988 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733116AbfA3Ssj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BTWJYFb9oKVLJ0z43NCOvYdM3PHYmAdNnAYATfUQ1P8=; b=evCD49A4kqizkNKx3bB0Ytlmb5
        dHatUbUgCehv447ff+86bpWicUGdybqzX+pNB6loP+QC4oi3JpyeuPvufKmxfqPiQEjhKllp+fc7b
        Hm2AIpHyaHK5Vjjl90lo9WmRwZ6V2s4kpvh3KraMEV4KKImZ3PMMC5AEq8M3+U2Xic00=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gouuX-0006VS-3z; Wed, 30 Jan 2019 19:48:33 +0100
Date:   Wed, 30 Jan 2019 19:48:33 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Carlos Henrique Lima Melara <charlesmelara@outlook.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "neil@brown.name" <neil@brown.name>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] staging: mt7621-eth/ethtool.c: Correction of SPDX
 license identifier
Message-ID: <20190130184833.GF15050@lunn.ch>
References: <SC1P15201MB2014C3E0CAB4DA9ADF330797A8900@SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM>
 <20190130163817.GF21904@lunn.ch>
 <20190130181005.GA15653@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130181005.GA15653@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> See the patch about all of this from Thomas on lkml yesterday for
> why this is the case.

Hi Greg

Thanks for the info. I had not seen this, and i guess other have not
as well. So here is a link to the patch.

https://lkml.org/lkml/2019/1/28/1975

	Andrew
