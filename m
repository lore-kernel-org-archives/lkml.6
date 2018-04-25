Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755861AbeDYR2H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:28:07 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:34419 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754847AbeDYR2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:28:03 -0400
X-Google-Smtp-Source: AB8JxZoJ23cQgDMIpXGPObLrZzLNmy3y2MqSr4qYfTZ0CDtb01vkcUnOKsMhj4E0cRoXD0i34keq7Q==
Subject: Re: [RFC PATCH v2 3/4] acpi: apei: Do not panic() when correctable
 errors are marked as fatal.
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20180419154006.GE3600@pd.tnic>
 <977608e6-9f5d-c523-a78a-993ac5bfd55f@gmail.com>
 <20180419164528.GD5635@pd.tnic>
 <ffe6b459-c80a-d3c0-451d-0d21ae63da54@gmail.com>
 <20180419190323.GF5635@pd.tnic>
 <dba07329-2f85-2bde-85ea-5bdf26fb8df2@gmail.com>
 <20180422104849.GA32754@pd.tnic>
 <70c43399-e8e5-5061-b5a5-451deb5f02fa@gmail.com>
 <20180425140108.GA2597@pd.tnic>
 <48944beb-4e29-05cc-857b-7698e3dbe89b@gmail.com>
 <20180425171557.GC2597@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <96b6f27f-5e82-53f0-627f-85c2f31a095b@gmail.com>
Date: Wed, 25 Apr 2018 12:27:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180425171557.GC2597@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2018 12:15 PM, Borislav Petkov wrote:
> On Wed, Apr 25, 2018 at 10:00:53AM -0500, Alex G. wrote:
>> Firmware-first.
> 
> Ok, my guess was right.
> 
>> We could probably use more of the native AER print functions, but that's
>> beyond the scope of this patch.
> 
> No no, this does not belong in this patchset.
> 
>> Like the exact thing that this patch series implements? :)
> 
> Exact thing? I don't think so.
> 
> No, your patchset is grafting some funky and questionable side-handler
> which gets to see the PCIe errors first, out-of-line and then it
> practically downgrades their severity outside of the error processing
> flow.

SURPRISE!!! This is a what vs how issue. I am keeping the what, and
working on the how that you suggested.

> What I've been telling you 

It's coming (eventually). I'm trying to avoid pushing more than one
series per week.

(snip useful email context)

Hmmm.

Alex
