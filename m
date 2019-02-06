Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36103C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4F220B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfBFLzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:55:21 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:64060 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbfBFLzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:55:20 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id E533513F8B1;
        Wed,  6 Feb 2019 12:54:44 +0100 (CET)
Subject: Re: [PATCH v3 6/8] scsi: ufs: qcom: Expose the reset controller for
 PHY
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Evan Green <evgreen@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190205185902.106085-1-evgreen@chromium.org>
 <20190205185902.106085-7-evgreen@chromium.org>
 <10ea3fe2-e331-0342-cfad-eccce3753d2e@ti.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <8d94b1ae-8084-ed06-19ed-36dd99837703@free.fr>
Date:   Wed, 6 Feb 2019 12:54:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <10ea3fe2-e331-0342-cfad-eccce3753d2e@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2019 12:42, Kishon Vijay Abraham I wrote:

> On 06/02/19 12:29 AM, Evan Green wrote:
> 
>> Expose a reset controller that the phy will later use to control its
>> own PHY reset in the UFS controller. This will enable the combining
>> of PHY init functionality into a single function.
>>
>> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> I'd like to get ACK from scsi/ufs/ MAINTAINER Vinayak for me merge it in PHY tree.

Kishon, I haven't seen any messages from Vinayak in a while.

https://patchwork.kernel.org/patch/10795501/

New reviewers are Alim, Avri, and Pedro (haven't heard from Pedro yet).

Regards.
