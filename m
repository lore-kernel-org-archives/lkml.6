Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9DDC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22012240FE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22012240FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeGEQ5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:57:02 -0400
Received: from ale.deltatee.com ([207.54.116.67]:49672 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753566AbeGEQ46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:56:58 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fb7Yl-0007me-Cl; Thu, 05 Jul 2018 10:56:48 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>, dmeyer@gigaio.com
Cc:     kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com, bhelgaas@google.com, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com,
        linux-kernel@vger.kernel.org
References: <1527106686-18852-1-git-send-email-dmeyer@gigaio.com>
 <20180630015002.GL40928@bhelgaas-glaptop.roam.corp.google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2e882f94-3ac6-3e27-b670-4996b350cae5@deltatee.com>
Date:   Thu, 5 Jul 2018 10:56:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180630015002.GL40928@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, bhelgaas@google.com, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kurt.schwemmer@microsemi.com, dmeyer@gigaio.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 0/2] PCI Quirk Patchset for Microsemi Switchtec NTB
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for cleaning this up Bjorn.

On 29/06/18 07:50 PM, Bjorn Helgaas wrote:
> Please review and holler if I broke something.

I pulled your branch, reviewed it and lightly tested it. Everything
looks good to me.

> This touches drivers/ntb/hw/..., which isn't my area.  Let me know if you'd
> rather take these through a different tree.

The NTB change is very minor, and there's nothing this will conflict
with so I think it's fine to go through the PCI tree.

Logan
