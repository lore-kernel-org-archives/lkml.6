Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeEOHL5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752165AbeEOHLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:11:55 -0400
Date: Tue, 15 May 2018 15:11:11 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: =?iso-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: s.hauer@pengutronix.de, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx53-voipac-dmm-668: Use IRQ_TYPE specifier
Message-ID: <20180515071110.GN26863@dragon>
References: <1526254051-3929-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526254051-3929-1-git-send-email-hernan@vanguardiasur.com.ar>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 08:27:31PM -0300, Hernán Gonzalez wrote:
> Replace magic number with the proper IRQ_TYPE specifier to improve DT
> readability.
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>

Applied, thanks.
