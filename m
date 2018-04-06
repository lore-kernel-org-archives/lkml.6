Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeDFRXk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:23:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52592 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbeDFRXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:23:39 -0400
Date: Fri, 6 Apr 2018 19:23:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Esben Haabendal <esben.haabendal@gmail.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, Esben Haabendal <eha@deif.com>
Subject: Re: [PATCH v2] dp83640: Ensure against premature access to PHY
 registers after reset
Message-ID: <20180406172337.GR17495@lunn.ch>
References: <20180406140540.13511-1-esben.haabendal@gmail.com>
 <20180406170844.4248-1-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406170844.4248-1-esben.haabendal@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 07:08:44PM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
 
Hi Esben

It it good to have some form of commit message. Something like:

The datasheet specifies a 3uS pause after performing a software
reset. The default implementation of genphy_soft_reset() does not
provide this, so implement soft_reset with the needed pause.


With that, or something similar added:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
