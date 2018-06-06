Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="v5Ohfvyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2A8D6070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754068AbeFFRtk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:49:40 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39239 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbeFFRtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:49:39 -0400
X-Google-Smtp-Source: ADUXVKKDj/m3Nmtftjy5AouQVfFRIIqF234ETJVzJy4RaK7NG+eiIqhugeYReY4OJJE/1fAHVyDgHVnVO8jO/TICt4A=
MIME-Version: 1.0
In-Reply-To: <20180606164515.25677-1-ross.zwisler@linux.intel.com>
References: <20180606164515.25677-1-ross.zwisler@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 6 Jun 2018 10:49:38 -0700
Message-ID: <CAPcyv4i0h2nFnkh7-a3ZLdRz569QUJov3Qkf3nzAmesqzNUSYg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] pmem, libnvdimm: complete REQ_FLUSH => REQ_PREFLUSH
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 9:45 AM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> Complete the move from REQ_FLUSH to REQ_PREFLUSH that apparently started
> way back in v4.8.
>
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>

Yup, long overdue. Applied for 4.18.
