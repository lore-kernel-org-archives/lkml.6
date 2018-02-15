Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755359AbeBOJxn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:53:43 -0500
Received: from 8bytes.org ([81.169.241.247]:44244 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755186AbeBOJxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:53:40 -0500
Date: Thu, 15 Feb 2018 10:53:38 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
Message-ID: <20180215095337.fccoozdclfnbepi4@8bytes.org>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
 <20180213140303.42mbzfxpypljy37l@8bytes.org>
 <20180213214002.GA27066@otc-nc-03>
 <20180213145332.35c73eda@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213145332.35c73eda@jacob-builder>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 02:53:32PM -0800, Jacob Pan wrote:
> We did start out with /dev/mem but run into CONFIG_STRICT_DEVMEM
> requirement which is turned on by default.
> libpci is only limited to PCI config space access, right?

Even if /dev/mem is not an option, I am still not convinced that this is
a good idea. How should this be used? Will you just use it to debug
Intel IOMMUs when you guys work on the driver or should users report the
data back when they hit problems?



	Joerg
