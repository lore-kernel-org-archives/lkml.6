Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4BEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74FE2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfAHHoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:44:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:58207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHHoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:44:09 -0500
Received: from [10.16.37.249] ([155.56.44.137]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LrJTs-1hPyh62Bie-0132K9; Tue, 08
 Jan 2019 08:44:04 +0100
Subject: Re: [PATCH] parisc: remove meaningless ccflags-y in
 arch/parisc/boot/Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1546929918-27235-1-git-send-email-yamada.masahiro@socionext.com>
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
Message-ID: <98c37856-16e5-4c90-bd7e-d635ab33871a@gmx.de>
Date:   Tue, 8 Jan 2019 08:44:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546929918-27235-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hKOeBOvuQrT5Zh3nlQMdY2C8JToNig+QbicYkFVglnFIygdRL2z
 wxKT9usN4iOUqwbkWLzos1quTN0/AWhO6qlE8hr6yCbEcx9smJCOoWv/966sMKGeL5DBGKu
 VQgWm4DKl269pBVqrLMwvEdrfCNp3NhaA6QEs0JSejTKVGxmxxO+04EQ+yVMK2aq/LKGq/A
 ygixTpyRfjgzPueKv3PKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y9m81JuoHj0=:ZbqWuvkQSNevIAOkE73+Jt
 8r6XHCf9+6ZhMJRKtpNUpRKxFRlsxKO4qAwZkSnKDwhTIXmWtW7Fl03rHr4qx2Oj5KX9BeVqA
 f9HDfzTeUNlGwgmnoPHo62pMTE0A2oLc49CcZEh8x2tu+Pw9yspSJb9ZGaVE1UFaOIjC0Sp+t
 k0hSCXiJJ7rrVbg7Nt+aZUmLGkfHYqsWTyyXLlGzlSfD2xusMoNFa20+0EacgZJe5adVVx0hs
 33rNNW8xXp0GsxZRz55ecwzwV8Y3Ynajg2CnhJRdpnyYNwmSEh/a3UiQeSn3suFR6pSZurctT
 PuMoEcZxlcAdbSLfGpf85MLztjj9e9XS5r/cNmTO8UJ/lo4bWMfSPtkDLP7erm5g/UUJHJs0z
 eKanD8DCpldl5tiNyWvRMr/gSB5C9cBRvvlKa1KPAzICdAvN8V9WwCRQVhOBTFe6ug/fLqgr9
 iVGmJjL5EB4eQDnXTZPthi9Nou/L9ia14mmmziLYQOj6Jf4+qGT3UZVvB2y50u4y5ocnNNXPN
 vsCGPhuYEHq9UJJP00Q7c++g/Z0nXWfmdpuuCe/nwqexoPr6N/UOXfRamiMoJEdrK2h67lY9/
 cZ2DkNht/sqHQ80377l5NSY6wuMr0q1fsJsujxE4Csq3NpYUcHKG39UdpwBgvqWxGswfYV5zG
 1MwuoRera3/IQsK2Ca0phqDtDQpWJ9Irqth6+X+XXfT2ep7NOklKL5hK7jkQnqjHje4FfAwxe
 dBhZ1MQWKneUr0l2FCbUuWBz8v8SMFgqi2CzNk4l+FZA6mBST/mumk1NhR7oQA0T0onqEyfm8
 bh3CsbbwgtBHYF5yalBGBK2ihhDvo8AuWYgg2uY2gN+4J1W1jWJ1ao3cqdo84JUVJwAMZIwz9
 +mt3xeQG8hl7NCidO7Cvw3ovjRg6NZ+PtO/00nFr+4iZgDL6LbjoEP2rPAlQudf74NQgV08Kl
 fexXzaldPkq6V2hhKl7WgnM7L4XTQOrnJh/P+CorS/iUq9KMmhzlm/xWbHRzZpLZLzKuBopgp
 DQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.01.19 07:45, Masahiro Yamada wrote:
> This ccflags-y is never used because arch/parisc/boot/Makefile
> only contains objcopy and install targets.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I've added this patch to the parisc for-next tree.

Thanks,
Helge

> ---
> 
>  arch/parisc/boot/Makefile | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/parisc/boot/Makefile b/arch/parisc/boot/Makefile
> index cad68a5..41cce07 100644
> --- a/arch/parisc/boot/Makefile
> +++ b/arch/parisc/boot/Makefile
> @@ -2,12 +2,6 @@
>  # Makefile for the linux parisc-specific parts of the boot image creator.
>  #
>  
> -COMPILE_VERSION := __linux_compile_version_id__`hostname |  \
> -			tr -c '[0-9A-Za-z]' '_'`__`date | \
> -			tr -c '[0-9A-Za-z]' '_'`_t
> -
> -ccflags-y  := -DCOMPILE_VERSION=$(COMPILE_VERSION) -gstabs -I.
> -
>  targets := image
>  targets += bzImage
>  subdir- := compressed
> 

