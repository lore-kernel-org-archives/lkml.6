Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeDKI1q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:27:46 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:52839 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeDKI1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:27:44 -0400
Date: Wed, 11 Apr 2018 10:27:38 +0200
From: Simon Horman <horms@verge.net.au>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 1/2] MAINTAINERS: remove me as maintainer for I2C host
 drivers
Message-ID: <20180411082738.jot5ugwto4otsj3s@verge.net.au>
References: <20180410194914.7268-1-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410194914.7268-1-wsa@the-dreams.de>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 09:49:13PM +0200, Wolfram Sang wrote:
> The number of I2C host controller drivers keeps increasing, and although
> I had some success acquiring specific driver maintainers, my bandwidth
> is by far not enough to act as a fallback for the rest of the drivers.
> To reflect this status-quo in MAINTAINERS, add a seperate entry for I2C
> host drivers, let the I2C list (= community) be the contact point, and
> mark this section as "Odd fixes".
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
