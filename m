Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeBSC7h (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 21:59:37 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39754 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeBSC7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 21:59:35 -0500
X-Google-Smtp-Source: AH8x226ySOayKlZsYQMYrR0EnnY/2QyIU66IKeFjPI1/icD7C8VYN+Otmv/60/AlidMDKmhDT46Wsg==
Date: Sun, 18 Feb 2018 20:59:33 -0600
From: Rob Herring <robh@kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        magnus.damm@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] Documentation: devicetree: renesas,sci: Add
 r8a77965
Message-ID: <20180219025933.k5s4zehuwb7gbrvt@rob-hp-laptop>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-9-git-send-email-jacopo+renesas@jmondi.org>
 <20180215154752.ukm43os7fl7xnlie@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215154752.ukm43os7fl7xnlie@verge.net.au>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:47:52PM +0100, Simon Horman wrote:
> On Tue, Feb 13, 2018 at 10:45:55AM +0100, Jacopo Mondi wrote:
> > Add documentation for r8a77965 compatible string to reneass sci-serial
> > device tree bindings documentation.
> 
> I think a better subject would be:
> 
> dt-bindings: serial: sh-sci: Add support for r8a77965 (H)SCIF

Reviewed-by: Rob Herring <robh@kernel.org>
