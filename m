Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D207C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C68A2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550766680;
	bh=kp4/IkYZsWH3WJnaY1m5zZeuGRUtHlhj+oNa/o5Nlbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2I8wiNy2lbte/nJ1+wYw9M9i6+JtTyW95hDxcqYMW+7u/tRz0ltdf/hy1whHo8NIZ
	 nmkjawBMF3VPQNPOE81jj3IdoqNBNftYPaU7zVXub93gMj4qnP65Ok91lNlOSER6zL
	 wtf3XN0KwAyb7fK0ore0PSnytKhqFWD61lBtapIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfBUQbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:31:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfBUQbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:31:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99D752084D;
        Thu, 21 Feb 2019 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550766678;
        bh=kp4/IkYZsWH3WJnaY1m5zZeuGRUtHlhj+oNa/o5Nlbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUQZ/+JMPriemEgQpdkGx44pMA9xMRb3TUAupKaqPNeKEXkQhMmD4ooTBE701H0Gp
         j6RTekp1B1j+L+ARWfPl9j1AQ0COBF5FDRFmmna7JU2OTIN7W0982zhAyNtZrXJ10m
         ajoXoda/IRidmM3mekT2dAr17GsTcpnoR+RRQwME=
Date:   Thu, 21 Feb 2019 17:31:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH v3 2/5] base: soc: Export soc_device_register/unregister
 APIs
Message-ID: <20190221163115.GC8727@kroah.com>
References: <20190221162419.32384-1-vaishali.thakkar@linaro.org>
 <20190221162419.32384-3-vaishali.thakkar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221162419.32384-3-vaishali.thakkar@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 09:54:16PM +0530, Vaishali Thakkar wrote:
> From: Vinod Koul <vkoul@kernel.org>
> 
> Qcom Socinfo driver can be built as a module, so
> export these two APIs.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
> ---
> Changes since v2:
> 	- Reordered patches [patch 5->patch 2]
> Changes since v1:
> 	- None

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
