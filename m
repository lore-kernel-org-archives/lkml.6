Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbeFBG7Q (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 02:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeFBG7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 02:59:14 -0400
Date: Sat, 2 Jun 2018 08:58:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: sboyd@kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] clk: Return void from debug_init op
Message-ID: <20180602065851.GB32552@kroah.com>
References: <20180602050643.87253-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180602050643.87253-1-sboyd@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 10:06:43PM -0700, sboyd@kernel.org wrote:
> From: Stephen Boyd <sboyd@kernel.org>
> 
> We only have two users of the debug_init hook, and we recently stopped
> caring about the return value from that op. Finish that off by changing
> the clk_op to return void instead of int because it doesn't matter if
> debugfs fails or not.
> 
> Cc: Eric Anholt <eric@anholt.net>
> Cc: David Lechner <david@lechnology.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
