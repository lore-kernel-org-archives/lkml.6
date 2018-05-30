Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeE3LGk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:06:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45684 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeE3LGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 494E8602A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
Date: Wed, 30 May 2018 14:06:27 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20180530091535.bzvhg4bvn32mqwgq@vireshk-i7>
References: <1527250067-1256-1-git-send-email-ilialin@codeaurora.org> <CAJZ5v0gwtu-ptPskMeiXqWcRLhaGvvFVRyi-kX=nw_s6if7XGg@mail.gmail.com> <20180530091535.bzvhg4bvn32mqwgq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v14 0/2] Kryo CPU scaling driver
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Ilia Lin <ilialin@codeaurora.org>
Message-ID: <A7737343-1D4B-490C-9E08-DA1DBB25D5B8@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4UB6jHa011119

Just like Viresh said, this is fixed in the v15.

On May 30, 2018 12:15:35 PM GMT+03:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>On 30-05-18, 10:08, Rafael J. Wysocki wrote:
>> On Fri, May 25, 2018 at 2:07 PM, Ilia Lin <ilialin@codeaurora.org>
>wrote:
>> > [v14]
>> >  * Addressed comment from Sudeep about DT compatible
>> >  * Added MAINTAINERS entry
>> 
>> This causes a build issue to occur in my bleeding-edge branch.
>> 
>> Does it depend on anything new in arm-soc?
>
>He already sent a v15 and the changelog suggest he fixed that build
>issue.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
