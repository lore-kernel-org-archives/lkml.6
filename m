Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9749C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E502084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E502084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeJEPoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:44:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37151 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeJEPoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:44:14 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g8Lki-00073G-AW; Fri, 05 Oct 2018 10:46:28 +0200
Message-ID: <1538729187.3545.2.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/6] Add support for PDC Global on SDM845 SoCs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Date:   Fri, 05 Oct 2018 10:46:27 +0200
In-Reply-To: <2ae729fe-321b-0918-a06c-d04e43b47101@codeaurora.org>
References: <20180829191215.10071-1-sibis@codeaurora.org>
         <20180903193647.GJ3456@tuxbook-pro>
         <2ae729fe-321b-0918-a06c-d04e43b47101@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi, Bjorn,

On Thu, 2018-10-04 at 23:57 +0530, Sibi Sankar wrote:
> On 09/04/2018 01:06 AM, Bjorn Andersson wrote:
[...]
> > Philipp, there's no compile time dependencies between the PDC and
> > remoteproc patches in this series. Will you take these two through your
> > tree and I'll take the remaining four through the remoteproc tree?
> > 
> > Regards,
> > Bjorn
>
>Hey Phillip,
> 
> Will the PDC driver make the cut for reset/next this time for the
> 4.20rc?

I have applied patches 1 and 2 to reset/next. I'll send a pull request
early next week.

regards
Philipp

