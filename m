Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeEVLX7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:23:59 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36580 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEVLXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:23:55 -0400
X-Google-Smtp-Source: AB8JxZrlL9ziGt4ZVJuMZ0RSJdjMzO5GxL4ve6ZeW9BbTUsbUdEKQR8g+EYPp7aEUyg8VppE3kmftmWyhiJAfpjF0Rk=
MIME-Version: 1.0
In-Reply-To: <1526958340-25883-1-git-send-email-Anson.Huang@nxp.com>
References: <1526958340-25883-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 22 May 2018 08:23:54 -0300
Message-ID: <CAOMZO5Ccqsg_1rr=VACXL+bfOOB+G+XMPVhGH3G5U8tHoq9sNw@mail.gmail.com>
Subject: Re: [PATCH V3] gpio: mxc: add clock operation
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 12:05 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Some i.MX SoCs have GPIO clock gates in CCM CCGR, such as
> i.MX6SLL, need to enable clocks before accessing GPIO
> registers, add optional clock operation for GPIO driver.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
