Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6c3o1gO"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56D95601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932848AbeFFQQs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753480AbeFFQQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:16:45 -0400
X-Google-Smtp-Source: ADUXVKI/8NazthO4qNOPH0zPD1tHselQZj+hoQ62SEmibDtksYLnJYlPgg5Wb/Sbga7G9TqINBcRleszyOZ9DDTDn6k=
MIME-Version: 1.0
In-Reply-To: <1525229431-3087-2-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com> <1525229431-3087-2-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 6 Jun 2018 11:16:03 -0500
X-Gmail-Original-Message-ID: <CANk1AXRAsSE2oMrAiTsmScPUk1vD9L_Yfjy8p4jivSm0VYrbxw@mail.gmail.com>
Message-ID: <CANk1AXRAsSE2oMrAiTsmScPUk1vD9L_Yfjy8p4jivSm0VYrbxw@mail.gmail.com>
Subject: Re: [PATCH v5 01/28] docs: fpga: add a document for FPGA Device
 Feature List (DFL) Framework Overview
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

I've acked the remaining patches with some changes requested.  In your
v6, please add a patch to add yourself to the MAINTAINERS file or
whoever is planning on maintaining fpga/drivers/*dfl*

> Add a document for FPGA Device Feature List (DFL) Framework Overview.
>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan
