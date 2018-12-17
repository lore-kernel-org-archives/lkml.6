Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8ABC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B92A217FB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545027113;
	bh=u4A09XcDOVMZ0y5Pr91zR92XJOw2lvqlgsjkj8vZBoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cE7BUZPT+y5RpOoKeZy7mUzigk2EIgTSXCnHIh0X108reBw1eaPx+bxen6+MKNdJ5
	 z2zRDkgxa4UkD1yT8bxGmhPvhDN/y0kyuh1iZUwO2pg8P2zi03smo6+WMA8S956NH2
	 s+XtrY9V3kkKBRsgoB7zJHsjemgpl4i+I+szMy+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbeLQGLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:11:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbeLQGLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:11:52 -0500
Received: from localhost (unknown [171.61.92.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2769217F4;
        Mon, 17 Dec 2018 06:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545027111;
        bh=u4A09XcDOVMZ0y5Pr91zR92XJOw2lvqlgsjkj8vZBoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfdMjumLt6yCZAdQYNK3X/VCb+6wdKYVDpfa8tFUOSho6GT9g1W13Kr7uUFl9MlYE
         V3c6tMX67N+NgM+MRJfjiGF1sUEt/YQdb9tUj3xAiB+rR0ag7YeUYvObBAhvaXeBtZ
         COTSjgEkij3NrQe/nQJbfPxy0cMNxxjE/cPrBW6k=
Date:   Mon, 17 Dec 2018 11:41:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>, oohall@gmail.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dan Williams <dan.j.williams@intel.com>, jroedel@suse.de,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 6/6] dmaengine: sh: rcar-dmac: Use device_iommu_mapped()
Message-ID: <20181217061142.GD2472@vkoul-mobl>
References: <20181211134343.10664-1-joro@8bytes.org>
 <20181211134343.10664-7-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211134343.10664-7-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-12-18, 14:43, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Use Use device_iommu_mapped() to check if the device is
> already mapped by an IOMMU.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
