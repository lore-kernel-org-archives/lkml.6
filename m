Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbeBPT20 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:28:26 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39447 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeBPT2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:28:20 -0500
X-Google-Smtp-Source: AH8x227+a+m3Bb0ONZrbIzcM4iv8xyR0//X9KNh1k5xOSF3bpMTeJXPQHKXlod6bU9BoJaLVaqoFyqGjzmfhpn5qBrQ=
MIME-Version: 1.0
In-Reply-To: <20180216060503.22006-5-rnayak@codeaurora.org>
References: <20180216060503.22006-1-rnayak@codeaurora.org> <20180216060503.22006-5-rnayak@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 16 Feb 2018 11:28:18 -0800
X-Google-Sender-Auth: sPTjO9hHcilDlg74W6qxfn4yFto
Message-ID: <CAD=FV=WiW9yn5o_GXot9Pu=EQpnfDTS9sBDxnE__BrwwtOZtpA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64: dts: sdm845: Add serial console support
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>, evgreen@chromium.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 15, 2018 at 10:05 PM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> Add the qup uart node and geni se instance needed to
> support the serial console on the MTP.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 39 +++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 39 +++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)

Looks nice to me.  Thanks!

As in your cover letter, this patch will almost certainly need to be
spun again because it's based on bindings that have review feedback.
For those of you playing along at home, see
<https://patchwork.kernel.org/patch/10162063/>.  Thus, I'm not
providing a Reviewed-by tag at the moemnt.

I will still say thanks for posting this (even though it was based on
old bindings) since it allowed us to make some good progress ahead of
time so we'll be very close to landing when the serial patch is spun
next.


In my ideal world the first 3 patches of this series would land sooner
rather than later and then this 4th patch would simply be re-posted on
its own when the bindings get more finalized (or, even better, if the
first 3 patches have landed then Karthikeyan could just glom this on
to the end of his next spin of the serial driver.  ;-)


-Doug
