Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932179AbeCIPEU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:04:20 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36465 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbeCIPER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:04:17 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180309150414euoutp0217e6519c60c39e68acf2e93c67ae1b1f~aSMmFDeQC0673606736euoutp02i
X-AuditID: cbfec7f4-713ff700000043e4-af-5aa2a26cffbb
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Subject: Re: [PATCH 3/4] crypto: bcm: Constify *hash_alg_name[]
To: =?UTF-8?Q?Hern=c3=a1n_Gonzalez?= <hernan@vanguardiasur.com.ar>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        steven.lin1@broadcom.com, arvind.yadav.cs@gmail.com,
        colin.king@canonical.com, raveendra.padasalagi@broadcom.com,
        ray.jui@broadcom.com, scott.branden@broadcom.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-id: <0949d6d0-d62b-d724-f3ea-e7e86900fe3e@partner.samsung.com>
Date: Fri, 09 Mar 2018 16:04:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <1519768888-19866-3-git-send-email-hernan@vanguardiasur.com.ar>
Content-language: en-US
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djP87o5ixZFGbQe1bS41ruQ2eL36l42
        iznnW1gsul/JWDw4d5DZ4v69n0wWl3fNYbP41v6I1eLujxfsFjM39bFafH71jNWB22PW/bNs
        HrMaetk8tqy8yeSxc9Zddo9tB1Q9uo5cZ/P4vEkugD2KyyYlNSezLLVI3y6BK2PfyTVsBf94
        K/ov3WBpYNzH3cXIySEhYCIxffVati5GLg4hgRWMEnuO3oJyPjNKfNj0ig2mquXkNqjEMkaJ
        y3MmgiV4BQQlfky+xwJiMwtoSrz4MokFougZo8SKm7uYQRLCAvYS94/OYwdJiAjcY5I4tfUq
        O0iCTcBc4tH2M0wQk9wk5nXOALNZBFQlGi7uYgWxRQUiJBZOfcoIYnMK+Eg0nH0BtU1corn1
        JpQtL3HwynOwzRICz9kkXi7uhbrbReLQwVnMELawxKvjW9ghbBmJzo6DTBB2ucSmLWvZIZob
        GCXWvG9ihEhYSxw+fpEVYgOfxKRt04EGcQDFeSU62oQgSjwknhz7wAphO0rcfvEN7CAhgYeM
        Etdb+Scwys5CCqVZSKE0C8kPs5D8sICRZRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg
        6jn97/iXHYy7/iQdYhTgYFTi4d0xdVGUEGtiWXFl7iFGCQ5mJRHe9zVAId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rxxGnVRQgLpiSWp2ampBalFMFkmDk6pBkaWp7OvpGwM38R+9CvDg10/75uL
        XjtossfS7sGqQichgccLjU0KTGfoLK+WOThntkLTqguz7m54IreWY1NohnyNcgKXUO7DI5vY
        HFYe+C9wzmfrdCdV45CPHx1FrTM0tUz/7DV7nfVKMKCrfPUxKY5Ttw4Ez+oqZbUtPTK96vom
        06TLXp/Edv5QYinOSDTUYi4qTgQAGz7Z/jkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsVy+t/xq7rZixZFGTw5ImRxrXchs8Xv1b1s
        FnPOt7BYdL+SsXhw7iCzxf17P5ksLu+aw2bxrf0Rq8XdHy/YLWZu6mO1+PzqGasDt8es+2fZ
        PGY19LJ5bFl5k8lj56y77B7bDqh6dB25zubxeZNcAHsUl01Kak5mWWqRvl0CV8a+k2vYCv7x
        VvRfusHSwLiPu4uRk0NCwESi5eQ2ti5GLg4hgSWMErPW/GUCSfAKCEr8mHyPpYuRg4NZQF1i
        ypRciJpnjBLdj2+zgNQIC9hL3D86jx0kISJwj0li8dPNUJMeMkocbHwDNolNwFzi0fYzUFPd
        JOZ1zgCzWQRUJRou7mIFsUUFIiQ6V84Hm8op4CPRcPYFmM0sIC7R3HoTypaXOHjlOcsERv5Z
        SA6chXDgLCQds5B0LGBkWcUoklpanJueW2yoV5yYW1yal66XnJ+7iREYHduO/dy8g/HSxuBD
        jAIcjEo8vDumLooSYk0sK67MPcQowcGsJML7vgYoxJuSWFmVWpQfX1Sak1p8iFGag0VJnPe8
        QWWUkEB6YklqdmpqQWoRTJaJg1OqgdGQN2uP8BLpN9G7doVvSdWUz/nWky+3tmRXoOL6JUIX
        JCI/li+6X1BRfWR+9LXUxwd07tzc92nL5Y28+i+cz887/39zp09L5vveJSz6HTffmeW9seB4
        erKR47Fum7ZO3J0fc/JZOw5ozDTl4675OUeQPVSprvhKzMNUF++y/7pH9HMtxfh4piixFGck
        GmoxFxUnAgBGI85nigIAAA==
X-CMS-MailID: 20180309150411eucas1p2d0b4f413b1a81eb6262c8821d213ede6
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227220307epcas3p1ca4f0f8e178b7560f2105ca8b1bcef25
X-RootMTR: 20180227220307epcas3p1ca4f0f8e178b7560f2105ca8b1bcef25
References: <1519768888-19866-1-git-send-email-hernan@vanguardiasur.com.ar>
        <CGME20180227220307epcas3p1ca4f0f8e178b7560f2105ca8b1bcef25@epcas3p1.samsung.com>
        <1519768888-19866-3-git-send-email-hernan@vanguardiasur.com.ar>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.02.2018 23:01, Hernán Gonzalez wrote:
> Note: This is compile only tested.
> No gain from this except some self-documenting.
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  drivers/crypto/bcm/spu.c | 5 +++--
>  drivers/crypto/bcm/spu.h | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/bcm/spu.c b/drivers/crypto/bcm/spu.c
> index efaf3cf..c7bb79e 100644
> --- a/drivers/crypto/bcm/spu.c
> +++ b/drivers/crypto/bcm/spu.c
> @@ -23,8 +23,9 @@
>  #include "cipher.h"
>  
>  /* This array is based on the hash algo type supported in spu.h */
> -char *hash_alg_name[] = { "None", "md5", "sha1", "sha224", "sha256", "aes",

------------------------------------------------------------------------ ^^^

'aes' is not hash, so either remove 'aes' or change array name to crypto_alg_name

Or maybe I am missing something, or is it hardcoded in silicon ?

> -	"sha384", "sha512", "sha3_224", "sha3_256", "sha3_384", "sha3_512" };
> +char const * const hash_alg_name[] = { "None", "md5", "sha1", "sha224",
> +	"sha256", "aes", "sha384", "sha512", "sha3_224", "sha3_256", "sha3_384",
> +	"sha3_512" };
>  
>  /* Assumes SPU-M messages are in big endian */
>  void spum_dump_msg_hdr(u8 *buf, unsigned int buf_len)
> diff --git a/drivers/crypto/bcm/spu.h b/drivers/crypto/bcm/spu.h
> index f252367..71cf6b5 100644
> --- a/drivers/crypto/bcm/spu.h
> +++ b/drivers/crypto/bcm/spu.h
> @@ -111,7 +111,7 @@ enum aead_type {
>  	AEAD_TYPE_LAST
>  };
>  
> -extern char *hash_alg_name[HASH_ALG_LAST];
> +extern const char * const hash_alg_name[HASH_ALG_LAST];
>  
>  struct spu_request_opts {
>  	bool is_inbound;
> 

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland
