Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755325AbeCHIDY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:03:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:34328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755144AbeCHIDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:03:21 -0500
Date: Thu, 8 Mar 2018 09:03:19 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NV-DIMM Mailing List <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH] acpi, nfit: remove redundant __func__ in dev_dbg
Message-ID: <20180308080319.ndkspvrrxxlfiigu@linux-x5ow.site>
References: <20180302122049.13900-1-jthumshirn@suse.de>
 <20180306040630.GA9905@linux.intel.com>
 <CAPcyv4giwg1mStkA+7hXnABb8fV6VH2qQPstRfYU26-P56X4ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4giwg1mStkA+7hXnABb8fV6VH2qQPstRfYU26-P56X4ug@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 08:52:21AM -0800, Dan Williams wrote:
> > Oh, Johannes I noticed that here is one stray one still in
> > drivers/acpi/nfit/mce.c.  Do you mind pulling it into your patch to keep the
> > drivers/acpi/nfit/* changes together?
> 
> I'll fix this locally.

Sorry for the late response, I was some days off.

Thanks Dan,
       Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
