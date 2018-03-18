Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbeCREm5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 00:42:57 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:56855 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750789AbeCREm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 00:42:56 -0400
Date: Sun, 18 Mar 2018 06:42:48 +0200
From: Baruch Siach <baruch@tkos.co.il>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com, ymarkman@marvell.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.chevallier@bootlin.com, nadavh@marvell.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
        stefanc@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 05/10] phy: cp110-comphy: 2.5G SGMII mode
Message-ID: <20180318044247.kp3i2ymvrj5fdoj3@sapphire.tkos.co.il>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-6-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316103351.16616-6-antoine.tenart@bootlin.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antoine,

On Fri, Mar 16, 2018 at 11:33:46AM +0100, Antoine Tenart wrote:
> This patch allow the CP100 comphy to configure some lanes in the

Should be 'CP110'.

> 2.5G SGMII mode. This mode is quite close to SGMII and uses nearly the
> same code path.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
