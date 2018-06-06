Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMm29k0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43F8C60263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932692AbeFFIgF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:36:05 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:40273 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932394AbeFFIgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:36:03 -0400
X-Google-Smtp-Source: ADUXVKKVvtpEtXPn3kmshFA44gniobV9zXhyFzTOwIhcBbJ2s9ZPJybMgrDsJq+7yCGkYh0wnuOrLnEY7LTJAhsfjTA=
MIME-Version: 1.0
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 6 Jun 2018 16:36:02 +0800
Message-ID: <CAFgQCTudugoNc26P22V+G_awzj2srKHhWBJubFoa7-K=cDtQyw@mail.gmail.com>
Subject: question about the limited interrupt vector resource on a single cpu
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86, there is around 200 vectors left for external device on a
single logic cpu.
Is there any case that we exhaust them in real world, and is it worth to fix?

Thanks,
Pingfan
