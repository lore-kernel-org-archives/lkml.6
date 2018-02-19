Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeBSDBe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 22:01:34 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:42788 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbeBSDBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 22:01:32 -0500
X-Google-Smtp-Source: AH8x224XV5dsXJ8bXpU/Oys2P2hytUHGE/RBQ+Wmlp8tZdI0DmCt+sqEBl5Wx20no5hg/Fl2CEH6Jg==
Date: Sun, 18 Feb 2018 21:01:31 -0600
From: Rob Herring <robh@kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        magnus.damm@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] Documentation: devicetree: ravb: Add r8a77965
Message-ID: <20180219030131.ufslinagun7pba3e@rob-hp-laptop>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-14-git-send-email-jacopo+renesas@jmondi.org>
 <20180215154235.ndpizqzkciqyifun@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215154235.ndpizqzkciqyifun@verge.net.au>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:45:34PM +0100, Simon Horman wrote:
> On Tue, Feb 13, 2018 at 10:46:00AM +0100, Jacopo Mondi wrote:
> > Add documentation for r8a77965 compatible string to renesas ravb device
> > tree bindings documentation.
> > 
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> 
> This needs to be CCed to Sergei and netdev to proceed into mainline.
> 
> There are lot of examples and little consistency, but I believe a good
> prefix and subject for the patch would be:
> 
> dt-bindings: net: ravb: Add support for r8a77965 SoC

Reviewed-by: Rob Herring <robh@kernel.org>
