Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756988AbeDZRri (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:47:38 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:37918 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756940AbeDZRrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:47:32 -0400
X-Google-Smtp-Source: AB8JxZriC+Ec54UK9Ip8+4XekpL4BDLwIiWVvyWCVjU4RpwUMFbhgsz4NUQNr2M/QV4ViIFr+KOeRw==
Subject: Re: [RFC PATCH v3 3/3] acpi: apei: Warn when GHES marks correctable
 errors as "fatal"
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-kernel@vger.kernel.org,
        devel@acpica.org
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-4-mr.nuke.me@gmail.com>
 <20180426112057.GB15009@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <e58482cf-37f6-808b-4382-fcf24c6f8db8@gmail.com>
Date: Thu, 26 Apr 2018 12:47:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180426112057.GB15009@pd.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 06:20 AM, Borislav Petkov wrote:
> Pasting the same comment from last time since you missed it:
> 
> "No, I don't want any of that crap issuing stuff in dmesg and then people
> opening bugs and running around and trying to replace hardware.
> 
> We either can handle the error and log a normal record somewhere or we
> cannot and explode. The complaining about the FW doesn't bring shit."

" Borislav, if you don't like the third patch in the series, feel free 
to leave it out. THings will work beautifully with or without it."

:)
