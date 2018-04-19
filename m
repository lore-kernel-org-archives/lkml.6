Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754168AbeDSQlD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:41:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38930 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753790AbeDSQlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:41:01 -0400
Date: Thu, 19 Apr 2018 18:40:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
Subject: Re: [RFC PATCH v2 2/4] acpi: apei: Split GHES handlers outside of
 ghes_do_proc
Message-ID: <20180419164043.GC5635@pd.tnic>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-3-mr.nuke.me@gmail.com>
 <20180418175201.GI4795@pd.tnic>
 <5f26275c-5896-c552-69c4-78e5aaaa6558@gmail.com>
 <20180419143018.GC3600@pd.tnic>
 <8f467611-16a1-8fe7-ea12-e2e29023e4e8@gmail.com>
 <20180419152933.GD3600@pd.tnic>
 <b9887ae1-8d7e-cfff-3933-d9358283a3c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9887ae1-8d7e-cfff-3933-d9358283a3c4@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 10:46:15AM -0500, Alex G. wrote:
> The bulk of the function is the if/else mapping from UUID to error
> handler. I don't see how that can be easily split up, hence why I
> originally resorted to the mapping. As you said, we'll keep it simple at
> first.

So that function is 43 lines now. Why are we even talking about this?!

Just add your UUID check to the if-else statement and be done with it
already. No handlers no nothing.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
