Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753820AbeDARco (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 13:32:44 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:39915
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753720AbeDARcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 13:32:42 -0400
X-YMail-OSG: 9vOvwUEVM1kapPbBmDS6XMki5q8zsCB.mu48keGH4_OfPXaUIMDQWbTCmALmkKu
 wGLWfBlD4hXNxuSsGDvNzJHv0fmR4UI0_InfJ2BYsXRimX3Z62mZZDKX9p2f3qynkwIcIfnpPop3
 Mt9VHHkKFh2CY9dU0DEGDNwqAWD0wobt5BhjheSjfCMYRHvgkumPczj0AhIpfVNMtseAxBPLfUFr
 am8J0_lYr4_tmjuUOuiBVDAUizjdAHY6UgiCHJ0WGvTp3ndLb33Xtq0Dd__GSBGF3OURp73uhBOO
 jFZombdFK0a5xKTsHXWSArmqhWYgDcA7efXGDFJRLmEOnJgtM1m38ajdMywPBcuw2oWVPiSERpVu
 CfEUe6_0orI7l9hyA3lJp6NPnExE2qhrEWe3_xUkb5Rm66JQN.s5auZtvHI8BxoYOUw9rf8kC1.E
 RdBm0r47IBqeiqyGzJqq7G01vgm2YdkFuH10DiJqTAol3XUp8M1nH_ngJRaAXy3KvM7R__nqCh0Z
 0JSN8Qzg58HoDsKYKIGPO3eQetLq21g--
Subject: Re: [PATCH 0/4] security: Split out hook definitions into
 lsm_hook_types.h
To: Sargun Dhillon <sargun@sargun.me>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp, keescook@chromium.org,
        igor.stoppa@huawei.com, jmorris@namei.org
References: <cover.1522577650.git.sargun@sargun.me>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <06c4e61e-399f-a1f8-bd45-a27d0eb4571b@schaufler-ca.com>
Date: Sun, 1 Apr 2018 10:32:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1522577650.git.sargun@sargun.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/2018 3:17 AM, Sargun Dhillon wrote:
> This moves all of the LSM hooks type information into a separate file,
> lsm_hook_types.h. This enables us to use this file, along with macros
> to generate the security_hook_heads struct, as well as the security
> hooks union without having to duplicate definitions.
>
> This will be useful for further datastructures which want to use
> the set of security hooks in a completely unrolled way, along
> with the type information there within.

Can you explain what this patch set is trying to accomplish?
I see no value. I see massive complexity. Why is this better
than what is there now?
