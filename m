Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbeEVV62 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:58:28 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41326 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753141AbeEVV60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:58:26 -0400
Date: Tue, 22 May 2018 23:58:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <vokac.m@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com,
        vivien.didelot@savoirfairelinux.com, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net, michal.vokac@ysoft.com
Subject: Re: [PATCH net-next v2 1/7] net: dsa: qca8k: Add QCA8334 binding
 documentation
Message-ID: <20180522215823.GE4396@lunn.ch>
References: <1526987792-56861-1-git-send-email-michal.vokac@ysoft.com>
 <1526987792-56861-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526987792-56861-2-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 01:16:26PM +0200, Michal Vokáč wrote:
> Add support for the four-port variant of the Qualcomm QCA833x switch.
> 
> The CPU port default link settings can be reconfigured using
> a fixed-link sub-node.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
