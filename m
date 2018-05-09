Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965155AbeEITI5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:08:57 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53870 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964943AbeEITI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:08:56 -0400
Date: Wed, 9 May 2018 21:08:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@savoirfairelinux.com, davem@davemloft.net, f.fainelli@gmail.com
Subject: Re: [PATCH net-next 3/3] net: dsa: mv88e6xxx: add RMU disable op
Message-ID: <20180509190854.GF21718@lunn.ch>
References: <20180509153851.10207-1-vivien.didelot@savoirfairelinux.com>
 <20180509153851.10207-4-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509153851.10207-4-vivien.didelot@savoirfairelinux.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 11:38:51AM -0400, Vivien Didelot wrote:
> The RMU mode bits moved a lot within the Global Control 2 register of
> the Marvell switch families. Add an .rmu_disable op to support at least
> 3 known alternatives.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
