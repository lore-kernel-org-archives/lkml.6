Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B134C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B905E21917
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="rGDXC40u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B905E21917
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932873AbeGFMdQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:33:16 -0400
Received: from 8bytes.org ([81.169.241.247]:53756 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932573AbeGFMcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:32:01 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 81DF41F0; Fri,  6 Jul 2018 14:32:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530880320; bh=OTuOSnsJf7YIfXz2HfuBx3mSwoEwUC2lbbj29pbluYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGDXC40uba38iZJDTEWnO4ym+po5zGMZ17+jjlgFgc2V816r56FAvtHdMrJ8IniuY
         NkD9q1qqOXxi9gvRdAaFiAwQyK8pDET+X5tOJhil7491dBudUhebeAmg0KL373tjpp
         QzgoT+DItLtcdE1zheT2HGitXM8upHj5LrxmkB+4UkLHo3WkidfxRXYNe37pZC9344
         SrXg0kWN2mG1XhpHvWajZ47GZYaG/kGRiRSAYl79l6wjkGu1Z2BGCaxGx7zy2SRG8A
         VukHld2+eOZAENJKhOVDfpCltt3nl1A62MD6a7e5Cs3GZAt0wWlrkCLy779WA2WUHU
         8AVXEjnNPeJjQ==
Date:   Fri, 6 Jul 2018 14:31:55 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] iommu/vt-d: Improve PASID id and table management
Message-ID: <20180706123155.oyubygktu3q3banv@8bytes.org>
References: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lu,

the patches do not apply cleanly to my x86/vt-d branch. Can you rebase
against that branch after the weekend when I pushed it out and re-send,
please?

Thanks a lot,

       Joerg


