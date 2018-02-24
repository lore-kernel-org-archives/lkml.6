Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeBXHMz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 02:12:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbeBXHMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 02:12:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9976121717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Sat, 24 Feb 2018 15:12:40 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Ran Wang <ran.wang_1@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Yuantian Tang <andy.tang@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64: dts: ls1012a: add cpu idle support
Message-ID: <20180224071239.GC3217@dragon>
References: <20180208075436.38443-1-ran.wang_1@nxp.com>
 <20180224062514.GB3217@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224062514.GB3217@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 02:25:16PM +0800, Shawn Guo wrote:
> On Thu, Feb 08, 2018 at 03:54:34PM +0800, Ran Wang wrote:
> > From: Yuantian Tang <andy.tang@nxp.com>
> > 
> > Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   18 ++++++++++++++++++
> >  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> Applied all, thanks.

Ran,

Just noticed that these patches are authored by Yuantian.  When you send
patches authored by someone else, you should have your SoB added to it.

I just append your SoB below to all 3 patches.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

Shawn
