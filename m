Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965534AbeEXNRp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:17:45 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43557 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965042AbeEXNRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:17:43 -0400
Date: Thu, 24 May 2018 15:17:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <vokac.m@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net, michal.vokac@ysoft.com
Subject: Re: [PATCH net-next v3 0/7] Add support for QCA8334 switch
Message-ID: <20180524131738.GD24557@lunn.ch>
References: <1527056424-14528-1-git-send-email-michal.vokac@ysoft.com>
 <29ea7cdd-5690-e39a-a2ef-4f48fbcb7659@gmail.com>
 <f8bf325c-77a5-d44b-34c3-93ea4b11fd84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8bf325c-77a5-d44b-34c3-93ea4b11fd84@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thank you too Florian. And also big thank to you Andrew. You helped me
> a lot to debug the RGMII issue. I have been stuck at that for more than
> a month and would not resolve it without your help.

We are here to help. I also got stuck figuring out RGMII issues, so i
know what it feels like...
 
> As I have done this in a process of upgrading our BSP to a more recent
> kernel, and hopefully mainline, I now need to move on to other parts of
> the board.

Do you think you can mainline the board? It would be nice to have an
in kernel board using this switch. If you post the device tree
patches, please Cc: me.

	 Andrew
