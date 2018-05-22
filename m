Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeEVPez (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:34:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33666 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751868AbeEVPew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:34:52 -0400
Date: Tue, 22 May 2018 17:33:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
Message-ID: <20180522153345.GH5512@pd.tnic>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
 <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
 <20180522135015.GF5512@pd.tnic>
 <0b758a1c-90e3-6f76-4f83-1e22c8fc9cd6@gmail.com>
 <20180522145426.GG5512@pd.tnic>
 <9b3823fc-a660-a619-68b9-43b879f81b05@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b3823fc-a660-a619-68b9-43b879f81b05@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 10:22:19AM -0500, Alex G. wrote:
> I especially don't want a kernel maintainer who hasn't even read the
> recovery handler (let alone the spec around which the handler was
> written) tell me how the recovery handler works and what it's supposed
> to do (see, I can be an ass).

Well, since you're such an ass and since you know better, go find
someone else to review your crap. I'm done wasting time with you.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
