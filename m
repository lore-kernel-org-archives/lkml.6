Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753993AbeEALMz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 07:12:55 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:43300 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753851AbeEALMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 07:12:53 -0400
X-Google-Smtp-Source: AB8JxZrX6W9ipQ1HGixL5dbvvSfoief7e69BqQzdYAmIfBBYoMLlqPG3NpMKK68do75HwDhipjYdFg==
Date: Tue, 1 May 2018 13:12:49 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] thermal: exynos: remove trip reporting to
 user-space
Message-ID: <20180501111249.GO27619@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115244epcas2p36d0d44d1a0b2c3c4edff33187046caac@epcas2p3.samsung.com>
 <1524743493-28113-19-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524743493-28113-19-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:33PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Remove trip reporting to user-space - I'm not aware of any user-space
> program which relies on it and there is a thermal user-space governor
> which does it in proper way nowadays.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
