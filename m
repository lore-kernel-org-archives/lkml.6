Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965329AbeEIVar (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 17:30:47 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39557 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964968AbeEIVap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 17:30:45 -0400
X-Google-Smtp-Source: AB8JxZpSwAOprYoNGiZ3/Yr2bJlJvEhaPKy03csZkCYWqKVUX1idW2FXq8UaAxyvndqYnBxLlbQ05Um8bH/tivZOPpw=
MIME-Version: 1.0
In-Reply-To: <20180509164215.GF4698@codeaurora.org>
References: <20180410175724.7165-1-ilina@codeaurora.org> <20180509164215.GF4698@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 9 May 2018 14:30:43 -0700
X-Google-Sender-Auth: guTsJ1cbZXAwAOdX3lBE6QtOFx4
Message-ID: <CAD=FV=UR03-_7bZP0_K6Gut1LMYHzopHnHbM9T3XKJw8BF1Hiw@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] drivers/qcom: add Command DB support
To: Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lina

On Wed, May 9, 2018 at 9:42 AM, Lina Iyer <ilina@codeaurora.org> wrote:
> Hi Andy, David,
>
> These patches have been reviewed by our peers and have recieved no
> further comments in the past few weeks. Would you consider merging this
> in your trees?

When I look at:

https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=for-next

I see both of your patches (plus Stephen Boyd's patch about making
things endian-agnostic).  ...so I think we're good.  :-)

-Doug
