Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeDJSfC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:35:02 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36983 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752763AbeDJSe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:34:58 -0400
X-Google-Smtp-Source: AIpwx48hcHxhZ4vDywHKClied32Mh8zAEO36ZpXK01t6FilovO9ZrN+yH+MQtmQ/dard7v4OoiuYSgP+3csgllLTin0=
MIME-Version: 1.0
In-Reply-To: <1518092327-3827-1-git-send-email-andy.yan@rock-chips.com>
References: <1518091958-3672-1-git-send-email-andy.yan@rock-chips.com> <1518092327-3827-1-git-send-email-andy.yan@rock-chips.com>
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date: Tue, 10 Apr 2018 15:34:57 -0300
Message-ID: <CAAEAJfCYm4Z20x8PdU3uHh_0BExTCAoOy5Aq=ZXWLJKaB1C9kQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] mtd: spi-nor: add rockchip serial flash controller driver
To: Andy Yan <andy.yan@rock-chips.com>
Cc: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org,
        shawn.lin@rock-chips.com, Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Just a very minor nit.

On 8 February 2018 at 09:18, Andy Yan <andy.yan@rock-chips.com> wrote:
[..]
> +
> +static int get_if_type(struct rockchip_sfc *sfc, enum spi_nor_protocol proto)
> +{

I understand that this got copy-pasted from some other driver,
but please change this function name to something like
rockchip_sfc_get_if_type().

Thanks,
Eze
