Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ADCE4606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeFFMuZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:50:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751907AbeFFMuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:50:24 -0400
Date: Wed, 6 Jun 2018 14:50:22 +0200
From: Jakub Racek <jracek@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: Performance drop on kernel-4.17 visible on Stream, Linpack and
 NAS parallel benchmarks
Message-ID: <20180606125009.GA29162@jra-laptop.brq.redhat.com>
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
 <CAJZ5v0hTTe9zYwYKtoQKjJJbazFeaGVO2SdbaODyvTFiNpGTdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hTTe9zYwYKtoQKjJJbazFeaGVO2SdbaODyvTFiNpGTdw@mail.gmail.com>
X-OS: Linux jra-laptop 3.10.0-862.el7.x86_64 x86_64
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Rafael J. Wysocki [06/06/18 14:34 +0200]:
>On Wed, Jun 6, 2018 at 2:27 PM, Jakub Racek <jracek@redhat.com> wrote:
>> Hi,
>>
>> There is a huge performance regression on the 2 and 4 NUMA node systems on
>> stream benchmark with 4.17 kernel compared to 4.16 kernel. Stream, Linpack
>> and NAS parallel benchmarks show upto 50% performance drop.
>
>OK, and why do you think that it is related to ACPI?

I don't know where the problems is or who to CC. 

What information should be added? I can probably provide it, if I know
what.

>Thanks,
>Rafael
