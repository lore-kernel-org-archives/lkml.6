Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966738AbeE2URq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 16:17:46 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36853 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966179AbeE2URp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 16:17:45 -0400
X-Google-Smtp-Source: ADUXVKIitKuSDHsZtkgZ3HKf7M3RbAtAjqoRXgiewkSrcAtwGj9UbYAhNmr55M4C+wjQmRuDRxfnt35h1PcdKJQffYc=
MIME-Version: 1.0
In-Reply-To: <20180529185425.GA4174@agluck-desk>
References: <cover.1527283897.git.tony.luck@intel.com> <52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com>
 <20180528204923.GB30792@zn.tnic> <20180529161549.GB935@agluck-desk>
 <20180529174105.GF19870@zn.tnic> <3908561D78D1C84285E8C5FCA982C28F7D31E24F@ORSMSX110.amr.corp.intel.com>
 <20180529175313.GG19870@zn.tnic> <20180529185425.GA4174@agluck-desk>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 29 May 2018 13:17:44 -0700
Message-ID: <CAPcyv4gUSswBdmda9_=A_Ls-EPh4kH1LewJHZSWKuM5-sHdyUg@mail.gmail.com>
Subject: Re: [PATCH 2/3 V2] x86/mce: Fix incorrect "Machine check from unknown
 source" message
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 11:54 AM, Luck, Tony <tony.luck@intel.com> wrote:
> On Tue, May 29, 2018 at 07:53:14PM +0200, Borislav Petkov wrote:
[..]
> P.S. What happened to my "part 3/3" (updating the Skylake quirk)
> ... does that belong in somebody else's tree?

I have no qualms taking it through the nvdimm tree with the rest of
the pending memcpy_mcsafe() updates. Just need an x86 maintainer ack.
