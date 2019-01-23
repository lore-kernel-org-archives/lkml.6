Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A651C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8AB218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfAWS0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:26:42 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:42106 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfAWS0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:26:42 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-66-19-nat.elisa-mobile.fi [85.76.66.19])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id AED4730046;
        Wed, 23 Jan 2019 20:26:38 +0200 (EET)
Date:   Wed, 23 Jan 2019 20:26:38 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     liaoweixiong <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC v7 0/5] pstore/block: new support logger for block devices
Message-ID: <20190123182638.GD2792@darkstar.musicnaut.iki.fi>
References: <1548245116-6360-1-git-send-email-liaoweixiong@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548245116-6360-1-git-send-email-liaoweixiong@allwinnertech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 23, 2019 at 08:05:11PM +0800, liaoweixiong wrote:
> Why should we need pstore_block?
> 1. Most embedded intelligent equipment have no persistent ram, which
> increases costs. We perfer to cheaper solutions, like block devices.
> In fast, there is already a sample for block device logger in driver
> MTD (drivers/mtd/mtdoops.c).

I think you should add a patch for some actual block device using this
new framework to show that it can work. What HW you think would be
using things?

A.
