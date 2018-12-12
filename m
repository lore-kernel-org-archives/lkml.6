Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D16C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E4920849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544603314;
	bh=kyn7WMvhw9vtVLBKYCzP9JsHPz/mcJaDumGF68CKvm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LB7ompGwGQVeNWgb4R4rRnAnq8SYht/WPO7K6q9r1XNusSPfsP9IgHvXp8QXZQKek
	 naOzmKjKxnFefq0HNCFLZSQ6tUVn3anzHKdEPyQSjb4S7XAkSqG7BHuVGbhYJAy29Q
	 1TP0vTfa01fZkMJVjWRTQvvcqASH1en4wt9UeJYU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E4920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbeLLI2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:28:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbeLLI2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:28:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 356CE20849;
        Wed, 12 Dec 2018 08:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544603312;
        bh=kyn7WMvhw9vtVLBKYCzP9JsHPz/mcJaDumGF68CKvm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekNKPPgOeI8yCnXtb8sKKc4x/m4Pbil6blIeVvhMYvtWzkiwUbcqm7nneJ2goUdq0
         KACwytSG7DAY5f8Qu55KLOb+8iSAVQoTBHLFst6PGDTZfuVXWeWsPYkShWX49J/gD0
         nfaCEdRPTQ8Y+oIrvlKet3jtxLn7f+FnSnx6Uzp4=
Date:   Wed, 12 Dec 2018 09:27:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PHY: for 4.21
Message-ID: <20181212082735.GA21261@kroah.com>
References: <20181212050836.2066-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212050836.2066-1-kishon@ti.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:38:36AM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request for 4.21 merge window below.
> 
> The major changes are, the set_mode ops now takes 2 arguments (mode and
> submode) instead of just 'mode'. The value in 'submode' will be specific to
> 'mode'. The other major change is PHY framework now gets 2 new APIs
> phy_configure() and phy_validate(). This will help MIPI D-PHYs and its
> consumers to use PHY framework. The MIPI PHY drivers and the GPU driver
> changes will be merged later.
> 
> Apart from these, there are a couple of new PHY drivers: a freescale
> USB PHY driver and a TI Ethernet PHY driver. Please see the tag message
> for the list of changes.
> 
> Let me know If I have to make any changes.

Now pulled, thanks!

greg k-h
