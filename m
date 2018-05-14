Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752354AbeENIfD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:35:03 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45859 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeENIfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:35:01 -0400
X-Google-Smtp-Source: AB8JxZpwSKPt8DJlHiMkGyupOEWPyT4npjgdJXiBWvuSiZN2thkxjK/Om6OycKlL0W48Bw1BXWopZA==
Date: Mon, 14 May 2018 10:34:55 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
Message-ID: <20180514083455.GE29062@mai>
References: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 04:09:17PM +0800, Anson Huang wrote:
> This patch removes cpufreq cooling registration in
> thermal .probe function, cpufreq cooling should be
> done in cpufreq driver when it is ready.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
