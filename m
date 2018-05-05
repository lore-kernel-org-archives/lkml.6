Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeEECvT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 22:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbeEECvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 22:51:17 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <e1d6f7a1-9b2b-113a-4c21-4730c6514e9c@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1525151013-28291-1-git-send-email-tdas@codeaurora.org>
 <152524425583.138124.2497854182982735033@swboyd.mtv.corp.google.com>
 <e1d6f7a1-9b2b-113a-4c21-4730c6514e9c@codeaurora.org>
Message-ID: <152548867593.138124.17769741201119581476@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1] clk: qcom: gdsc: Add support to poll CFG register to check
 GDSC state
Date: Fri, 04 May 2018 19:51:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w452pOWM003016

Quoting Taniya Das (2018-05-03 02:09:57)
> Hello Stephen,
> 
> I have tested the below patch & didn't see any issues.

Alright. Thanks! Can I take that as a "Tested-by"?
