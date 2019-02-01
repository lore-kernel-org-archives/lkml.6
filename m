Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA83DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B487520863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548989784;
	bh=3UlvWOx2LV4KzLdHPnGFxIy+KFeK2cJa5/p692Bwadc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AgClzJo49nUkLkZbFt3+eTYI1Ra7bthaqsfFUePETXcN435kFTJ7kni4fORhaFq2G
	 JAUl4ynXAoYr/W/lhRJz83egZN5z7XrFRwT9JU9hjk1QMVCGdafWOZxcZpTs7j+fCJ
	 +M9EqwxGW7GbinlOKK6EUG/HfpdmlAebcpm0ph8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfBAC4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 21:56:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfBAC4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 21:56:22 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C50120863;
        Fri,  1 Feb 2019 02:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548989781;
        bh=3UlvWOx2LV4KzLdHPnGFxIy+KFeK2cJa5/p692Bwadc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jp6u8k4noNELMfik0OyRQb/W0H8kmr6/AtBUJ5YtRczZA0fysm2hYamLt8ZZ/Km1G
         OVTX90WAViMR5Rq3f1SSzaxP/L+LOmaYVBXheHXLcMKQnr1I5d3fNb++/P1VEzNCA+
         isi8prq4Xc2s7bBebXffzUquEX8Gn+QqDyIRPBK0=
Date:   Fri, 1 Feb 2019 10:56:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 4/5] arm64: defconfig: enable NXP FlexSPI driver
Message-ID: <20190201025607.GB19882@dragon>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547553487-9936-5-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547553487-9936-5-git-send-email-yogeshnarayan.gaur@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 12:00:31PM +0000, Yogesh Narayan Gaur wrote:
> Enable driver support of NXP FlexSPI controller.
> 
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>

Applied, thanks.
