Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753521AbeBGIrx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 03:47:53 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16582 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeBGIru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 03:47:50 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 07 Feb 2018 00:47:50 -0800
Date: Wed, 7 Feb 2018 10:47:44 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH v3 01/11] regulator: core: add API to get voltage
 constraints
Message-ID: <20180207084744.GG7031@tbergstrom-lnx.Nvidia.com>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
 <1517934852-23255-2-git-send-email-pdeschrijver@nvidia.com>
 <20180206163544.GI5681@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180206163544.GI5681@sirena.org.uk>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To UKMAIL101.nvidia.com
 (10.26.138.13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 04:35:44PM +0000, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Tue, Feb 06, 2018 at 06:34:02PM +0200, Peter De Schrijver wrote:
> > From: Laxman Dewangan <ldewangan@nvidia.com>
> > 
> > Add API to get min/max rail voltage configured from platform for
> > given rails.
> 
> because...

of the next patch where this is used to retrieve the minimum rail voltage.

Peter.
