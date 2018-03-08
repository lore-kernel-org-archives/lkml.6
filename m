Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966379AbeCHFm1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 00:42:27 -0500
Received: from mail-pl0-f51.google.com ([209.85.160.51]:35521 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966261AbeCHFmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 00:42:23 -0500
X-Google-Smtp-Source: AG47ELuzvaTLIr2uVCpr4Kq5wI7k7sHGio5XYh2k4kthgto/fTYoCxD+0gQeSM5FvSXSxFtYbmt/Pw==
Date: Thu, 8 Mar 2018 11:12:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: of: Allow selection of thermal governor in DT
Message-ID: <20180308054221.GJ6842@vireshk-i7>
References: <cover.1520274879.git.amit.kucheria@linaro.org>
 <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
 <6d5aeab8-aafe-fa3b-585e-953a34864e7d@arm.com>
 <CAP245DVwaY84+fZrbne1RLK9gKsfSTE2TELDAC0RkZGMzFkpWg@mail.gmail.com>
 <CAOh2x=njFxcwDfQs1g3-Estrun5j=fSYVnG-EaVw0UcRaDKsSg@mail.gmail.com>
 <CAP245DWAnYqbKJ_+NMqYvP9suwgmmkZ6twSBfAD64FxqztgnuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP245DWAnYqbKJ_+NMqYvP9suwgmmkZ6twSBfAD64FxqztgnuA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-03-18, 11:05, Amit Kucheria wrote:
> Interestingly enough, there are some patches that make the thermal
> framework start earlier to deal with boot-time thermal issues. I
> expect to post them soon. :-) These are required, for example, if the
> device goes into a reboot loop - the device might not even make it to
> the point in userspace where the governors are setup. In such a loop,
> the temperature constantly keeps increasing.
> 
> I was refering to the 'make defconfig' out-of-box experience that
> makes the majority of developer boards/devices out there stable to
> work on. I can't do that today.

Fair enough, but I am still not sure if we should put something that defines our
thermal policy into DT which should describe hardware.

-- 
viresh
