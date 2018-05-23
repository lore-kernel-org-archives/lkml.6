Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754602AbeEWI5b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:57:31 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:57059 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754334AbeEWI52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:57:28 -0400
Date: Wed, 23 May 2018 10:57:24 +0200
From: Simon Horman <horms@verge.net.au>
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 1/6] dt-bindings: arm: Document the RZN1D-DB board
Message-ID: <20180523085723.yp6qc32cozaf7l2n@verge.net.au>
References: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com>
 <1526983321-41949-2-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526983321-41949-2-git-send-email-michel.pollet@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 11:01:21AM +0100, Michel Pollet wrote:
> This documents the RZ/N1 bindings for the RZN1D-DB board.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

This looks fine but I will wait to see if there are other reviews before
applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
