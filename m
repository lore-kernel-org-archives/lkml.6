Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033199AbeBNRAl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:00:41 -0500
Received: from muru.com ([72.249.23.125]:57016 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032961AbeBNRAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:00:40 -0500
Date: Wed, 14 Feb 2018 09:00:36 -0800
From: Tony Lindgren <tony@atomide.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: use 'atmel' as at24 manufacturer in
 am335x-boneblue
Message-ID: <20180214170036.GL6364@atomide.com>
References: <20180124212213.3754-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180124212213.3754-1-brgl@bgdev.pl>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Bartosz Golaszewski <brgl@bgdev.pl> [180124 13:22]:
> Using 'at' as the <manufacturer> part of the compatible string is now
> deprecated. Use a correct string: 'atmel,<model>'.

Applying into omap-for-v4.17/dt thanks.

Tony
