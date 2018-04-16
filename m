Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754113AbeDPIpB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753223AbeDPIo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:44:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640AB2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 16 Apr 2018 16:44:25 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V6 2/2] thermal: imx: add i.MX7 thermal sensor support
Message-ID: <20180416084423.GG25429@dragon>
References: <1519955970-11365-1-git-send-email-Anson.Huang@nxp.com>
 <1519955970-11365-2-git-send-email-Anson.Huang@nxp.com>
 <AM3PR04MB13158EE8C129D6AEC605A106F5D20@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <1520923865.3766.4.camel@intel.com>
 <20180315005140.GB12096@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315005140.GB12096@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eduardo,

On Wed, Mar 14, 2018 at 05:51:42PM -0700, Eduardo Valentin wrote:
> On Tue, Mar 13, 2018 at 02:51:05PM +0800, Zhang Rui wrote:
> > yeah, will review it and get back to you later.
> 
> This is in my tree now.

It seems that the patch did not make its way to 4.17-rc1?

Shawn
