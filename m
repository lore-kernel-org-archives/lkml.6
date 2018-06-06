Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0fbjjZYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B7F160555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeFFP61 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932183AbeFFP6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:58:25 -0400
X-Google-Smtp-Source: ADUXVKLnySaU9HsZyb7jFrq5+7DwD0KskEgCZ+zOmiMvzAiZp55qMuL3Zf0u5PLgRzNafbahpRS0xtEV4sB1lWyO7Pc=
MIME-Version: 1.0
In-Reply-To: <1525229431-3087-25-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com> <1525229431-3087-25-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 6 Jun 2018 10:57:43 -0500
X-Gmail-Original-Message-ID: <CANk1AXSVe7xudu0Tw6jrJZcVZBg98QMJnPBWJ5bqf09p6vwOqw@mail.gmail.com>
Message-ID: <CANk1AXSVe7xudu0Tw6jrJZcVZBg98QMJnPBWJ5bqf09p6vwOqw@mail.gmail.com>
Subject: Re: [PATCH v5 24/28] fpga: dfl: afu: add port ops support
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

> This patch registers the port ops into the global list in the DFL
> framework, and it allows other modules to use the port ops. And
> This patch includes the implementation of the get_id and enable_set
> ops too.
>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>

> ---
>  drivers/fpga/dfl-afu-main.c | 122 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 121 insertions(+), 1 deletion(-)
