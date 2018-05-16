Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeEPPIZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:08:25 -0400
Received: from sym2.noone.org ([178.63.92.236]:54202 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbeEPPIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:08:23 -0400
Date: Wed, 16 May 2018 17:00:27 +0200
From: Tobias Klauser <tklauser@distanz.ch>
To: YueHaibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethoc: Remove useless test before
 clk_disable_unprepare
Message-ID: <20180516150027.GB24016@distanz.ch>
References: <20180516111822.26440-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516111822.26440-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-16 at 13:18:22 +0200, YueHaibing <yuehaibing@huawei.com> wrote:
> clk_disable_unprepare() already checks that the clock pointer is valid.
> No need to test it before calling it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Tobias Klauser <tklauser@distanz.ch>
