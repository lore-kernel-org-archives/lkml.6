Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbeC1P1a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:27:30 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45370 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753119AbeC1P12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:27:28 -0400
Date: Wed, 28 Mar 2018 17:27:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
Cc: =?utf-8?B?VmljZW7Fo2l1?= Galanopulo <vicentiu.galanopulo@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>
Subject: Re: [RFC PATCH v2] net: phy: Added device tree binding for dev-addr
 and dev-addr code check-up
Message-ID: <20180328152719.GF19452@lunn.ch>
References: <20180323150522.9603-1-vicentiu.galanopulo@nxp.com>
 <20180326222509.ppt5aqzqdarhm44d@rob-hp-laptop>
 <HE1PR0402MB3578B3D33160EBE59C2FD7D7EEAC0@HE1PR0402MB3578.eurprd04.prod.outlook.com>
 <20180327142408.GL5862@lunn.ch>
 <CAL_JsqJGaGdEgSnnMG8C7P6=gELnuxa-oNgBgK2Yk94HcA=LFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJGaGdEgSnnMG8C7P6=gELnuxa-oNgBgK2Yk94HcA=LFg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If this is a rare case and something future devices should get right,
> then I'm more inclined to use 'dev-addr' rather than extending reg.

Hi Rob

The sample size is a bit small at the moment to know how rare it is.
I think we have 6 C45 devices so far, and two get this wrong. C45 is
mostly used for PHY device with > 1Gbps. There are not so many of
these yet.

I would also prefer to use 'dev-addr'.

  Andrew
