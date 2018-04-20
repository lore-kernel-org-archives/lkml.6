Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755493AbeDTOz0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:55:26 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:42188 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755471AbeDTOzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:55:23 -0400
X-Google-Smtp-Source: AIpwx4+/OpiC8c82qB7RQVbawcg3j/quvHujUaI8IBY5BBOoMaXX+BRNRF1x3Z7DQB0oO+gEOZKoAg==
Date: Fri, 20 Apr 2018 08:55:21 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
Message-ID: <20180420145521.GB30433@ziepe.ca>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
 <20180419202632.GE14063@ziepe.ca>
 <20180419214722.GO28657@bhelgaas-glaptop.roam.corp.google.com>
 <BN6PR12MB1809BD30AA5B890C054F9832F7B50@BN6PR12MB1809.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR12MB1809BD30AA5B890C054F9832F7B50@BN6PR12MB1809.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 10:11:27PM +0000, Deucher, Alexander wrote:

> My understanding was that some platfoms only bring up the link in
> gen 1 mode for compatibility reasons.  TBH, I'm not that familiar
> with how the links come up on different platforms.

Then the platform firmware or platform's linux PCI root complex driver
should perform speed negotiation.

Something like that shouldn't be a driver problem to solve.

The driver should only be involved if it has to alter the device (eg
new device firmware or something)..

Jason
