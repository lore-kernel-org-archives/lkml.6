Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755956AbeDCX4Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 19:56:24 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:35689 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755883AbeDCX4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 19:56:22 -0400
X-Google-Smtp-Source: AIpwx4+WwFYotOjlN/NhewMMRwf46al1vyORCJSiQNd+onLLMX+bt16QeXqcHKxxLv9nJdfZSlgL2+HNRxxiCu5jGac=
MIME-Version: 1.0
In-Reply-To: <ed466ff48d5b23a6225ee6c270d70cf3923dfe05.1522186448.git.leonard.crestez@nxp.com>
References: <ed466ff48d5b23a6225ee6c270d70cf3923dfe05.1522186448.git.leonard.crestez@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 3 Apr 2018 20:56:21 -0300
Message-ID: <CAOMZO5Bojjfi-c5cCCNZvPTidicqVASh=kjc8=ARAR1dYVcm7Q@mail.gmail.com>
Subject: Re: [PATCH] drm/imx: Remove last traces of struct imx_drm_crtc
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, David Airlie <airlied@linux.ie>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 6:39 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> When the definition of this struct was removed a forward declaration and an
> unused struct member were still left around. Remove them because they serve
> no purpose.
>
> Fixes 44b460cfe554 ("drm: imx: remove struct imx_drm_crtc and imx_drm_crtc_helper_funcs")
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
