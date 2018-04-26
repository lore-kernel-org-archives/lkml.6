Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756944AbeDZSBg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:01:36 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36738 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756881AbeDZSBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:01:34 -0400
X-Google-Smtp-Source: AB8JxZr5MpSq9AEDfqjWV313IQFfsCH9K+2H6UA9r9YJtAZasV6JvZ0KsAlQOl2aXNN7zr8PcQeMNQ==
Date: Thu, 26 Apr 2018 11:01:30 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Niklas Cassel <niklas.cassel@linaro.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] firmware: qcom: scm: Fix crash in
 qcom_scm_call_atomic1()
Message-ID: <20180426180130.GL18510@minitux>
References: <20180426115534.20971-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426115534.20971-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26 Apr 04:55 PDT 2018, Niklas Cassel wrote:

> qcom_scm_call_atomic1() can crash with a NULL pointer dereference at
> qcom_scm_call_atomic1+0x30/0x48.
> 

Hi Niklas,

The change has been picked up for v4.18, as you can see here:
https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=for-next

Regards,
Bjorn
