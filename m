Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965063AbeEITFm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:05:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53857 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964827AbeEITFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:05:40 -0400
Date: Wed, 9 May 2018 21:05:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@savoirfairelinux.com, davem@davemloft.net, f.fainelli@gmail.com
Subject: Re: [PATCH net-next 1/3] net: dsa: mv88e6xxx: add a cascade port op
Message-ID: <20180509190536.GD21718@lunn.ch>
References: <20180509153851.10207-1-vivien.didelot@savoirfairelinux.com>
 <20180509153851.10207-2-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509153851.10207-2-vivien.didelot@savoirfairelinux.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 11:38:49AM -0400, Vivien Didelot wrote:
> Only the 88E6185 family has bits 15:12 Cascade Port bits in the Global
> Control 2 register. Hence inconsistent values are actually written in
> this register for other families.
> 
> Add a .set_cascade_port operation to isolate the 88E6185 case, and call
> it from the device mapping setup function.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
