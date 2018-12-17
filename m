Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52478C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BEE21836
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545027610;
	bh=B9g85TgZ3lGVWga/ob1Pvz8P1H1bmKrgu/pcgPbgNy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uyNRGRdHMML3500TUsHbBmMuqyjKxPlyKVqpiQXkrVm6p/YEkCMdTnp+iscf7KZfE
	 Ch/XEhNQTSw6i5E24NQu11b8a5P0cbR/QjfsNvwtpisZSnF3FidNvveUW35+JDgXVB
	 yBCkuRKsAaFrD3lUJ740ao76yKQgc0DtowEAnLJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbeLQGUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:20:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbeLQGUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:20:08 -0500
Received: from localhost (unknown [171.61.92.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09BCE217F5;
        Mon, 17 Dec 2018 06:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545027607;
        bh=B9g85TgZ3lGVWga/ob1Pvz8P1H1bmKrgu/pcgPbgNy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xazLEy9wzxalhq1TQyCGYaIc2y4YMqi4RohuIJAP7mN7WrI9WZJNa8Na+4141QJx5
         DanrfCcRTRuQUIKaUkOhb3zKKrOuNLD3dL2mNrKOt6APglqUa7tYrnqobu3bLY3Ht3
         oMunLhX7rCoDC0LxUOpmxATRZBDVj4bhNbRwHbC4=
Date:   Mon, 17 Dec 2018 11:49:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     dan.j.williams@intel.com, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr, okaya@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: amba-pl08x: convert to
 DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181217061959.GG2472@vkoul-mobl>
References: <20181205161900.16434-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205161900.16434-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-12-18, 11:18, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Applied all 4, thanks
-- 
~Vinod
