Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeCONx0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751559AbeCONxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:53:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E08204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Thu, 15 Mar 2018 21:52:26 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 1/2] soc: imx: gpcv2: Do not pass static memory as
 platform data
Message-ID: <20180315135225.GK26859@dragon>
References: <20180122150748.1742-1-andrew.smirnov@gmail.com>
 <20180208064709.GB31910@dragon>
 <20180315030804.GI26859@dragon>
 <CAHQ1cqHdtN7xjmAcQvKDknnGKAP0pRgk6pcFrzOiSew9=Z9GQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqHdtN7xjmAcQvKDknnGKAP0pRgk6pcFrzOiSew9=Z9GQg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 06:00:06AM -0700, Andrey Smirnov wrote:
> I am slightly confused by your phrasing. Are you:
> 
> a) saying that you dropped my patches in favor of your own that use
> platform_device_add_data()
> 
> or
> 
> b) asking me to convert my patches to use platform_device_add_data()?
> 
> Just trying to figure out if any action on my part is necessary.

Sorry for the blur.  I'm asking you to repost your patches with using
platform_device_add_data().  In other word, that's b).

Shawn
