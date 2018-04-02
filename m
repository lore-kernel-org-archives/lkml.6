Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeDBMcU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 08:32:20 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35458 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbeDBMcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 08:32:15 -0400
X-Google-Smtp-Source: AIpwx4+uVFQLgLt9oxqsH6DNEfLJHLlELy4CCkjQB9oxhxEy36RKzcNDT//TVVW5UwUsx2oaUpVz0mh+VMmiSUMKue0=
MIME-Version: 1.0
In-Reply-To: <1522176722-12691-2-git-send-email-rishabhb@codeaurora.org>
References: <1522176722-12691-1-git-send-email-rishabhb@codeaurora.org> <1522176722-12691-2-git-send-email-rishabhb@codeaurora.org>
From: Rob Herring <rob.herring@linaro.org>
Date: Mon, 2 Apr 2018 07:31:53 -0500
Message-ID: <CABGGisy5+50re_D-8FaEuVgTRN3E17_iCVMgDjarhW2ay=r1oQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Documentation: Documentation for qcom, llcc
To: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org, linux-arm@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, kyan@codeaurora.org, ckadabi@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 1:52 PM, Rishabh Bhatnagar
<rishabhb@codeaurora.org> wrote:
> Documentation for last level cache controller device tree bindings,
> client bindings usage examples.
>
> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 70 ++++++++++++++++++++++

Bindings need to go to DT list for review.

Rob
