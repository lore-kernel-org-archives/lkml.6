Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uUw49DTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB76760764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeFFMeh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:34:37 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56010 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeFFMef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:34:35 -0400
Date: Wed, 6 Jun 2018 14:34:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: David Miller <davem@davemloft.net>,
        Hayes Wang <hayeswang@realtek.com>, hkallweit1@gmail.com,
        romieu@fr.zoreil.com, Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ryankao <ryankao@realtek.com>
Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
Message-ID: <20180606123425.GA14898@lunn.ch>
References: <20180605045812.17977-1-kai.heng.feng@canonical.com>
 <20180605141114.GC14873@lunn.ch>
 <8BAED2AC-DA94-4F63-BA16-EB3D54649BC5@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8BAED2AC-DA94-4F63-BA16-EB3D54649BC5@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andrew,
> 
> Sure.
> 
> Do you think we should also strip out the enable/disable logic?
> 
> Or just remove the parameter?

Hi Kai-Heng

How would you use the logic if you remove the parameter?

    Andrew
