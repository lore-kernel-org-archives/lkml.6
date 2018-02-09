Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753078AbeBIOKs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:10:48 -0500
Received: from mout.web.de ([212.227.17.11]:52719 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752086AbeBIOKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:10:45 -0500
To: cocci@systeme.lip6.fr, Julia Lawall <julia.lawall@lip6.fr>
References: <1518094434-12852-1-git-send-email-Julia.Lawall@lip6.fr>
Subject: Re: scripts/coccinelle/misc/shift.cocci: Refactoring?
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <a241776d-85bf-cbf1-067b-fbd0b80c0e5e@users.sourceforge.net>
Date: Fri, 9 Feb 2018 15:10:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518094434-12852-1-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:XQwnOoYNdXPOiyuhX3h1nZPTruHR8EdBXD9zt7D0qrSS2Zdvi+k
 KIOkrnarafSFVu3vKJ5jv+b0pjakyzBQ83we150G7qbi8E7Ni8MmTBIZfi2re/RmZW4iZ5M
 srTvV2pbOjyBiLETFsXpvGyvKSBhh1Z/VL8GnWjrwL9qzegjtp00P+tI5/C/Y2e1kxACYYB
 yZ9TCFFs6VEQDsI4+dI9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s0xL8Ohyb4c=:cyFMSnSfkW+WUhSZ/nxfT8
 VijayZNpC1wFU+2cIPPUbGFJvr7thBqPwy/XNeYG3OscfkvzL/0Y68rGcO4J0bP0IHVLI2Yiy
 vt1SY8zAybQjJeQDxckrtkyc2W9dX7DIyDnqHQDUA/JWu4sq7EylsgtUTiqapfgLKa7PVibEp
 IzvyKpyriIf08rKFcwEZZLrfHJFacCAtGxG02+HrEttDPYfju7w97TSNjAZ9NVdhpbBpKH4rl
 ThFvWw/D86ViJOJuqr585vTPeEBDk0CI6+ev3dTP4MC9aYXm8WgxRtpKtLTmWj1yRfVs/h86W
 bRhVtiN+IpfXvHc1lQCVBWZ5ecOjxKCyenq67RhB4ZHTS1fvEVu9OePspcEKwxBNUoex1EARE
 8z4C/XdEFubiW/I0Qm5F1x1VaAIYO/f+TMVTAAOzlihkHRBaFSatknEE7JIsXX8JxfBhtjRN1
 TyNMeVYstxDIjI6ZnsG4I4q1JHhaPKwr9J3TISQ4VPB6Kf0kqBUpVZvk9cmeLG4H2uOnyhP0R
 q1lpwj8dSUQO0YGUbstjjbdw+9b3Gc0yZs6ebW5Qbs+66rSNh6nt3rbc3lD25YUyerMpqGcTa
 D8ns6yquVmmpR34VgErci8wC11HNCY3tJz3oh/3tc+Pqfpi/tPYi6Nc1+gRk3YRN1EF5NUwWf
 hH8YSb44Soo4HDuX1m3i68+NYAiptWRIJppDEq1/nz9lvVi6JIOrl8sRsEr+vNAav2eBOhBWS
 cMDGl/Qv4BYZhb1KbOf9t19lDDJoFkPq4wNvoYImMRr/RQwIM+7CHpFSrr5tj5h9eP8PWk5C/
 PTJPYsvoxgFet+3BKxegTwNvvuJrJGW7sh8H1i0vgbltOU4V4M=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +|
> +WARN_ON(x op@p y)
> +|
> +WARN_ON_ONCE(x op@p y)
> +|

Can it be nice to work with nested SmPL disjunctions so that a bit of
duplicate SmPL code will be reduced?


> +coccilib.org.print_todo(j0[0], msg)

Will it be nicer to pass a string literal instead of a variable for the message
as a method parameter?

Regards,
Markus
