Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284F6C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 19:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34442133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 19:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfA0TQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 14:16:17 -0500
Received: from route-level1.fsdata.se ([89.221.252.216]:42379 "EHLO
        route-level1.fsdata.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfA0TQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 14:16:17 -0500
Received: from DAG01.HMC.local (192.168.46.11) by EDGE01LEVEL1.hmc.local
 (192.168.46.33) with Microsoft SMTP Server (TLS) id 15.0.847.32; Sun, 27 Jan
 2019 20:15:57 +0100
Received: from localhost (94.234.44.129) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1263.5; Sun, 27 Jan 2019 20:15:58
 +0100
Date:   Sun, 27 Jan 2019 20:15:54 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     Darren Hart <dvhart@infradead.org>
CC:     <andy@infradead.org>, <mario.limonciello@dell.com>,
        <michal.lkml@markovi.net>, <mjg59@srcf.ucam.org>,
        <pali.rohar@gmail.com>, <yamada.masahiro@socionext.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <2pi@mok.nu>
Subject: Re: [PATCH 0/3] platform/x86: wmi: add WMI support to
 MODULE_DEVICE_TABLE()
Message-ID: <20190127191553.mxrqg7zyzwxwrmo5@mok.nu>
References: <cover.1547827336.git.2pi@mok.nu>
 <20190126210634.GB13882@wrath>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190126210634.GB13882@wrath>
X-Originating-IP: [94.234.44.129]
X-ClientProxiedBy: PROXY04.HMC.local (192.168.46.54) To DAG01.HMC.local
 (192.168.46.11)
Received-SPF: Neutral (EDGE01LEVEL1.hmc.local: 192.168.46.11 is neither
 permitted nor denied by domain of 2pi@mok.nu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darren,

On 2019-01-26, Darren Hart wrote:
> On Sat, Jan 19, 2019 at 12:55:52PM +0100, Mattias Jacobsson wrote:
> > This patchset adds WMI support to MODULE_DEVICE_TABLE().
> 
> Hi Mattias,
> 
> Thanks for the patch series. I've reviewed and found no major issues - but what
> I'm missing from this cover letter and each commit message is the why. What is
> the problem this series is intended to address? This should be clear in the
> commit messages so developers reading the git history have the necessary context
> to understand why the change was made and the intent behind them were.

Thanks for reviewing the patchset!

> 
> The only advantage that I see by the end of the series is removing the need for
> driver authors to prefix the modules alias  with "wmi:" - which is an advantage
> and avoids careless errors. Is that the only goal? It adds some complexity by
> spreading the implementation across more files and more directories, so we need
> to document the justification.

Now that you point it out I can definitely see that the reasoning isn't
explicitly stated. Sorry about that!

I've updated the commit messages for [PATCH 2/3] and [PATCH 3/3] in v2
of this patchset to clarify the "why".

> 
> Thanks,
> 
> -- 
> Darren Hart
> VMware Open Source Technology Center

Thanks,
Mattias
