Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbeBBF0j (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 00:26:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbeBBF0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 00:26:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FB721738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Fri, 2 Feb 2018 13:26:22 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Marco Franchi <marco.franchi@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, fabio.estevam@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] ARM: dts: imx6ul-evk: Add support for mag3110 sensor
Message-ID: <20180202052621.GG20833@dragon>
References: <1515498385-23198-1-git-send-email-marco.franchi@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515498385-23198-1-git-send-email-marco.franchi@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2018 at 09:46:23AM -0200, Marco Franchi wrote:
> The i.MX 6UL EVK has a MAG3110 Magnetometer sensor in its base board.
> Add support for this sensor, which is included in the trivial i2c devices 
> and according to the bindings documentation, just need a compatible field 
> and an address.
> 
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Applied all, thanks.
