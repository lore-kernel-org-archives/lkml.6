Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932076AbeE3P2v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:28:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52440 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753293AbeE3P2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:28:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9A5660452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] PCI: Add pci=safemode option
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ingo Molnar <mingo@kernel.org>, Christoffer Dall <cdall@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, timur@codeaurora.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Oza Pawandeep <poza@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
 <20180530043103.GA19734@kroah.com>
 <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
 <20180530073735.GA28793@infradead.org>
 <6dfe2db8f974d94c9867f30ec83d9333@codeaurora.org>
 <20180530145650.GA39853@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2a5281cd-a0c7-1449-5b72-133660667fa6@codeaurora.org>
Date: Wed, 30 May 2018 11:28:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530145650.GA39853@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2018 10:56 AM, Bjorn Helgaas wrote:
> This *was* my idea, but I'm starting to think it was a bad idea.
> 
> I don't want people to use pci= parameters as the normal way to get a
> system to boot.  That would be a huge support hassle (putting things
> in release notes, diagnosing problems when people forget it, etc).
> 
> But the parameters *are* useful for debugging.  If we had a
> "pci=safemode" and it avoided some problem, the next step would be to
> narrow it down by using the more specific flags (pci=nomsi, pci=noari,
> pci=no_ext_tags, etc).  So I think 95% of the value is in the specific
> flags, and a "pci=safemode" might add a little bit of value but at the
> cost of a small but nagging maintenance concern and code clutter.

OK. Let's try noXYZ feature. Can you enumerate the XYZ features that you
want to see?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
