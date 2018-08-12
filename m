Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFF8C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91680219E4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91680219E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeHLNks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 09:40:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47046 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbeHLNks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 09:40:48 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 546AE25A;
        Sun, 12 Aug 2018 11:03:08 +0000 (UTC)
Date:   Sun, 12 Aug 2018 13:03:05 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     "Harris, James R" <james.r.harris@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Walker, Benjamin" <benjamin.walker@intel.com>,
        "Wodkowski, PawelX" <pawelx.wodkowski@intel.com>
Subject: Re: Problems with uio_pci_generic in v4.18-rc8
Message-ID: <20180812110305.GA18914@kroah.com>
References: <21BF98B1-0EA5-46BC-BC68-196190880087@intel.com>
 <7ac09d84-31bf-4d25-dba7-0a61effa2b04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ac09d84-31bf-4d25-dba7-0a61effa2b04@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 06:55:58PM +0800, Xiubo Li wrote:
> Hi Harris,
> 
> Since the lock protection in uio irq handler is useless currently as
> discussed in the mail list, so I will revert this commit with small changes
> and now the testing based LIO/TCMU has been finished.

Can you send the fixup patch so I can apply it please?

thanks,

greg k-h
