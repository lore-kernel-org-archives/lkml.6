Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeCZPfZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:35:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52622 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeCZPfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:35:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C080460131
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Mon, 26 Mar 2018 09:35:20 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: David Collins <collinsd@codeaurora.org>
Cc: Stephen Boyd <sboyd@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180326153520.GC22084@codeaurora.org>
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
 <493c1f5d-df99-ca68-0f90-a7937a696f5d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <493c1f5d-df99-ca68-0f90-a7937a696f5d@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22 2018 at 19:30 -0600, David Collins wrote:
>Hello Stephen,
>
>Thank you for the very detailed review feedback.
>
>On 03/21/2018 12:07 PM, Stephen Boyd wrote:
>> Quoting David Collins (2018-03-16 18:09:10)

>>> +static int rpmh_regulator_remove(struct platform_device *pdev)
>>> +{
>>> +       struct rpmh_pmic *pmic = platform_get_drvdata(pdev);
>>> +
>>> +       rpmh_release(pmic->rpmh_client);
>>
>> I'm still lost on what rpmh_client is giving us besides more code we
>> don't need. I'll ping the rpmh thread again.
>
>Let's see if Lina is willing to add some devm_* calls so that no cleanup
>is required.
>
I will look into this.

-- Lina
