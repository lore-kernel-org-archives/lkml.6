Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeC2TjQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 15:39:16 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:37450 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeC2TjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 15:39:13 -0400
X-Google-Smtp-Source: AIpwx48f+vkSrU790KY9xQ4Z1XMJjZfU2hGL1L2crkhkX5t94Rty/58/4/TZqJBg5+SlsQ4g+jOnvTvpcBcJkE82QIg=
MIME-Version: 1.0
In-Reply-To: <1522321466-21755-5-git-send-email-mgautam@codeaurora.org>
References: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org> <1522321466-21755-5-git-send-email-mgautam@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Mar 2018 12:39:11 -0700
X-Google-Sender-Auth: nzTgNyWe0R66vEr8e3C5DxNDH9A
Message-ID: <CAD=FV=W-OfjagiDxchV-aBNzhfV-2=MN+CJtoLAMe2jGYUc4uA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] dt-bindings: phy-qcom-qmp: Update bindings for sdm845
To: Manu Gautam <mgautam@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, linux-arm-msm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Varadarajan Narayanan <varada@codeaurora.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 29, 2018 at 4:04 AM, Manu Gautam <mgautam@codeaurora.org> wrote:
> Update compatible strings for USB3 PHYs on SDM845.
> One is QMPv3 DisplayPort-USB combo PHY and other one
> is USB UNI PHY which is single lane USB3 PHY without
> DP capability. While at it also remove "qcom,qmp-v3-usb3-phy"
> compatible string which was earlier added for sdm845
> only as there wouldn't be any user of same.
>
> Reviewed-by: Rob Herring <robh@kernel.org>

IMHO you should remove Rob's Review until he re-reviews.  I want to
make sure he's OK with the removal of the "qcom,qmp-v3-usb3-phy".
Rob: that compatible string was _just_ added and was intended for
SDM845.  It's not expected that there are any users yet.  IMHO that
means it's OK to remove, but it would be good to get your confirmation
that you agree.  See the discussion at
<https://patchwork.kernel.org/patch/10302761/>.


> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
