Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeDMVrS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 17:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbeDMVrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 17:47:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77F720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=vishal@kernel.org
Message-ID: <1523656035.21394.1.camel@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Adding backup maintainers for libnvdimm
 and DAX
From: Vishal Verma <vishal@kernel.org>
To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Date: Fri, 13 Apr 2018 15:47:15 -0600
In-Reply-To: <20180413210337.GA13316@linux.intel.com>
References: <152365245998.33329.8224892765972973116.stgit@djiang5-desk3.ch.intel.com>
         <20180413210337.GA13316@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-13 at 15:03 -0600, Ross Zwisler wrote:
> On Fri, Apr 13, 2018 at 01:47:40PM -0700, Dave Jiang wrote:
> > Adding additional maintainers to libnvdimm related code and DAX.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> This is fine with me:
> 
> Acked-by: Ross Zwisler <ross.zwisler@linux.intel.com>

Fine by me as well

Acked-by: Vishal Verma <vishal.l.verma@intel.com>

> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
