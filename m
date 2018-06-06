Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzCOxL2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6414060263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeFFN0b (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:26:31 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46651 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeFFN03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:26:29 -0400
X-Google-Smtp-Source: ADUXVKKXXUI3qc+FjLAPPeKhvmson84x/VfV/HooUwKORGp8Q2ENBohb0znZlM3aa57W1cTIht4af0qlcSBrksBPFJM=
MIME-Version: 1.0
In-Reply-To: <20180606091138.9522-1-pp@emlix.com>
References: <20180606091138.9522-1-pp@emlix.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 6 Jun 2018 10:26:28 -0300
Message-ID: <CAOMZO5DgCC3t90V1gwiLXqK19orBz2NGyS2Zf2VRh=_0UOQ7og@mail.gmail.com>
Subject: Re: [PATCH] media: ov5640: adjust xclk_max
To: Philipp Puschmann <pp@emlix.com>
Cc: Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 6:11 AM, Philipp Puschmann <pp@emlix.com> wrote:
> According to ov5640 datasheet xvclk is allowed to be between 6 and 54 MHz.
> I run a successful test with 27 MHz.
>
> Signed-off-by: Philipp Puschmann <pp@emlix.com>

Yes, this matches the OV5640 datasheet:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
