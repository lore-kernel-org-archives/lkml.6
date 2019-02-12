Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC38C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B242B2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfBLH2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:28:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfBLH2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:28:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 513112186A;
        Tue, 12 Feb 2019 07:28:50 +0000 (UTC)
Date:   Tue, 12 Feb 2019 08:28:47 +0100
From:   Greg KH <greg@kroah.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        andrew@lunn.ch,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        vivien.didelot@gmail.com, Ido Schimmel <idosch@mellanox.com>,
        jiri@mellanox.com, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 3/3] staging: fsl-dpaa2: ethsw: Remove getting
 PORT_BRIDGE_FLAGS
Message-ID: <20190212072847.GB2940@kroah.com>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
 <20190211211749.19847-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211211749.19847-4-f.fainelli@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 01:17:49PM -0800, Florian Fainelli wrote:
> There is no code that tries to get the attribute
> SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS, remove support for doing that.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 5 -----
>  1 file changed, 5 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
