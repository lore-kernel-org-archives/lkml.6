Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF2FC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94E120857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwlujm9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94E120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbeICFNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 01:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbeICFNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 01:13:30 -0400
Received: from dragon (unknown [45.56.155.166])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21DDE20856;
        Mon,  3 Sep 2018 00:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535936149;
        bh=6zDsyD+tDHWpGNsp6m04W5ybIzzZQk83a0MaJrb4TTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iwlujm9gyE7G6OqC02XOXTUE6hDd5zuz+BQQAyz8sU4HoMl50MclGNaUcI7sv7hWd
         MSFkMXopdurL9AbIMr2FIIB9S8weRALHDmB27MQthDywl/R3WsoTU0XTB1V+kCrSXl
         mdNo2oe5mjh7A4IsoLLm8lImWYKS5QAtFKGf9wQw=
Date:   Mon, 3 Sep 2018 08:54:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx7d-sdb: enable gpio buttons as wakeup source
Message-ID: <20180903005439.GW3850@dragon>
References: <1535507138-4626-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535507138-4626-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 09:45:38AM +0800, Anson Huang wrote:
> This patch enables i.MX7D SDB board's below GPIO buttons
> as wakeup sources:
> 
> S1(FUNC1): KEY_VOLUMEUP
> S3(FUNC2): KEY_VOLUMEDOWN
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
