Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9AAECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313AA2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4xOQxjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313AA2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbeGTDea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 23:34:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbeGTDea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 23:34:30 -0400
Received: from dragon (unknown [45.56.152.101])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE55920673;
        Fri, 20 Jul 2018 02:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532054909;
        bh=9HpIh4ySe4xPfYED7zTJqKEIAJxv2tTcT5kdnL3K2vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R4xOQxjU+Mvmb3rIrYtcNflUvRR4a7n+Camr6ypDRmn9crCH7Ie0ahImo6qfcJkMj
         SxIzKRVg2Sa4UqiFVNTIOY4uGFHH7LLS8qrWp41juJuCP5/Veh9k90m+F+W+M78+wJ
         I3s/RGF0RfeLeX6/MB8rCgPIYI46RrQS763eFdzQ=
Date:   Fri, 20 Jul 2018 10:48:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx7d: remove "operating-points" property for
 cpu1
Message-ID: <20180720024808.GZ4576@dragon>
References: <1531988659-9466-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531988659-9466-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 04:24:19PM +0800, Anson Huang wrote:
> Commit b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
> added "operating-points" property for all CPUs, but i.MX7D already has
> "operating-points-v2" property on both CPUs, so no need to add
> "operating-points" property again, this patch removes it.
> 
> Fixes: b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
