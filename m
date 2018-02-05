Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeBEPLc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:11:32 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:46110 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752924AbeBEPLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:11:24 -0500
Date: Mon, 5 Feb 2018 16:11:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Colin King <colin.king@canonical.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy-micrel: remove redundant initialization of
 pointer of_node
Message-ID: <20180205151122.GE11811@lunn.ch>
References: <20180205124759.19046-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205124759.19046-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 12:47:59PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer of_node is initialized with a value that is never read, of_node
> is later updated with a new value instead, hence the initialization is
> redundant and can be removed.  Also remove unused pointer dev and
> remove an empty line.
> 
> Cleans up clang warnings:
> drivers/net/phy/micrel.c:393:28: warning: Value stored to 'of_node'
> during its initialization is never read
> drivers/net/phy/micrel.c:532:28: warning: Value stored to 'of_node'
> during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Hi Colin

You probably need to repost once netdev re-opens.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
