Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeBEHcV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 02:32:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbeBEHcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 02:32:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1C2217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 5 Feb 2018 15:31:57 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Marco Franchi <marcofrk@gmail.com>
Cc: robh+dt@kernel.org, LW@karo-electronics.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com,
        Marco Franchi <marco.franchi@nxp.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: imx: Pass empty memory size on board dts
Message-ID: <20180205073156.GK31354@dragon>
References: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2018 at 11:22:12AM -0200, Marco Franchi wrote:
> In preparation for removing 'reg = <0 0>;' from the dtsi SoC files, pass
> 'reg = <0 0 >;' to the dts/dtsi board files that do not pass the memory
> size.
> 
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Applied all, thanks.
