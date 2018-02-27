Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeB0QQD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:16:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60324 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751756AbeB0QQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:16:02 -0500
Date: Tue, 27 Feb 2018 17:15:50 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] MIPS: defconfigs: add a defconfig for Microsemi
 SoCs
Message-ID: <20180227161550.GC15333@piout.net>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-8-alexandre.belloni@free-electrons.com>
 <20180214170342.GF3986@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214170342.GF3986@saruman>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2018 at 17:03:43 +0000, James Hogan wrote:
> On Tue, Jan 16, 2018 at 11:12:39AM +0100, Alexandre Belloni wrote:
> > +# CONFIG_EARLY_PRINTK is not set
> 
> Only Loongson1b/1c explicitly disable early printk. Do you disable it
> for a particular reason?
> 

Well, it is so late that it is not really useful and I don't find that
particularly interesting to have it on by default.

But I don't have a strong opinion, I certainly can let it enabled.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
