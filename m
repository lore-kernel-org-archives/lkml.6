Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeEOHLJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbeEOHLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:11:08 -0400
Date: Tue, 15 May 2018 15:10:23 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: =?iso-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: s.hauer@pengutronix.de, kernel@pengutronix.de, stefan@agner.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vf-colibri-eval-v3.dtsi: Use IRQ_TYPE specifier
Message-ID: <20180515071021.GL26863@dragon>
References: <1526253894-3709-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526253894-3709-1-git-send-email-hernan@vanguardiasur.com.ar>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 08:24:54PM -0300, Hernán Gonzalez wrote:
> GPIO_ACTIVE_LOW was being used to specify an interrupt, use
> IRQ_TYPE_EDGE_RISING instead. This improves DT readability.
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>

Applied, thanks.
