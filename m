Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeCWSpS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:45:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57714 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCWSpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:45:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F114602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [Intel-wired-lan] [PATCH v6 7/7] ixgbevf: eliminate duplicate
 barriers on weakly-ordered archs
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>, sulrich@codeaurora.org,
        Netdev <netdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1521829277-9398-1-git-send-email-okaya@codeaurora.org>
 <1521829277-9398-8-git-send-email-okaya@codeaurora.org>
 <CAKgT0UfCm4SJAhwyHKrHZnoJWKpp6-DWWVUb-YKgA2NTQhx=RA@mail.gmail.com>
 <cf6191c0-07cc-226b-d780-f488a0d7c779@codeaurora.org>
 <CAKgT0UeAJOdvqXfRw1xF+LnpGo3K7NQt_3DcJGUkiPMF+O8PTg@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <66c73568-460d-6e6f-5068-e5740757c2e9@codeaurora.org>
Date: Fri, 23 Mar 2018 14:45:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeAJOdvqXfRw1xF+LnpGo3K7NQt_3DcJGUkiPMF+O8PTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/2018 2:31 PM, Alexander Duyck wrote:
>> Please point me to the redundant ones.
> So from what I can tell only this file and i40e needed any additional
> mmiowb calls added. The rest are not needed.


Thanks, I'll clean up between 2..6 and then make your suggested changes
on 1 and 7.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
