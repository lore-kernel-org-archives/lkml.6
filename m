Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeDXWOQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:14:16 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33723 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeDXWOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:14:12 -0400
X-Google-Smtp-Source: AIpwx49pUzH/smw/409oFIlohFZ50WsBJCT0RFKj35l06//dgv74ia4D31fwjV36UwPYUUJNYpD5ug==
Date: Tue, 24 Apr 2018 15:14:09 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-scsi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-scsi-owner@vger.kernel.org
Subject: Re: [PATCH 3/3] scsi: ufs: Use freq table with devfreq
Message-ID: <20180424221409.GE18510@minitux>
References: <20180424002016.9205-1-bjorn.andersson@linaro.org>
 <20180424002016.9205-4-bjorn.andersson@linaro.org>
 <5e59150bf025e2caa1deadfec7293ecd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e59150bf025e2caa1deadfec7293ecd@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24 Apr 15:08 PDT 2018, Subhash Jadavani wrote:

> On 2018-04-23 17:20, Bjorn Andersson wrote:
> > devfreq requires that the client operates on actual frequencies, not
> > only 0 and UMAX_INT and as such UFS brok with the introduction of
> > f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency").
> > 
> > This patch registers the frequencies of the first clock with devfreq and
> > use these to determine if we're trying to step up or down.
> > 
[..]
> 
> Looks good to me.
> Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>
> 

Thanks Subhash. Unfortunately I need to respin this to register the opp
table based on our freq table, so there will be a v2 of this soon.

Regards,
Bjorn
