Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753060AbeE1DIh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 23:08:37 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46740 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752973AbeE1DIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 23:08:35 -0400
Date: Mon, 28 May 2018 05:08:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Onnasch <alexander.onnasch@landisgyr.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/phy/micrel: Fix for PHY KSZ8061 errrata:
 Potential link-up failure when Ethernet cable is connected slowly
Message-ID: <20180528030832.GA18029@lunn.ch>
References: <1527251853-22218-1-git-send-email-alexander.onnasch@landisgyr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527251853-22218-1-git-send-email-alexander.onnasch@landisgyr.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This e-mail (including any attachments) is confidential and may be
> legally privileged. If you are not an intended recipient or an
> authorized representative of an intended recipient, you are
> prohibited from using, copying or distributing the information in
> this e-mail or its attachments. If you have received this e-mail in
> error, please notify the sender immediately by return e-mail and
> delete all copies of this message and any attachments. Thank you.

Once this has been removed, i will have a comment...

     Andrew
