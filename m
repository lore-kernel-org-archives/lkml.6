Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbeBIAtT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 19:49:19 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:41661 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeBIAtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 19:49:17 -0500
X-Google-Smtp-Source: AH8x227jbcpclDSpu8HPBnxUzzdlzf/Rb/a0l88NPVLjUiGMG6m9Sj7ds57vZunGWHconOe+ZlCn2Qj2hqD7EYmn2Wc=
MIME-Version: 1.0
In-Reply-To: <1515593980-78559-1-git-send-email-weiyongjun1@huawei.com>
References: <1515593980-78559-1-git-send-email-weiyongjun1@huawei.com>
From: Kevin Hilman <khilman@baylibre.com>
Date: Thu, 8 Feb 2018 16:49:15 -0800
Message-ID: <CAOi56cXBqOrABbwwaf-S9_vvYFSRg4855QH4ZvE_ZPZ=nnsphg@mail.gmail.com>
Subject: Re: [PATCH -next] meson-mx-socinfo: Make local function
 meson_mx_socinfo_init() static
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Carlo Caione <carlo@caione.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2018 at 6:19 AM, Wei Yongjun <weiyongjun1@huawei.com> wrote:
> Fixes the following sparse warnings:
>
> drivers/soc/amlogic/meson-mx-socinfo.c:107:12: warning:
>  symbol 'meson_mx_socinfo_init' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied for v4.17,

Kevin
