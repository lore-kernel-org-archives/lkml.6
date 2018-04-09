Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeDILqc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbeDILqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:46:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E88320838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 9 Apr 2018 19:46:19 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stefan Agner <stefan@agner.ch>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] ARM: multi_v7_defconfig: add OCOTP driver for NXP
 SoCs
Message-ID: <20180409114618.GB14582@dragon>
References: <20180318203442.19759-1-stefan@agner.ch>
 <20180326073214.GB8857@dragon>
 <CAK8P3a2xhOEVF87WYCPLiw66XM1ydA9JCbf+2s4ZDApw9V5STQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2xhOEVF87WYCPLiw66XM1ydA9JCbf+2s4ZDApw9V5STQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 03:40:33PM +0200, Arnd Bergmann wrote:
> On Mon, Mar 26, 2018 at 9:32 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Sun, Mar 18, 2018 at 09:34:36PM +0100, Stefan Agner wrote:
> >> Enable on-chip OTP NVMEM support for NXP i.MX and VF610 SoCs.
> >> Since OTP values might be required by drivers required during
> >> boot, make sure the driver is built-in (e.g. i.MX thermal
> >> driver).
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >
> > Arnd,
> >
> > The series looks good to me.  In general, I keep myself away from
> > multi_v7_defconfig changes, but if you expect a pull-request from me, I
> > can do that.  Let me know how you want to apply the patches.
> 
> I would generally prefer that your defconfig pull requests contain changes
> to both the imx specific and the generic defconfig files. It's much easier
> for me to handle any conflicts when they arise during a merge than
> to pick up the individual patches.

Noted, thanks for the comments, Arnd.

Shawn
