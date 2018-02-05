Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeBEIOv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:14:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751938AbeBEIOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:14:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467D9217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 5 Feb 2018 16:14:23 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Roy Pledge <roy.pledge@nxp.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
        madalin.bucur@nxp.com, linux-kernel@vger.kernel.org,
        leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: Add DPAA QBMan portal 9
Message-ID: <20180205081422.GR31354@dragon>
References: <1517260041-19300-1-git-send-email-roy.pledge@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517260041-19300-1-git-send-email-roy.pledge@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 04:07:21PM -0500, Roy Pledge wrote:
> ARM DPAA1 (LS1043 and LS1046) have 10 QBMan portals (indexed 0-9)
> Enable the one that is missing in the device trees.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Applied, thanks.
