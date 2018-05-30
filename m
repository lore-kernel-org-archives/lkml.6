Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932549AbeE3U5U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:57:20 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50074 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932263AbeE3U5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:57:17 -0400
Date: Wed, 30 May 2018 22:57:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mdio-mux-gpio: Remove VLA usage
Message-ID: <20180530205712.GB16286@lunn.ch>
References: <20180530204830.GA24884@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530204830.GA24884@beast>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 01:48:30PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> moves the allocation into struct mdio_mux_gpio_state during probe.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: allocate array as part of structure (Andrew Lunn)

Hi Kees

This looks much better, thanks.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
