Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeDYLww (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:52:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59938 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbeDYLws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:52:48 -0400
Date: Wed, 25 Apr 2018 13:52:36 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net 2/3] net: mvpp2: Fix clock resource by adding
 missing mg_core_clk
Message-ID: <20180425135236.24bc0644@bootlin.com>
In-Reply-To: <87in8feckt.fsf@bootlin.com>
References: <20180425110731.20153-1-maxime.chevallier@bootlin.com>
        <20180425110731.20153-3-maxime.chevallier@bootlin.com>
        <87in8feckt.fsf@bootlin.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory,

On Wed, 25 Apr 2018 13:43:14 +0200
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

>Hi Maxime,
> 
> On mer., avril 25 2018, Maxime Chevallier
> <maxime.chevallier@bootlin.com> wrote:
>
>> Marvell's PPv2.2 IP needs an additional clock named "MG Core clock".
>> This is required on Armada 7K and 8K.
>>
>> This commit adds the required clock, updates the devicetree and its
>> documentation accordingly, also fixing a small typo in the
>> marvell-mpp2.txt examples.
>>
>> Fixes: c7e92def1ef4 ("clk: mvebu: cp110: Fix clock tree
>> representation") Signed-off-by: Maxime Chevallier
>> <maxime.chevallier@bootlin.com> ---
>>  .../devicetree/bindings/net/marvell-pp2.txt          |  9 +++++----
>>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi        |  5 +++--  
>
>Could you remove the dtsi part and submit it as a separate patch. Then
>I will take care of it.

Ok no problem, I'll split that and re-send it.

Thanks,

Maxime

-- 
Maxime Chevallier, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
