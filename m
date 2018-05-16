Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeEPSJB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:09:01 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37051 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeEPSI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:08:59 -0400
X-Google-Smtp-Source: AB8JxZrdncw50xBxAzKuoY+p3PUEDyNnc5b0v2A2UGcl2mzIIHpldKy5nge21nj4QBwPFtw8aHnVpA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: rishabhb@codeaurora.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <385198cbb91c4a36ad758997916ad271@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm@lists.infradead.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, evgreen@chromium.org, robh@kernel.org
References: <1525810921-15878-1-git-send-email-rishabhb@codeaurora.org>
 <1525810921-15878-2-git-send-email-rishabhb@codeaurora.org>
 <152649021310.210890.14841324536807182632@swboyd.mtv.corp.google.com>
 <385198cbb91c4a36ad758997916ad271@codeaurora.org>
Message-ID: <152649413707.210890.2655572242392552759@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 1/2] dt-bindings: Documentation for qcom, llcc
Date: Wed, 16 May 2018 11:08:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GI96IT025953

Quoting rishabhb@codeaurora.org (2018-05-16 10:33:14)
> On 2018-05-16 10:03, Stephen Boyd wrote:
> > Quoting Rishabh Bhatnagar (2018-05-08 13:22:00)
> 
> >> +
> >> +- max-slices:
> >> +       usage: required
> >> +       Value Type: <u32>
> >> +       Definition: Number of cache slices supported by hardware
> >> +
> >> +Example:
> >> +
> >> +       llcc: qcom,llcc@1100000 {
> > 
> > cache-controller@1100000 ?
> > 
> We have tried to use consistent naming convention as in llcc_* 
> everywhere.
> Using cache-controller will mix and match the naming convention. Also in
> the documentation it is explained what llcc is and its full form.
> 

DT prefers standard node names as opposed to vendor specific node names.
Isn't it a cache controller? I fail to see why this can't be done.
