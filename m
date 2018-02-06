Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeBFWjf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:39:35 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:36014 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753428AbeBFWjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:39:33 -0500
Subject: Re: [PATCH v2] arc: dts: use 'atmel' as manufacturer for at24 in
 axs10x_mb
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
References: <20180206110810.9093-1-brgl@bgdev.pl>
 <1517919923.6726.13.camel@synopsys.com>
 <CAMRc=MfgLA2KDMFLM_GrbSb6MfQeAdHfVJXbnx-ss+S4xm72uw@mail.gmail.com>
 <4881796E12491D4BB15146FE0209CE646802AACB@DE02WEMBXB.internal.synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <eb5f2a0a-72a4-683a-dfa4-0ff2ac45fbdb@synopsys.com>
Date: Tue, 6 Feb 2018 14:39:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4881796E12491D4BB15146FE0209CE646802AACB@DE02WEMBXB.internal.synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.10.161.84]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2018 01:04 PM, Alexey Brodkin wrote:
>> Feel free to drop this patch if you plan to submit the fix soon -
>> otherwise, apply it if it may take some time.
> No I think it worth applying especially in the light of your comment about NXP EEPROM.
>
> Vineet, could you please take this one?

I've added your Acked-by to patch and pushed to for-curr !

-Vineet
