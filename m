Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeDZC2T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 22:28:19 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:46683 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbeDZC2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:28:17 -0400
X-Google-Smtp-Source: AIpwx4+uMtBUFbeNP0jMg9+CYZ39kuyThMO0eKpZBDJqVQn2YAl3DWv0XaZVYE0eTIVGbT8LwSNbWA==
Date: Thu, 26 Apr 2018 10:28:09 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_jit_enable = 2 with
 BPF_JIT_ALWAYS_ON config
Message-ID: <20180426022809.GD28567@leoy-ThinkPad-X240s>
References: <1524644322-9263-1-git-send-email-leo.yan@linaro.org>
 <a90e398e-c012-2630-6909-6d413e03cc96@iogearbox.net>
 <20180425092547.GA24401@leoy-ThinkPad-X240s>
 <20180425141435.bvolztivms25y2vt@ast-mbp>
 <77bce91b-8d92-3be2-e4d1-abbb7f4cc2dd@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77bce91b-8d92-3be2-e4d1-abbb7f4cc2dd@iogearbox.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 05:37:39PM +0200, Daniel Borkmann wrote:
> On 04/25/2018 04:14 PM, Alexei Starovoitov wrote:
> > On Wed, Apr 25, 2018 at 05:25:47PM +0800, Leo Yan wrote:
> >>
> >> If we have concern for security issue, should we remove support for
> >> 'bpf_jit_enable = 2' and modify the doc to reflect this change?
> > 
> > I suggest to fix the doc.
> 
> Agree, lets do that instead. Leo, could you cook a patch for that?

Sure, have sent new patch for this.

Thanks for suggestion!

> Thanks,
> Daniel
