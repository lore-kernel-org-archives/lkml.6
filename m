Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B230C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8C120B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfBFMx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:53:27 -0500
Received: from ns.iliad.fr ([212.27.33.1]:39958 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfBFMx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:53:27 -0500
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2019 07:53:26 EST
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 58D1720DB8;
        Wed,  6 Feb 2019 13:44:52 +0100 (CET)
Received: from [192.168.108.68] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 4049D21A39;
        Wed,  6 Feb 2019 13:44:52 +0100 (CET)
Subject: Re: [PATCH v3 4/5] phy: qcom-qmp: Add QMP UFS PHY support for msm8998
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <8315045c-471a-1ce3-7558-efaaf2cd5406@free.fr>
 <c6046efa-1a74-21d1-e110-0d1aa282d386@codeaurora.org>
 <1d876cdc-c6b5-e490-3e6a-b04c8f9ccc0c@ti.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <5f4f88d2-146b-1a35-ebed-11959c2d7761@free.fr>
Date:   Wed, 6 Feb 2019 13:44:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1d876cdc-c6b5-e490-3e6a-b04c8f9ccc0c@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Feb  6 13:44:52 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2019 13:39, Kishon Vijay Abraham I wrote:

> I don't seem to have the dt-binding patch in my inbox. Can you resend them please?

Jeffrey pointed out a few deficiencies in the series.

I'll CC you on the entire upcoming v4 series.

Regards.
