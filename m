Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeBXBid (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 20:38:33 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:47490 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeBXBia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 20:38:30 -0500
Subject: Re: [PATCH v2 2/3] ARC: mcip: update MCIP debug mask when the new cpu
 came online
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
References: <20180223164154.22377-1-Eugeniy.Paltsev@synopsys.com>
 <20180223164154.22377-2-Eugeniy.Paltsev@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <476ba7d8-5877-4966-f2a2-08ce01531bb9@synopsys.com>
Date: Fri, 23 Feb 2018 17:37:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223164154.22377-2-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.10.161.84]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 08:42 AM, Eugeniy Paltsev wrote:
> As of today we use hardcoded MCIP debug mask, so if we launch
> kernel via debugger and kick fever cores than HW has all cpus
> hang at the momemt of setup MCIP debug mask.
>
> So update MCIP debug mask when the new cpu came online, instead of
> use hardcoded MCIP debug mask.
>
> Signed-off-by: Eugeniy Paltsev<Eugeniy.Paltsev@synopsys.com>

Acked-by: Vineet Gupta <vgupta@ynopsys.com>
