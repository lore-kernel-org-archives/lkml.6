Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeCPFei (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 01:34:38 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:37674 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeCPFeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 01:34:37 -0400
X-Google-Smtp-Source: AG47ELs1I5u9mD2cXHiZpo/cwFzkR3kSDCdAUUHfluFpNF+zMwlHnW+w513ZoDciaz3ZN/dM8Y2/ag==
Date: Fri, 16 Mar 2018 11:04:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@gmail.com,
        s.hauer@pengutronix.de, l.stach@pengutronix.de, shawnguo@kernel.org,
        fabio.estevam@nxp.com, nm@ti.com, xuwei5@hisilicon.com,
        robh+dt@kernel.org, olof@lixom.net
Subject: Re: [PATCH V7 00/13] drivers: Boot Constraint core
Message-ID: <20180316053434.GW15832@vireshk-i7>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-18, 15:53, Viresh Kumar wrote:
> Hi Greg,
> 
> The V7 version incorporates the organizational changes suggested by Olof
> earlier. Everything else is same otherwise.
> 
> I have tested the Hisilicon patches (again) on hikey 9660 board, IMX stuff was
> earlier tested by Sascha (Pengutronix) on i.MX6 and Qualcomm stuff was earlier
> tested by Rajendra (Qualcomm) on Dragonboard 410C (This required some more
> patches related to display driver which Rajendra should be sending separately
> later on).

Hi Greg,

Are you going to pick this one for 4.17 ?

Thanks.

-- 
viresh
