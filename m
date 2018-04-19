Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbeDSOEM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751879AbeDSOEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:04:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEDA2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Thu, 19 Apr 2018 22:03:31 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <anson.huang@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz
 clock source
Message-ID: <20180419140330.GV25429@dragon>
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
 <1521426645-19246-2-git-send-email-Anson.Huang@nxp.com>
 <20180417142203.GM25429@dragon>
 <152410785516.46528.12432838242068784117@swboyd.mtv.corp.google.com>
 <AM3PR04MB1315FCBBAFCE808BD35FF2CFF5B50@AM3PR04MB1315.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM3PR04MB1315FCBBAFCE808BD35FF2CFF5B50@AM3PR04MB1315.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 03:23:39AM +0000, Anson Huang wrote:
> If so, I think we should use V1 patch to keep clocks container?

Ah, right.  I will just pick up v1 of patch #2.

Shawn
