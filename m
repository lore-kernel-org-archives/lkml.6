Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70D4C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D63F20656
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfADJHh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:07:37 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55643 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfADJHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:07:36 -0500
Received: from marcel-macpro.fritz.box (p5B3D2389.dip0.t-ipconnect.de [91.61.35.137])
        by mail.holtmann.org (Postfix) with ESMTPSA id EC8C1CF233;
        Fri,  4 Jan 2019 10:15:17 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [Letux-kernel] [PATCH RFC] bluetooth: add uart h4 devices via
 serdev/devicetree
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190104064403.325771fd@kemnade.info>
Date:   Fri, 4 Jan 2019 10:07:34 +0100
Cc:     Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B5CEA49A-0F54-40C5-BCEA-7875BE1358E3@holtmann.org>
References: <20181110232034.17277-1-andreas@kemnade.info>
 <20181111024648.7rt7rlhaqihtqecv@earth.universe>
 <20181112215812.18ebca35@aktux>
 <2C74C837-A6D3-47C9-BE59-CCA594289B94@goldelico.com>
 <20181112222726.73m2oca7hankvcjs@earth.universe>
 <CABGGisxsdv+BTd5-HMzF8asEcWtL5F4CMzmkrBCwK=NibvqjLQ@mail.gmail.com>
 <20181113170128.0f59ef0e@kemnade.info>
 <86A3A2E6-FC89-42FE-8410-9C8273EC9CF7@holtmann.org>
 <20181116204601.4e1aa0de@kemnade.info>
 <09AFE47C-D188-4397-A2CD-C70FFAC3B677@holtmann.org>
 <20190104064403.325771fd@kemnade.info>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

>>>> Btw. I see nothing standing in the way of merging btuart.c driver and then go from there. Either I dig this out and submit or someone else does.
>>>> 
>>> Do you mean this?
>>> https://patchwork.kernel.org/patch/10490651/  
>> 
>> yes, that one.
>> 
> Hmm, there seemed to be nothing in the pull requests regarding btuart.
> Did you change plans?

because I only submitted it as RFC. We can easily merge that one upstream since it is rather trivial. The main problem is how you want to do the device matching. Do you have a DT entry for your really simple devices?

Regards

Marcel

