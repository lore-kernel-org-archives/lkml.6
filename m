Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeCEVLT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 16:11:19 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33728 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753047AbeCEVLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 16:11:16 -0500
X-Google-Smtp-Source: AG47ELuyQfP7UPmyqWTXxkzptxA6m1zDbWh8PfS3SYf1fc+j8YK0ixZkKlzSNdwFDMjLLn7cd7pioQ==
Subject: Re: [PATCH] thermal: of: Allow selection of thermal governor in DT
To: Amit Kucheria <amit.kucheria@linaro.org>, devicetree@vger.kernel.org
Cc: Ram Chandrasekar <rkumbako@codeaurora.org>, ilina@codeaurora.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1520274879.git.amit.kucheria@linaro.org>
 <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e6c78c81-f18d-c811-925d-5b1dd427fb65@linaro.org>
Date: Mon, 5 Mar 2018 22:11:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 19:36, Amit Kucheria wrote:
> From: Ram Chandrasekar <rkumbako@codeaurora.org>
> 
> There is currently no way for the governor to be selected for each thermal
> zone in devicetree. This results in the default governor being used for all
> thermal zones even though no such restriction exists in the core code.
> 
> Add support for specifying the thermal governor to be used for a thermal
> zone in the devicetree. The devicetree config should specify the governor
> name as a string that matches any available governors. If not specified, we
> maintain the current behaviour of using the default governor.
> 
> Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Why not create a kernel parameter (eg. thermal.governor=) ? So everyone
can gain benefit of this feature. And in order to specify that from the
DT, add the 'chosen' node and bootargs with the desired kernel parameter?




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
