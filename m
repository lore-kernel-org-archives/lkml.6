Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeCZPdJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:33:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42235 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751865AbeCZPdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:33:08 -0400
Date: Mon, 26 Mar 2018 17:32:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: sean.wang@mediatek.com
Cc: davem@davemloft.net, f.fainelli@gmail.com,
        vivien.didelot@savoirfairelinux.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 1/2] net: dsa: mt7530: remove redundant MODULE_ALIAS
 entries
Message-ID: <20180326153257.GB3014@lunn.ch>
References: <2497321afc9156f7954e813721f60a0a95c03bd2.1522057659.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2497321afc9156f7954e813721f60a0a95c03bd2.1522057659.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 06:07:09PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> MODULE_ALIAS exports information to allow the module to be auto-loaded at
> boot for the drivers registered using legacy platform registration.
> 
> However, currently the driver is always used by DT-only platform,
> MODULE_ALIAS is redundant and should be removed properly.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

For this, and the second patch:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
