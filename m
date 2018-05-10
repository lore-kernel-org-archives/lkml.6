Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966322AbeEJPku (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:40:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59662 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966135AbeEJPks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:40:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3E46601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Thu, 10 May 2018 09:40:47 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v8 0/2] drivers/qcom: add Command DB support
Message-ID: <20180510154047.GJ4698@codeaurora.org>
References: <20180410175724.7165-1-ilina@codeaurora.org>
 <20180509164215.GF4698@codeaurora.org>
 <CAD=FV=UR03-_7bZP0_K6Gut1LMYHzopHnHbM9T3XKJw8BF1Hiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD=FV=UR03-_7bZP0_K6Gut1LMYHzopHnHbM9T3XKJw8BF1Hiw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09 2018 at 15:30 -0600, Doug Anderson wrote:
>Lina
>
>On Wed, May 9, 2018 at 9:42 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>> Hi Andy, David,
>>
>> These patches have been reviewed by our peers and have recieved no
>> further comments in the past few weeks. Would you consider merging this
>> in your trees?
>
>When I look at:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=for-next
>
>I see both of your patches (plus Stephen Boyd's patch about making
>things endian-agnostic).  ...so I think we're good.  :-)
>
Excellent. Thank you.

-- Lina
