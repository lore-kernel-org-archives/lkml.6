Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755454AbeDZTZn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:25:43 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45398 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755234AbeDZTZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:25:40 -0400
X-Google-Smtp-Source: AIpwx48g9nIXmfIM1VmFprhYc4grN4BcG9sETFHg7Bvb2/1xersxlKbNB/MQOYYsI4Jmuk01bailCA==
Date: Thu, 26 Apr 2018 21:25:36 +0200
From: Niklas Cassel <niklas.cassel@linaro.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] firmware: qcom: scm: Fix crash in
 qcom_scm_call_atomic1()
Message-ID: <20180426192536.GA28548@centauri>
References: <20180426115534.20971-1-niklas.cassel@linaro.org>
 <20180426180130.GL18510@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180426180130.GL18510@minitux>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 11:01:30AM -0700, Bjorn Andersson wrote:
> On Thu 26 Apr 04:55 PDT 2018, Niklas Cassel wrote:
> 
> > qcom_scm_call_atomic1() can crash with a NULL pointer dereference at
> > qcom_scm_call_atomic1+0x30/0x48.
> > 
> 
> Hi Niklas,
> 
> The change has been picked up for v4.18, as you can see here:
> https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=for-next

Hello Björn,

I just looked at today's linux-next tag: next-20180426.
I didn't bother to check Andy's tree.

Andy's for-next branch is included in linux-next, so it
will probably be included in tomorrow's linux-next tag.

Sorry for the noise.

Kind regards,
Niklas
