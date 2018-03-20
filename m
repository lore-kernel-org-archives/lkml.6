Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeCTDTY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:19:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:19276 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbeCTDTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:19:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,333,1517904000";
   d="scan'208";a="29471790"
Message-ID: <1521515960.2284.1.camel@intel.com>
Subject: Re: [PATCH V4] thermal: Add cooling device's statistics in sysfs
From: Zhang Rui <rui.zhang@intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date: Tue, 20 Mar 2018 11:19:20 +0800
In-Reply-To: <20180320013836.hiu6oy3smwmk35tp@vireshk-mac-ubuntu>
References: <6e557b90950723065d49c9a545146ce31d7dc6e1.1516096153.git.viresh.kumar@linaro.org>
         <1520924571.3766.8.camel@intel.com> <1521014472.2087.32.camel@intel.com>
         <20180314081426.GG15832@vireshk-i7>
         <20180320013836.hiu6oy3smwmk35tp@vireshk-mac-ubuntu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 二, 2018-03-20 at 09:38 +0800, Viresh Kumar wrote:
> On 14-03-18, 13:44, Viresh Kumar wrote:
> > 
> > I got those warnings as well, and I quietly ignored them :)
> > 
> > I ignored the renaming part for the sake of consistency. The other
> > existing
> > routines for similar purpose are named as:
> > 
> > thermal_cooling_device_type_show
> > thermal_cooling_device_max_state_show
> > thermal_cooling_device_cur_state_show
> > thermal_cooling_device_cur_state_store
> > 
> > for me it made more sense to follow that naming convention. And I
> > didn't use the
> > _RO and _WO variants for the same reason.
> > 
> > Now here is what I propose now:
> > 
> > - You apply this patch as-is and ignore the warning.
> > 
> > - I will send few patches on top of that to do:
> >   - renaming of all such routines to shorter versions.
> >   - Use the _RO or _WO variants of the macro everywhere.
> > 
> > What do you say ?
> @Zhang: Can you please share the way you want this to get merged ?
> And if the
> above is fine with you ?
> 
yes, it works for me.
I will apply the patch later today.

thanks,
rui
