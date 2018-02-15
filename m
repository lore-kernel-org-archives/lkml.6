Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425135AbeBOPuS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:50:18 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:50646 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424982AbeBOPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:47:57 -0500
Date: Thu, 15 Feb 2018 16:47:52 +0100
From: Simon Horman <horms@verge.net.au>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: geert@linux-m68k.org, magnus.damm@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] Documentation: devicetree: renesas,sci: Add
 r8a77965
Message-ID: <20180215154752.ukm43os7fl7xnlie@verge.net.au>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-9-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518515162-23663-9-git-send-email-jacopo+renesas@jmondi.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:45:55AM +0100, Jacopo Mondi wrote:
> Add documentation for r8a77965 compatible string to reneass sci-serial
> device tree bindings documentation.

I think a better subject would be:

dt-bindings: serial: sh-sci: Add support for r8a77965 (H)SCIF
