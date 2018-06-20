Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6776C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A1A20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A1A20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeFTETn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:19:43 -0400
Received: from muru.com ([72.249.23.125]:48312 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750842AbeFTETi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:19:38 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9CDF7805C;
        Wed, 20 Jun 2018 04:22:20 +0000 (UTC)
Date:   Tue, 19 Jun 2018 21:19:34 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Vignesh R <vigneshr@ti.com>, Jiri Slaby <jslaby@suse.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 0/2] serial: 8250_omap: Add compatible for AM654 UART
Message-ID: <20180620041934.GA112168@atomide.com>
References: <20180619194450.6353-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619194450.6353-1-nm@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [180619 20:13]:
> Hi,
> 
> This series was previously send out as part of a larger AM654 UART
> support series, but was determined to create a bit of merge conflicts
> due to interdependence.

Both patches look good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
