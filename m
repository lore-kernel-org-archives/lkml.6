Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964845AbeEYNbI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:31:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52764 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933214AbeEYNbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:31:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B44C660290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V2] PCI/portdrv: do not disable device on reboot/shutdown
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, ryan@finnie.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Don Brace <don.brace@microsemi.com>, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
References: <1527043490-17268-1-git-send-email-okaya@codeaurora.org>
 <20180523213249.GD150632@bhelgaas-glaptop.roam.corp.google.com>
 <61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org>
 <20180524183502.GB85822@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <984b9734-244d-04e9-946f-7524f148ff7c@codeaurora.org>
Date: Fri, 25 May 2018 09:30:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180524183502.GB85822@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/2018 2:35 PM, Bjorn Helgaas wrote:
> That sounds like a reasonable idea, and it is definitely another can
> of worms.  I looked briefly at some of the .shutdown() cases:

should we throw it into 4.18 and see what happens?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
