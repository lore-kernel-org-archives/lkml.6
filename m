Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D884EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9515B214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9515B214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeIRUnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:43:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbeIRUnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:43:19 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5F5C9E3D;
        Tue, 18 Sep 2018 15:10:18 +0000 (UTC)
Date:   Tue, 18 Sep 2018 17:10:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     martin.petersen@oracle.com, Don.Brace@microchip.com,
        don.brace@microsemi.com, jejb@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: Use vmemdup_user to replace the open code
Message-ID: <20180918151015.GA27663@kroah.com>
References: <1534164200-28408-1-git-send-email-zhongjiang@huawei.com>
 <BYAPR11MB28555A88771594AA31AC7596E1390@BYAPR11MB2855.namprd11.prod.outlook.com>
 <5B7E9CCE.5010007@huawei.com>
 <5BA11315.4060908@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BA11315.4060908@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 11:00:37PM +0800, zhong jiang wrote:
> Hi,  Greg
> 
> Can you pick up the patch?

Nope, sorry, as before, work with the maintainers please.

greg k-h
