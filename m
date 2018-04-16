Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeDPBgs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 21:36:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52258 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeDPBgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 21:36:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD9C7606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v4 6/7] dt-bindings: phy-qcom-usb2: Add support to
 override tuning values
To: Doug Anderson <dianders@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, linux-arm-msm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
References: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org>
 <1522321466-21755-7-git-send-email-mgautam@codeaurora.org>
 <CAD=FV=VGtmWTaa_aRG6UVAtCzy3cS8sTZDCqAgRMYeg7U02qTw@mail.gmail.com>
 <20180409201824.adsnvqo4vv2waixc@rob-hp-laptop>
 <47a6d655-c4ba-ab5a-ef94-094f25cff74b@codeaurora.org>
 <CAD=FV=Wc+dNZ6wPqwacn-wbp66FhBT5BgbbKGFjO9b+pa5Od6Q@mail.gmail.com>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <0488f08e-20f9-a38d-a8bf-544a09d5c8a3@codeaurora.org>
Date: Mon, 16 Apr 2018 07:06:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Wc+dNZ6wPqwacn-wbp66FhBT5BgbbKGFjO9b+pa5Od6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 4/13/2018 2:17 AM, Doug Anderson wrote:
>> Thanks for review Rob. I too agree with both the viewpoints.
>> Doug, if it is not of much concern then can I stick with current approach?
> I certainly would appreciate the #defines and believe they add to the
> readability, but if you're dead set against it and Rob says it's OK, I
> won't yell too loudly.
>
Agree to the readability part. Will add #defines as you suggested.
-thanks

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
