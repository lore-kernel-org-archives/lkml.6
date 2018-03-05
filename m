Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932630AbeCEWlk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:41:40 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:48146 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752856AbeCEWlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:41:39 -0500
Date: Mon, 5 Mar 2018 23:41:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Brandon Streiff <brandon.streiff@ni.com>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: dsa: marvell: describe
 compatibility string
Message-ID: <20180305224126.GB17529@lunn.ch>
References: <1520287522-308-1-git-send-email-brandon.streiff@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520287522-308-1-git-send-email-brandon.streiff@ni.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 04:05:22PM -0600, Brandon Streiff wrote:
> There are two compatibility strings for mv88e6xxx, but it isn't clear
> from the documentation why only those two exist when the mv88e6xxx driver
> supports more than the 6085 and 6190. Briefly describe how the compatible
> property is used, and provide guidance on which to use.
> 
> The model list comes from looking at port_base_addr values (0x0 vs 0x10)
> in drivers/net/dsa/mv88e6xxx/chip.c.
> 
> Signed-off-by: Brandon Streiff <brandon.streiff@ni.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
