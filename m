Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeEVCeJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 22:34:09 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43315 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbeEVCeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 22:34:06 -0400
X-Google-Smtp-Source: AB8JxZo2UH6vWMW1iGlFXjv3fW/64POcBUeeGSTAKQEbgltvNgsD/h7Kbsnmk08tE817NOcm874xBY/CnHPUBxJM+ls=
MIME-Version: 1.0
In-Reply-To: <AM3PR04MB13154C4D2EF4D42A16BF19E6F5940@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1526951717-12347-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BJy-jEKywyN515+5W-bmA01v7sWsgDj0=5wtBCqsHSYQ@mail.gmail.com> <AM3PR04MB13154C4D2EF4D42A16BF19E6F5940@AM3PR04MB1315.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 21 May 2018 23:34:06 -0300
Message-ID: <CAOMZO5Btvr7R7Ah_=LT6yDxRkJS=bi0bHVFN9ZHi=HiKeQP4sw@mail.gmail.com>
Subject: Re: [PATCH V2] gpio: mxc: add clock operation
To: Anson Huang <anson.huang@nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Mon, May 21, 2018 at 11:29 PM, Anson Huang <anson.huang@nxp.com> wrote:

> Thanks, I will rework it into 2 patches, using SPDX.

I have just sent a series that converts gpio-mxc and gpio-mxs to use
SPDX identifier and put you on Cc.

You can base your change on top of mine.

Thanks
