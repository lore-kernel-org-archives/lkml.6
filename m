Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752957AbeBTQrW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:47:22 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51629 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbeBTQrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:47:21 -0500
Message-ID: <1519145232.3470.13.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/3] reset: simple: enable for ASPEED SoCs
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>
Cc: Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Date: Tue, 20 Feb 2018 17:47:12 +0100
In-Reply-To: <20180220014330.23425-1-joel@jms.id.au>
References: <20180220014330.23425-1-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Tue, 2018-02-20 at 12:13 +1030, Joel Stanley wrote:
> v2: Fix typos in bindings document, add Rob's ack
> 
> This series that enables the simple reset driver for the ASPEED SoCs.

Thanks, I have applied patches 1 (with fixup for a whitespace issue that
git complained about) and 2 to the reset/next branch.
I have dropped patch 3 for now because it doesn't seem necessary, but if
there is an actual user that wants to disable reset-simple and UART on
small ASPEED systems, I'll be happy to add it with an explanation.

regards
Philipp
