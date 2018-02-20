Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeBTWXQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:23:16 -0500
Received: from mga07.intel.com ([134.134.136.100]:47863 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbeBTWXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:23:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="29442912"
Date: Tue, 20 Feb 2018 14:25:12 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Yves-Alexis Perez <corsac@debian.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
Message-ID: <20180220142512.039309aa@jacob-builder>
In-Reply-To: <1518992132.2542.5.camel@debian.org>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
        <20180213140303.42mbzfxpypljy37l@8bytes.org>
        <20180213214002.GA27066@otc-nc-03>
        <1518992132.2542.5.camel@debian.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Feb 2018 23:15:32 +0100
Yves-Alexis Perez <corsac@debian.org> wrote:

> On Tue, 2018-02-13 at 13:40 -0800, Raj, Ashok wrote:
> > This version has only hw dumps for now, but we plan to add some
> > other things like walking 2nd level page-tables, or get some SVM
> > specific data from the driver in the future.   
> 
> Hi,
> 
> I'm not sure how much you know about chipsec [1], but with a oneliner
> [2] you can have it print a lot of data from Vt-d configuration,
> including page tables. As far as I remember, it doesn't need access
> to /dev/mem (but I gidn't dig to check how it does it).
> 
> It might still be useful to have everything from debugfs because
> it'll always be consistent with the current running kernel, but at
> least it might help users reporting bugs.
> 
> [1] https://github.com/chipsec/chipsec
> [2] http://paste.debian.net/1010105

I didn't know about chipsec but reading the code seems to rely on an
out-of-tree kernel module. I don't think it matches what we need here.
