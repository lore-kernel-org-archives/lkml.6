Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeEBN6p (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:58:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:50032 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751185AbeEBN6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:58:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,354,1520924400";
   d="scan'208";a="47712852"
Date: Wed, 2 May 2018 16:58:39 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] hwtracing: intel_th: Change return type to vm_fault_t
Message-ID: <20180502135839.5ujlwpirizy2zyod@um.fi.intel.com>
References: <20180417141547.GA30799@jordon-HP-15-Notebook-PC>
 <CAFqt6zYFxJPMbcyLbJp6qrRDmcy4A+KAk9NhEvy-kVMBL2dySg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zYFxJPMbcyLbJp6qrRDmcy4A+KAk9NhEvy-kVMBL2dySg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 11:14:48AM +0530, Souptick Joarder wrote:
> Any comment for this patch ?

Looks good, I'm queuing this one for the next merge window.

Thanks you!
