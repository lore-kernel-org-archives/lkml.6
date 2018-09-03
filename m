Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17BAC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C1620867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuX7oilS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C1620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeICPJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbeICPJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:09:14 -0400
Received: from localhost (unknown [106.200.199.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A855E20862;
        Mon,  3 Sep 2018 10:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535971778;
        bh=GxaBjUF8qXpfxq6y6nbktQfqCMoXPbaVWbeM83SKIMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuX7oilS5Jms0mFHCXrIhxQg7wco6+pb2K9axX4KKXY2GoD+soaeblXUUbghQ2mU3
         Rot1OGCIs7XcpkPFO9XSb+M1khIE89fqBJaKR2FZ949FajZG2DwM93TJsPary5s0b+
         ccpVjVcllrYHQBLFoy1Yd+vuObNTGdMvqszqHFsI=
Date:   Mon, 3 Sep 2018 16:19:29 +0530
From:   Vinod <vkoul@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH v4 2/7] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cylic mode align split descriptors
Message-ID: <20180903104929.GG2322@vkoul-mobl>
References: <20180802141012.19970-1-andrea.merello@gmail.com>
 <20180802141012.19970-2-andrea.merello@gmail.com>
 <20180827053002.GT2388@vkoul-mobl>
 <CAN8YU5MOdz_sW06B8yc_kewjsxP0DP5pgB2bSu=vkNG-ezvMpQ@mail.gmail.com>
 <CAN8YU5M0tJmsU4Xp+0xDwQYtqeB8tPP_4FyBC_ctUOSV=HZNmA@mail.gmail.com>
 <20180830132745.GC2322@vkoul-mobl>
 <CAN8YU5NpOsY-J9yNA6vAmmLTVrtknwxNP7pjhLJDm=-WQ0+Fuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN8YU5NpOsY-J9yNA6vAmmLTVrtknwxNP7pjhLJDm=-WQ0+Fuw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-09-18, 10:46, Andrea Merello wrote:

> Yes, I confirm that here the code does look fine: the 2nd line is
> aligned with opening brace indeed.
> 
> Do you want I produce now a v5 with all the other fixes you asked for
> (basically commit message fixes), or you are going to apply/check this
> one and should I wait for that?

v5 please

-- 
~Vinod
