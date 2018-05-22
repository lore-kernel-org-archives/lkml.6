Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeEVQAr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:00:47 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:37945 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbeEVQAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:00:09 -0400
X-Google-Smtp-Source: AB8JxZoXuhDQI9kK5JTkjUcl8RrR3dVMIM4AWte65ZEZ9cGMDfuSVB5isW04wc5CywvBWusxNVccRQ==
Date: Tue, 22 May 2018 11:00:07 -0500
From: Rob Herring <robh@kernel.org>
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 2/6] dt-bindings: Add the rzn1-clocks.h file
Message-ID: <20180522160007.GA5759@rob-hp-laptop>
References: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com>
 <1526983321-41949-3-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526983321-41949-3-git-send-email-michel.pollet@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 11:01:22AM +0100, Michel Pollet wrote:
> This adds the constants necessary to use the renesas,rzn1-clocks driver.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  include/dt-bindings/clock/rzn1-clocks.h | 187 ++++++++++++++++++++++++++++++++
>  1 file changed, 187 insertions(+)
>  create mode 100644 include/dt-bindings/clock/rzn1-clocks.h

Reviewed-by: Rob Herring <robh@kernel.org>
