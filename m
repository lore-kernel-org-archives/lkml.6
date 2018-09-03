Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AB1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E2220857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2D3/uD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E2220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeICGqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeICGqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:46:53 -0400
Received: from dragon (unknown [45.56.155.166])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C93A82077C;
        Mon,  3 Sep 2018 02:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535941733;
        bh=vr5lfdapYRYSIAbW6pazxvaiHayWWHYBlyBQSjx/ViQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2D3/uD6HoZuuwZLCPuDoF+Gu5s5LGkhUnCs9GiqvZX0VmaRlUb4X94YhhqmQbgln
         3ypx4Roiz2fO68cERME08zpzkIB44jyX+OB4SOUnrEZmO+tW5dt31f7DssUzqbD7D9
         OYnlXOLYH804igrlBnu9YnzHYVgPlRmNy7qnzkSY=
Date:   Mon, 3 Sep 2018 10:27:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: enable gpio buttons as wakeup
 source
Message-ID: <20180903022743.GF3850@dragon>
References: <1535612379-8793-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535612379-8793-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 02:59:39PM +0800, Anson Huang wrote:
> This patch enables i.MX6SX SDB board's below GPIO buttons
> as wakeup sources:
> 
> SW4(FUNC1): KEY_VOLUMEUP
> SW5(FUNC2): KEY_VOLUMEDOWN
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
