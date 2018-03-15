Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeCOOYk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:24:40 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44489 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbeCOOYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:24:38 -0400
X-Google-Smtp-Source: AG47ELt7iqShTxpr3x76U91aDkpb4LanPd8u+E9T9Yi5ymiNz/7+2LNwCD+Ef0JiBOoW5u/jbTVoElkjAzz8WWdl5ME=
MIME-Version: 1.0
In-Reply-To: <20180315081118.vivohgn6vrt74pyc@linux-x5ow.site>
References: <20180314182508.10351-1-jthumshirn@suse.de> <20180315072257.GA14576@infradead.org>
 <20180315081118.vivohgn6vrt74pyc@linux-x5ow.site>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 15 Mar 2018 07:24:37 -0700
Message-ID: <CAPcyv4jj5HBJOBFNcWMGRg5DufLKJj-=BCVVORWpVno9p270Zg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Introduce module_nd_driver
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NV-DIMM Mailing List <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 1:11 AM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> On Thu, Mar 15, 2018 at 12:22:57AM -0700, Christoph Hellwig wrote:
>> What is the point?  It saves a hand fulk of lines, while making
>> the code both harder to read and harder to extend.
>
> In the end it's just style alignment with most of the other "busses"
> in the kernel, like pci, of, acpi, platform and so on...
>
> But yes I admit it's not a huge win. For the harder to read part, I
> doubt it. A quick:
> git grep -E module_.*._driver drivers/ | wc -l
> has 3896 hit's, so it's not that uncommon ;-)
>
> But anyways, it's just code churn I came up with while being
> frustrated hunting down a bug in this subsystem.
>

Works for me. Removing more lines than you add is always welcome.
