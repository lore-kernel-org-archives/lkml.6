Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8695C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432DE20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVw8vVXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432DE20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbeICEUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 00:20:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeICEUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 00:20:47 -0400
Received: from dragon (unknown [45.56.155.166])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8816920856;
        Mon,  3 Sep 2018 00:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535932994;
        bh=FwiOupdmhn/Fiw9R8sAj+WHxfxmGd1P4hQA9a66JBqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVw8vVXgfSjLeI9MlCB2hCtxOgD2275qk2WSgoGtREmRhzNptql6qmrkSgsyMHiOI
         9pnLFbwESwviFb2kwXS4VT8E0E1hdQ28HYWJDI6o9qG9yQfQsINh/wNUp7SpXDEsuT
         dJgsXX56Nu9O6UzvqKBtwa5uBEK7KMov2Bdd5UBA=
Date:   Mon, 3 Sep 2018 08:02:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pierre-Jean Texier <texier.pj2@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx7s-warp: use SPDX-License-Identifier
Message-ID: <20180903000204.GU3850@dragon>
References: <1535475997-21027-1-git-send-email-texier.pj2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535475997-21027-1-git-send-email-texier.pj2@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 07:06:37PM +0200, Pierre-Jean Texier wrote:
> Adopt the SPDX license identifier headers to ease
> license compliance management.
> 
> Signed-off-by: Pierre-Jean Texier <texier.pj2@gmail.com>

Applied, thanks.
