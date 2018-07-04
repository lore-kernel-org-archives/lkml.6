Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD57C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6192473F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6192473F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753704AbeGDHEy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:04:54 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.93]:53296 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbeGDHEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:04:52 -0400
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jul 2018 03:04:51 EDT
Received: from [89.1.81.74] (helo=karo-electronics.de)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <LW@KARO-electronics.de>)
        id 1fabhv-0003Zn-EM; Wed, 04 Jul 2018 08:56:07 +0200
Date:   Wed, 4 Jul 2018 08:56:06 +0200
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "festevam@gmail.com" <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Message-ID: <20180704085606.78bb104b@karo-electronics.de>
In-Reply-To: <1530697336.15665.43.camel@nxp.com>
References: <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
        <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
        <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
        <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
        <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
        <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
        <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com>
        <AM3PR04MB13155B8D567ABEF7EF03249AF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
        <CAOMZO5BdtxKjQge5ONpnjr1yNVeTJf4u8Gh-fPqpHz7G9ipOTg@mail.gmail.com>
        <1530526335.15665.13.camel@nxp.com>
        <20180703053843.GC4348@dragon>
        <AM3PR04MB131542D42FCD798FDBBA54BFF5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
        <CAOMZO5BY99f5jjU+73=8WjqwBKr_q2S1mvx90URZUBkgOVn9YA@mail.gmail.com>
        <1530697336.15665.43.camel@nxp.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 4 Jul 2018 01:42:54 +0000 Robin Gong wrote:
> On 二, 2018-07-03 at 08:10 -0300, Fabio Estevam wrote:
> > Hi Anson,
> > 
> > On Tue, Jul 3, 2018 at 4:44 AM, Anson Huang <anson.huang@nxp.com>
> > wrote:
> > 
> > > 
> > > It is NOT easy to identify which switch is critical or NOT, and
> > > different platforms
> > > have different board design, it will introduce many platform
> > > specified code, so I think
> > > just revert the pfuze100 switch enable/disable patch should be OK
> > > for now.
> > I have sent the pfuze100 regulator patch revert and it is linux-next
> > now. Should probably reach 4.18-rc4.
> > 
> > > 
> > > After a couple of release cycles, add the pfuze100 switch
> > > enable/disable patch
> > > back to support this feature, I believe users should switch to new
> > > dtb with "regulator-always-on"
> > > existing already.
> > That will still break old dtb compatibility.
> > 
> > You cannot force users to use "regulator-always-on" and the old dtbs
> > need to always work.
> > 
> > So whatever new feature you need to introduce it needs to be done in
> > such a way that the existing dtb's will continue working.
> But actually existing dtb is not right since the critical power rail
> missing 'regulator-always-on'. It's a fix patch for dts, not related
> with following dtb/kernel break rules, just a simple dts patch. Why
> should we make promise for the wrong dtbs?
>
Because they are living in the outside world on real devices.


Lothar Waßmann
