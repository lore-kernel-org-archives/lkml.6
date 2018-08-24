Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9332C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E609208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jr38GuQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E609208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeHYAhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:37:51 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42746 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbeHYAhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=3Qgy9oyjZ0Q95TBwbty8yPL3U9OcnrJao//+Sfjmg+8=;
        b=jr38GuQrOYCbe/DZex33exi28DUwFw/fkGtWS6o497JCw668b8XdcKKEMrY5afbg69I2cn0cNun/HAY6p1gD1g52nDQLFrVUcYntnF4HTKnx6kzutZuFMTavmFhQJwJLWNuI+Y8KxqwT2WrjdtyRy9q+Fw+wzf2pK5Wi2BVWafg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ftJD0-0002ui-Jg; Fri, 24 Aug 2018 23:01:30 +0200
Date:   Fri, 24 Aug 2018 23:01:30 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kosta Zertsekel <zertsekel@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
Subject: Re: [PATCH v4] spi: orion: cosmetics - alias long direct_access
 variables
Message-ID: <20180824210130.GF27483@lunn.ch>
References: <20180815190449.23738-1-zertsekel@gmail.com>
 <CADxo8W+JMKJvf8LUdH7_2EXqfi8KvrSPAYa=CZV1eMq2VrQ5rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxo8W+JMKJvf8LUdH7_2EXqfi8KvrSPAYa=CZV1eMq2VrQ5rg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 11:55:18PM +0300, Kosta Zertsekel wrote:
> Guys,
> 
> Any additional comments?
> Or the patch is ready to be merged?

Hi Kosta

Since the merge window is open at the moment, many maintainers don't
look at patches. They expect you to resubmit, based on -rc1, when the
merge windows closes.

      Andrew
