Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AFAC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3B1218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfAXQRi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:17:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:35946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727749AbfAXQRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:17:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC06CB04D;
        Thu, 24 Jan 2019 16:17:36 +0000 (UTC)
Date:   Thu, 24 Jan 2019 17:17:36 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>, antoine.tenart@bootlin.com,
        maxime.chevallier@bootlin.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: fix condition for setting up link
 interrupt
Message-Id: <20190124171736.595c0414b5098699b6198903@suse.de>
In-Reply-To: <20190124160741.jady3r2e4dme7c4m@e5254000004ec.dyn.armlinux.org.uk>
References: <20190124131803.14038-1-tbogendoerfer@suse.de>
        <20190124155137.GD482@lunn.ch>
        <20190124160741.jady3r2e4dme7c4m@e5254000004ec.dyn.armlinux.org.uk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 16:07:41 +0000
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

> On Thu, Jan 24, 2019 at 04:51:37PM +0100, Andrew Lunn wrote:
> > On Thu, Jan 24, 2019 at 02:18:03PM +0100, Thomas Bogendoerfer wrote:
> > > Set up link interrupt if connection is handled by phylink otherwise
> > > link state change detection for in-band-status doesn't work.
> > 
> > Hi Thomas
> > 
> > Please ensure the maintainers of the driver are at least on Cc:
> 
> ... and other interested parties!

sorry about missing maintainers, but how could I find "other interested
parties" ? /me thought that's handled by sending to mailinglists, which I did...

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
