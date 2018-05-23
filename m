Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934975AbeEWUcg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:32:36 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59194 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934919AbeEWUcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:32:31 -0400
To: dmeyer@gigaio.com, kurt.schwemmer@microsemi.com,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com
Cc: bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, linux-kernel@vger.kernel.org
References: <1527106686-18852-1-git-send-email-dmeyer@gigaio.com>
 <1527106686-18852-3-git-send-email-dmeyer@gigaio.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <fe49ebd5-648b-1719-42ed-3d8b82572f26@deltatee.com>
Date: Wed, 23 May 2018 14:32:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527106686-18852-3-git-send-email-dmeyer@gigaio.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, bhelgaas@google.com, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kurt.schwemmer@microsemi.com, dmeyer@gigaio.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 2/2] NTB: PCI Quirk to Enable Switchtec NT
 Functionality with IOMMU On
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/05/18 02:18 PM, dmeyer@gigaio.com wrote:
> Signed-off-by: Doug Meyer <dmeyer@gigaio.com>

Modulo the device ID issue:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks for your work on this Doug!

Logan
