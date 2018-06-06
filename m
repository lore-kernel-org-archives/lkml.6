Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlPxAWE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B495260764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeFFNHV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:07:21 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34866 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeFFNHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:07:19 -0400
X-Google-Smtp-Source: ADUXVKJPHl/phTyjq1ICrIVxDx13eJO+FQ3i5wRabACe6YKUZ0MvnJKBfYgJBqVrBlnMYbQk9RRHH3UYQezCBULtCmI=
MIME-Version: 1.0
In-Reply-To: <20180606092928.11724-1-pp@emlix.com>
References: <20180606092928.11724-1-pp@emlix.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 6 Jun 2018 10:07:18 -0300
Message-ID: <CAOMZO5B-T2UWdv-tf5vsCuRQ6f_o1gw1pAn-b6h9zfmi5ng4Ug@mail.gmail.com>
Subject: Re: [PATCH] clk: imx6: fix video_27m parent for IMX6SX_CLK_CKO1_SEL
To: Philipp Puschmann <pp@emlix.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 6:29 AM, Philipp Puschmann <pp@emlix.com> wrote:
> q/dl datasheets list the 5th selection value for ck01_sel as
> video_27M_clk_root.
>
> By replacing the dummy value we then can set IMX6QDL_CLK_VIDEO_27M
> as parent for IMX6QDL_CLK_CKO1_SEL.
>
> Signed-off-by: Philipp Puschmann <pp@emlix.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
