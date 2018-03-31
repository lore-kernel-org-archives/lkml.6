Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeCaRgx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 13:36:53 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48067 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752922AbeCaRgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 13:36:52 -0400
Date: Sat, 31 Mar 2018 19:36:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joe Perches <joe@perches.com>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Subject: Re: [PATCH 02/12] treewide/net: Rename eth_stp_addr to ether_stp_addr
Message-ID: <20180331173643.GD7460@lunn.ch>
References: <cover.1522479607.git.joe@perches.com>
 <a2d52bbcdcd36c5062bd4fa175df15acd5f8cb85.1522479607.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2d52bbcdcd36c5062bd4fa175df15acd5f8cb85.1522479607.git.joe@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 12:05:17AM -0700, Joe Perches wrote:
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -1,4 +1,4 @@
> -/*
> +gg/*

Hi Joe

This does not look good.

     Andrew
