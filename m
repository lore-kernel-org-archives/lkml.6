Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BC9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CFB2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547103843;
	bh=zJA2QWmPWQzBtdWt4XO4f9HuTEqs9pPqgsZnQhYFRSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FszLeKOCckDbpPK7bseTXI2iRDOcWuROJmbkoIxyh+XPIvbNW/+y3+IwyVFjjxfn8
	 BuVHjK8CwdMA86m6IZQe8J1zGCP0+Yqm2lDAiLu3UxQKs3wclfPw1pVnYbnHQglB9C
	 uRirwfPfuEkWqaXA+ZbjKKieUWWbR3nP3S/vvQfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfAJHED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:04:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfAJHEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:04:01 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A975320657;
        Thu, 10 Jan 2019 07:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547103841;
        bh=zJA2QWmPWQzBtdWt4XO4f9HuTEqs9pPqgsZnQhYFRSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H7QbmsPceOK6nrXYKIeoJYZ/i4f5RjhMnLcODT2xH0MVTEvfep7CK5yiSnbm7VM9Y
         lRsJ52SJOGSeiHWFEPe+0k8oH06vh7Csr3mrx5Cdjq2KZmtl76VoJ8BIBlDnrWB5Da
         clYiA/EqF/NISjTk99zRDV5es9xFFf5+lvL5gAfE=
Date:   Thu, 10 Jan 2019 15:03:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, arnout.vandecappelle@essensium.com,
        matthew.weber@rockwellcollins.com
Subject: Re: [PATCH] ARM: dts: ls1021a: Add memory controller
Message-ID: <20190110070348.GD25218@dragon>
References: <20181211154834.4489-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211154834.4489-1-patrick.havelange@essensium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 04:48:34PM +0100, Patrick Havelange wrote:
> The LS1021A has a memory controller that supports EDAC. This commit
> adds an entry for it.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>

Applied, thanks.
