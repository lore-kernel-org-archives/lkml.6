Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeA3WUG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:20:06 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:55505 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeA3WUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:20:04 -0500
Date: Tue, 30 Jan 2018 23:19:52 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Device tree fixes for Axentia TSE-850 and Nattis
Message-ID: <20180130221952.GN2809@piout.net>
References: <20180118114616.6639-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118114616.6639-1-peda@axentia.se>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2018 at 12:46:13 +0100, Peter Rosin wrote:
> Hi!
> 
> Here's a series that is of the "documentation" kind. It fixes things
> that don't really need fixing, but the fixes are correct none-the-less
> and should prevent possible confusion.
> 
> Changes since v1:
> 
> - One more fix added to patch 1/3. The size of the rootfs partition
>   should be 504MB, as the flash is 512MB total.
> 
> Sorry for the noise.
> 

All applied. I'm planning to send that for 4.17 as they are not urgent.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
