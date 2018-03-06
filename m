Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753777AbeCFMs6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 07:48:58 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:48581 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753755AbeCFMs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 07:48:57 -0500
Date: Tue, 6 Mar 2018 13:48:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: mdio-mux: slience probe defer error
Message-ID: <20180306124855.GC26143@lunn.ch>
References: <20180306111045.19315-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306111045.19315-1-jbrunet@baylibre.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 12:10:45PM +0100, Jerome Brunet wrote:
> If we fail to register the mdio bus due to probe defer, we should not
> print an error message. Just be silent in this case.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
