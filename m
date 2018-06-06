Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQPm8yvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 320F460764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeFFM4U (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:56:20 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:38144 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeFFM4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:56:18 -0400
X-Google-Smtp-Source: ADUXVKJednbIbxGz5nyYHUtCPR3esiTcnTwxpETeiYZGEzqFwbNiqAfgrCGps+Eg08ed3vkWHUabDTNDpOd+fkUmYtY=
MIME-Version: 1.0
In-Reply-To: <20180606125009.GA29162@jra-laptop.brq.redhat.com>
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
 <CAJZ5v0hTTe9zYwYKtoQKjJJbazFeaGVO2SdbaODyvTFiNpGTdw@mail.gmail.com> <20180606125009.GA29162@jra-laptop.brq.redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Jun 2018 14:56:17 +0200
X-Google-Sender-Auth: 4D-O6GVsAwimdQJZkDnTq0a_894
Message-ID: <CAJZ5v0iSfrfbcq3Un888Jmk1xLbSYymOX=eepsGOc7qcVe-P2w@mail.gmail.com>
Subject: Re: Performance drop on kernel-4.17 visible on Stream, Linpack and
 NAS parallel benchmarks
To: Jakub Racek <jracek@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 2:50 PM, Jakub Racek <jracek@redhat.com> wrote:
> +++ Rafael J. Wysocki [06/06/18 14:34 +0200]:
>>
>> On Wed, Jun 6, 2018 at 2:27 PM, Jakub Racek <jracek@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> There is a huge performance regression on the 2 and 4 NUMA node systems
>>> on
>>> stream benchmark with 4.17 kernel compared to 4.16 kernel. Stream,
>>> Linpack
>>> and NAS parallel benchmarks show upto 50% performance drop.
>>
>>
>> OK, and why do you think that it is related to ACPI?
>
>
> I don't know where the problems is or who to CC.
> What information should be added? I can probably provide it, if I know
> what.

The problem appears to be reproducible 100% of the time, so can you
possibly carry out a "git bisect" binary search to find the
problematic commit?

Thanks,
Rafael
