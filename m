Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933773AbeBLPz2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:55:28 -0500
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:42709 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932485AbeBLPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:55:26 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:965:966:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1431:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3868:4321:4385:4390:4395:5007:7514:7875:10004:10400:10848:11232:11658:11914:12043:12048:12555:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21611:21627:30054:30055:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: skin68_864aee451f05b
X-Filterd-Recvd-Size: 1824
Message-ID: <1518450921.4139.9.camel@perches.com>
Subject: Re: [PATCH v2] MAINTAINERS: add Freescale pin controllers
From: Joe Perches <joe@perches.com>
To: Stefan Agner <stefan@agner.ch>, linus.walleij@linaro.org,
        aisheng.dong@nxp.com, fabio.estevam@nxp.com, shawnguo@kernel.org,
        kernel@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Feb 2018 07:55:21 -0800
In-Reply-To: <20180212150549.8622-1-stefan@agner.ch>
References: <20180212150549.8622-1-stefan@agner.ch>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-12 at 16:05 +0100, Stefan Agner wrote:
> Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as maintainer
> and the Pengutronix kernel team as reviewer.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -10768,6 +10768,17 @@ L:	linux-gpio@vger.kernel.org
>  S:	Supported
>  F:	drivers/pinctrl/pinctrl-at91-pio4.*
>  
> +PIN CONTROLLER - FREESCALE
> +M:	Dong Aisheng <aisheng.dong@nxp.com>
> +M:	Fabio Estevam <festevam@gmail.com>
> +M:	Shawn Guo <shawnguo@kernel.org>
> +M:	Stefan Agner <stefan@agner.ch>
> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> +L:	linux-gpio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pinctrl/freescale/*

The * here should probably be removed so perhaps just

F:	drivers/pinctrl/freescale/

> +F:	Documentation/devicetree/bindings/pinctrl/fsl,*
> +
>  PIN CONTROLLER - INTEL
>  M:	Mika Westerberg <mika.westerberg@linux.intel.com>
>  M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
