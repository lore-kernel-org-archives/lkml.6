Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2761C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C70E218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfAXQPL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:15:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:35382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727945AbfAXQPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:15:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E2D9B03B;
        Thu, 24 Jan 2019 16:15:09 +0000 (UTC)
Date:   Thu, 24 Jan 2019 17:15:08 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH net] net: mvpp2: fix condition for setting up link
 interrupt
Message-Id: <20190124171508.7a5b7da09b9c0b702f22a99b@suse.de>
In-Reply-To: <20190124155137.GD482@lunn.ch>
References: <20190124131803.14038-1-tbogendoerfer@suse.de>
        <20190124155137.GD482@lunn.ch>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 16:51:37 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Jan 24, 2019 at 02:18:03PM +0100, Thomas Bogendoerfer wrote:
> > Set up link interrupt if connection is handled by phylink otherwise
> > link state change detection for in-band-status doesn't work.
> 
> Hi Thomas
> 
> Please ensure the maintainers of the driver are at least on Cc:

I've hoped my script will get them, but it used --nogit-fallback, which prevented
finding maintainers... Sorry about that

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
