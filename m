Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AE7C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A34F20811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A34F20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeLLHvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:51:03 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44683 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeLLHvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:51:02 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gWzHy-0003fM-0X; Wed, 12 Dec 2018 08:50:38 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gWzHq-0005CD-LG; Wed, 12 Dec 2018 08:50:30 +0100
Date:   Wed, 12 Dec 2018 08:50:30 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hossein Radhasani <radhassani@birjand.ac.ir>
Cc:     svenkatr@ti.com, chris@printf.net, info@sang-engineering.com,
        wsa+renesas@sang-engineering.com,
        alexander.stein@systec-electronic.com, adrian.hunter@intel.com,
        info@pengutronix.de, tomas.melin@vaisala.com, alcooperx@gmail.com,
        markus.schuetterle@intel.com, Avi.Shchislowski@sandisk.com,
        yaniv.agman@sandisk.com, sebras@gmail.com, baolin.wang@linaro.org,
        marcus.folkesson@gmail.com, bengardiner@nanometrics.ca,
        cjb@laptop.org, peppe.cavallaro@st.com, iwamatsu@debian.org,
        wkernelteam@gmail.com, olivier.gay@a3.epfl.ch,
        ubuntu-motu@lists.ubuntu.com, linux-kernel@vger.kernel.org,
        will.newton@gmail.com, linux-mmc@vger.kernel.org,
        matt@console-pimps.org, linux-arm-kernel@lists.infradead.org,
        chris-github@printf.net, hashcode0f@gmail.com,
        ben.l.gardiner@gmail.com
Subject: Re: MMC driver programming help request
Message-ID: <20181212075030.rjx7zoa3dlxu6nya@pengutronix.de>
References: <2352226718-734184@post.birjand.ac.ir>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2352226718-734184@post.birjand.ac.ir>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 12, 2018 at 11:09:31AM +0330, Hossein Radhasani wrote:
> I need some help.
> I have device with eMMC storage and wnat to write on specific page of it.
> I was trying to use MMC driver, but unfortunately have some problems.
> Would you please help me?

The usual approach to get help in the FOSS world is to start describing
the problem you want to solve including the motivation for it. Then show
the things you did to solve the problem including a description how they
failed. And then choose the recipents of the resuling mail carefully and
don't put everyone on Cc who might have mentioned a relevant keyword
once.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
