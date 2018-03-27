Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754300AbeC0RfS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:35:18 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:44210 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeC0RfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:35:14 -0400
X-Google-Smtp-Source: AIpwx4/IlhCaBGEB6iS1qLWQuhW98ULe7HHXe9Mi6zn3fGG+oYrVWTYotiFJpkQy3tXQ7fwX+smLuw==
MIME-Version: 1.0
References: <1521785487-29866-1-git-send-email-mgautam@codeaurora.org> <1521785487-29866-7-git-send-email-mgautam@codeaurora.org>
In-Reply-To: <1521785487-29866-7-git-send-email-mgautam@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 27 Mar 2018 17:34:36 +0000
X-Gmail-Original-Message-ID: <CAE=gft72pBOvN+pHYL1LHzLbj-EifZo0+yiFc=kABHj=iOM+2A@mail.gmail.com>
Message-ID: <CAE=gft72pBOvN+pHYL1LHzLbj-EifZo0+yiFc=kABHj=iOM+2A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] phy: qcom-qusb2: Add QUSB2 PHYs support for sdm845
To: Manu Gautam <mgautam@codeaurora.org>
Cc: kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, vivek.gautam@codeaurora.org,
        sboyd@codeaurora.org, krzk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 11:12 PM Manu Gautam <mgautam@codeaurora.org> wrote:

> There are two QUSB2 PHYs present on sdm845. Update PHY
> registers programming for both the PHYs related to
> electrical parameters to improve eye diagram.

> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qusb2.c | 39
+++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)


Reviewed-by: Evan Green <evgreen@chromium.org>
