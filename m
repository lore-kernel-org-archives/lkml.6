Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeCTBin (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 21:38:43 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37313 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeCTBik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 21:38:40 -0400
X-Google-Smtp-Source: AG47ELvkY/1d6+U0GWP7TLNp1jkYXf1QjB/QL96MXEe9hdOtaGZc9/qCeg5bgoU7fFgt8VgFZqewjA==
Date: Tue, 20 Mar 2018 09:38:36 +0800
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V4] thermal: Add cooling device's statistics in sysfs
Message-ID: <20180320013836.hiu6oy3smwmk35tp@vireshk-mac-ubuntu>
References: <6e557b90950723065d49c9a545146ce31d7dc6e1.1516096153.git.viresh.kumar@linaro.org>
 <1520924571.3766.8.camel@intel.com>
 <1521014472.2087.32.camel@intel.com>
 <20180314081426.GG15832@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314081426.GG15832@vireshk-i7>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-03-18, 13:44, Viresh Kumar wrote:
> I got those warnings as well, and I quietly ignored them :)
> 
> I ignored the renaming part for the sake of consistency. The other existing
> routines for similar purpose are named as:
> 
> thermal_cooling_device_type_show
> thermal_cooling_device_max_state_show
> thermal_cooling_device_cur_state_show
> thermal_cooling_device_cur_state_store
> 
> for me it made more sense to follow that naming convention. And I didn't use the
> _RO and _WO variants for the same reason.
> 
> Now here is what I propose now:
> 
> - You apply this patch as-is and ignore the warning.
> 
> - I will send few patches on top of that to do:
>   - renaming of all such routines to shorter versions.
>   - Use the _RO or _WO variants of the macro everywhere.
> 
> What do you say ?

@Zhang: Can you please share the way you want this to get merged ? And if the
above is fine with you ?

-- 
viresh
