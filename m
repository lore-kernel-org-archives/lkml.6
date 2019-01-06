Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B10DC43444
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 09:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7522B218FD
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 09:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfAFJHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 04:07:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:58611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfAFJHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 04:07:47 -0500
Received: from [192.168.20.60] ([92.116.161.34]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBnSJ-1gYg0l2hMt-00Apin; Sun, 06
 Jan 2019 10:07:44 +0100
Subject: Re: [PATCH 0/2] parisc: Unify the system call scripts
To:     Firoz Khan <firoz.khan@linaro.org>, linux-parisc@vger.kernel.org
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org
References: <1546444953-21630-1-git-send-email-firoz.khan@linaro.org>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <d2b9fb1a-15b3-b2f9-9380-8ce9098c787a@gmx.de>
Date:   Sun, 6 Jan 2019 10:07:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1546444953-21630-1-git-send-email-firoz.khan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3o/IjxbzgBxeIM761yMc9rnFH6vMNj6utLM0CnjRGoNfl4BWcaV
 dV/crHyyS7ptLKe1ZyZ0Hy45C4CwbqlvLT6LQPnek8gHqs48U1lkO3W2FbZ1037vrFHe4hb
 6pNu2N9p4N3pDIZ2gi2D8Rf0Jw9Z08I3HIz7Lj9x+Rwd3KIrt6tddj9n/t5VdB2AX7nBccf
 YH3ESpmJFh78jY1l/kbFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:osPyddsNmnM=:JR/i1jEulCxjL4w9MW1z1F
 CgHfy2+cPMoYVo2AfKKpp/jt4L4kD8pUxhjQs/0V4Hd13uLWwTlTt3x2pNa3902SVxMKN50S3
 XKxIs9iHlIxfT216Bt5meK8bpY3NU9JiUyjjlK7J7hoMIsdtjb5uFiqcfMQhyXOAJQR5nZPkV
 G1BpC3hYkDjSdX2bFdXfsG2S6jjT7m1HuIZu3R1C8GfyKNjzBH60ZFa8PYZ6MjyFw3HdptB6T
 lCd/NW8qZy8mhkdAyfc1wA2ME1nBS64sKQKgmE7TNsCG/bohycht31VWR7xi0cNZV2ZlCKp/S
 533dGAxlCVO6VoLv8lns10g9VP0+EY1jX+7UuTzJ5UBWWurM4WF7n2APML9gKZD1j0DwZY4Bb
 0qbp078VW7zeXxvLMuGOSvsS602vYy557HttUZe3zQVQaMjVqeR27LzsQxZNUmg31IIzVqRzj
 TopyJZHoAc8ay5AHNRzYJRrye4zr/XznbjGzjczeSIabjTdMlBlUEPq8fVKipsE6pjuLil8aB
 gwNlsGgfURkXv3X2MWa9yGUFCKLV9Ko4vTWP3STI72KhVEwmcuno9CaUNjTegEdIjm2wYZSAh
 NKe8bINwlOk0fl8YWj4CxuMRgmGu1FkxdCjkKM6UoEpB3muyP4BDJGeXJcMGaDOnhRWwRyam7
 ImryQ6Dzs6rJzvlXaOH6hVcGyNxUxVBMOaDaQDjhmK8bi9XSO7ECvemZQ3xlbzjutJCfhOIvu
 rCvzbU5590BwsfRnGLPswLVv+y0ny0E3f6SGe/h1trPU5PLCH7JX+U1g4qwiS4V1PDwGoCs51
 W3JqPlhoDlI8ZA1uKM5kzjUpqkf3Dxcr9zRBqRov1vaRWCssknQH+F/MrtcVH4k7aHORs28NS
 wPDgLKSQ6GpHxpv/sP9uh5y+MokQarNYDPx6tGqxbfcAQopN8MqYQ6DWcdOwP7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.01.19 17:02, Firoz Khan wrote:
> System call table generation support is provided for
> alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
> sh, sparc and xtensa architectures. The implementat-
> ions are almost similar across all the above archte-
> ctures. In order to reduce the source code across all
> the above architectures, create common ".sh" files and
> keep it in the common directory, script/. This will 
> be a generic scripts which can use for all the above
> architectures.
> 
> This patch depends on;
>  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

Ok, this has to go upstream first...

> Firoz Khan (2):
>   parisc: remove nargs from __SYSCALL
>   parisc: generate uapi header and system call table files

Both patches seem OK, and I can then take them through the parisc
git tree when the patch above has reached upstream.

Thanks!
Helge

> 
>  arch/parisc/kernel/syscall.S              |  2 +-
>  arch/parisc/kernel/syscalls/Makefile      | 11 ++++++++--
>  arch/parisc/kernel/syscalls/syscallhdr.sh | 36 -------------------------------
>  arch/parisc/kernel/syscalls/syscalltbl.sh | 36 -------------------------------
>  4 files changed, 10 insertions(+), 75 deletions(-)
>  delete mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
>  delete mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh
> 

